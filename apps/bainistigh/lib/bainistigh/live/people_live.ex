defmodule Bainistigh.PeopleLive do
  use Bainistigh, :live_view

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  def mount(_params, _session, socket), do: {:ok, assign(socket, page_title: "Media")}

  def render(assigns) do
    ~H"""
      <section>
        <header>People</header>
      </section> 
    """
  end
end
