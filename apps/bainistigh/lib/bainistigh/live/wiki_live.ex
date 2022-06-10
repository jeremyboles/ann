defmodule Bainistigh.WikiLive do
  use Bainistigh, :live_view

  import Bainistigh.CommonComponent

  alias __MODULE__.Component

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :draft, nil)}
  end
end
