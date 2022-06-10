defmodule Bainistigh.WikiLive.BreadcrumbsComponent do
  use Bainistigh, :live_component

  def update(assigns, socket) do
    {:ok, assign(socket, ancestors: [], draft: assigns.draft)}
  end
end
