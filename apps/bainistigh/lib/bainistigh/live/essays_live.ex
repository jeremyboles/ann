defmodule Bainistigh.EssaysLive do
  use Bainistigh, :live_view

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  def mount(_params, _session, socket), do: {:ok, assign(socket, page_title: "Essays")}

  def render(assigns) do
    ~H"""
      <section>
        <header>Essays</header>
      </section> 
    """
  end
end
