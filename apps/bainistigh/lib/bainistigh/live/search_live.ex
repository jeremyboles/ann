defmodule Bainistigh.SearchLive do
  use Bainistigh, :live_view

  import Bainistigh.CommonComponent

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  def mount(_params, _session, socket), do: {:ok, assign(socket, page_title: "Search")}

  def render(assigns) do
    ~H"""
      <.section_header>Search</.section_header>
    """
  end
end
