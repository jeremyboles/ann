defmodule Bainistigh.WikiLive do
  use Bainistigh, :live_view

  alias Taifead.Wiki

  def handle_event("add-tag", _, socket) do
    changeset = add_tag(socket.assigns.changeset)
    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("modify-tags", %{"key" => "Enter", "value" => ""}, socket) do
    {:noreply, socket}
  end

  def handle_event("modify-tags", %{"key" => "Enter"}, socket) do
    changeset = add_tag(socket.assigns.changeset)
    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("modify-tags", params = %{"key" => "Backspace", "value" => ""}, socket) do
    {index, _} = Integer.parse(params["index"])

    tags =
      socket.assigns.changeset.changes
      |> Map.get(:tags)
      |> List.delete_at(index)

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.change(tags: tags)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("modify-tags", params, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end

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

  def handle_params(params, _url, socket) do
    {:noreply, assign(socket, id: params["id"])}
  end

  def mount(params, _session, socket) do
    articles = Wiki.list_articles()
    changeset = Wiki.change_article(%Wiki.Article{tags: []})

    socket =
      assign(socket,
        articles: articles,
        changeset: changeset,
        id: params["id"],
        page_title: "Wiki"
      )

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(Bainistigh.WikiView, "index.html", assigns)
  end

  defp add_tag(changeset = %Ecto.Changeset{}) do
    tags = changeset.changes |> Map.get(:tags, [])
    tags = if !Enum.any?(tags, &(&1 === "")), do: Enum.concat(tags, [""]), else: tags
    Ecto.Changeset.change(changeset, tags: tags)
  end
end
