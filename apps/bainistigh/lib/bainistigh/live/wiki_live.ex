defmodule Bainistigh.WikiLive do
  use Bainistigh, :live_view

  alias Taifead.Wiki

  def handle_event("save", %{"article" => params}, socket) do
    case Wiki.create_article(params) do
      {:ok, article} ->
        {:noreply, assign(socket, article: article, changeset: Wiki.change_article(article))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("validate", %{"article" => params}, socket) do
    article = %Wiki.Article{}
    {:noreply, assign(socket, changeset: Wiki.change_article(article, params))}
  end

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  def mount(_params, _session, socket) do
    changeset = Wiki.change_article(%Wiki.Article{})
    {:ok, assign(socket, changeset: changeset, page_title: "Wiki")}
  end

  def render(assigns) do
    Phoenix.View.render(Bainistigh.WikiView, "index.html", assigns)
  end
end
