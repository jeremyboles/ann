defmodule Reathai do
  @moduledoc false

  use Supervisor

  # Client API

  def call(name, [mod]), do: call(name, [mod, "default", []])
  def call(name, [mod, func]) when is_bitstring(func), do: call(name, [mod, func, []])
  def call(name, [mod, args]) when is_list(args), do: call(name, [mod, "default", args])

  def call(name, [mod, func, args]) do
    func = fn pid ->
      GenServer.call(pid, {:func, [mod, func, args]})
    end

    :poolboy.transaction(Module.concat(name, Pool), func)
  end

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: Keyword.get(opts, :name))
  end

  def stop(), do: Supervisor.stop(__MODULE__)

  # Callbacks

  @impl true
  def init(opts) do
    name = Keyword.get(opts, :name) |> Module.concat(Pool)

    poolboy_opts = [
      max_overflow: 2,
      name: {:local, name},
      size: 5,
      worker_module: Reathai.Worker
    ]

    children = [
      :poolboy.child_spec(name, poolboy_opts, opts)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
