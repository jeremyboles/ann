defmodule Reathai.Worker do
  @moduledoc false

  use GenServer

  @chunk_size 65_536
  @node_path System.find_executable("node")
  @timeout 30_000

  # Client API

  def call(server, [mod]), do: call(server, [mod, "default", []])
  def call(server, [mod, func]) when is_bitstring(func), do: call(server, [mod, func, []])
  def call(server, [mod, args]) when is_list(args), do: call(server, [mod, "default", args])

  def call(server, [mod, func, args]) do
    GenServer.call(server, {:func, [mod, func, args]}, @timeout)
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, Keyword.get(opts, :cd))
  end

  # Callbacks

  @impl true
  def init(dir) do
    args = [
      "--experimental-json-modules",
      "--no-warnings",
      Path.join(:code.priv_dir(:reathai), "runner.mjs")
    ]

    env = [
      {'CHUNK_SIZE', String.to_charlist("#{@chunk_size}")},
      {'NODE_PATH', String.to_charlist(dir)}
    ]

    {:ok, Port.open({:spawn_executable, @node_path}, args: args, env: env, line: @chunk_size)}
  end

  @impl true
  def handle_call({:func, [mod, func, args]}, _from, port) do
    body = Jason.encode!(%{"args" => args, "functionName" => func, "moduleName" => mod})
    Port.command(port, "#{body}\n")
    resp = read!()

    {:reply, {:ok, Jason.decode!(resp)}, port}
  end

  @impl true
  def terminate(_reason, port) do
    Port.close(port)
  end

  # Private functions

  defp read(data) do
    receive do
      {_, {:data, {:eol, chunk}}} ->
        {:ok, data ++ chunk}

      {_, {:data, {:noeol, chunk}}} ->
        read(data ++ chunk)

      unknown ->
        {:error, unknown}
    after
      @timeout -> {:error, :timeout}
    end
  end

  def read!(data \\ '') do
    case read(data) do
      {:ok, resp} -> resp
      error -> error
    end
  end
end
