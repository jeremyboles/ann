defmodule Bainistigh.DashboardLive do
  use Bainistigh, :live_view

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  def mount(_params, _session, socket), do: {:ok, assign(socket, page_title: "Dashboard")}

  def render(assigns) do
    ~H"""
      <section class="section-header">
        <header>Dashboard</header>
      </section> 
    """
  end
end
