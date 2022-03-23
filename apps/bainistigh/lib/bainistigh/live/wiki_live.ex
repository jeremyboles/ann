defmodule Bainistigh.WikiLive do
  use Bainistigh, :live_view

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  def mount(_params, _session, socket), do: {:ok, assign(socket, page_title: "Wiki")}

  def render(assigns) do
    Phoenix.View.render(Bainistigh.WikiView, "index.html", assigns)
  end
end

