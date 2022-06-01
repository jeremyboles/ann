defmodule Bainistigh.WikiLive.BreadcrumbsComponent do
  use Bainistigh, :live_component

  alias Taifead.Wiki

  def update(assigns, socket) do
    ancestors = Wiki.article_ancestors(assigns.article)
    socket = socket |> assign(assigns) |> assign(:ancestors, ancestors)
    {:ok, socket}
  end
end
