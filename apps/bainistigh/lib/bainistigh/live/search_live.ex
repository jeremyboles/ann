defmodule Bainistigh.SearchLive do
  use Bainistigh, :live_view

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  def mount(_params, _session, socket), do: {:ok, assign(socket, page_title: "Search")}

  def render(assigns) do
    ~H"""
      <section class="section-header">
        <header>Search</header>
      </section> 
    """
  end
end
