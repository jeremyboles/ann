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

  def handle_event("save", %{"article" => article_params, "revision" => revision_params}, socket) do
    case save(socket.assigns.article, article_params, revision_params) do
      {:ok, article} ->
        socket =
          assign(socket,
            article: article,
            articles: Wiki.ordered_articles(),
            changeset: Wiki.change_article(article),
            page_title: page_title(article)
          )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("validate", %{"article" => params}, socket) do
    article = socket.assigns.article
    {:noreply, assign(socket, changeset: Wiki.change_article(article, params))}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    article = Wiki.get_article!(id)

    socket =
      assign(socket,
        article: article,
        changeset: Wiki.change_article(article),
        page_title: page_title(article)
      )

    {:noreply, socket}
  end

  def handle_params(_params, _url, socket) do
    socket =
      assign(socket,
        article: nil,
        changeset: Wiki.change_article(%Wiki.Article{tags: []}),
        page_title: page_title(nil)
      )

    {:noreply, socket}
  end

  def mount(_params, _session, socket) do
    articles = Wiki.ordered_articles()
    {:ok, assign(socket, articles: articles)}
  end

  def render(assigns) do
    Phoenix.View.render(Bainistigh.WikiView, "index.html", assigns)
  end

  defp add_tag(changeset = %Ecto.Changeset{}) do
    tags = changeset.changes |> Map.get(:tags, [])
    tags = if !Enum.any?(tags, &(&1 === "")), do: Enum.concat(tags, [""]), else: tags
    Ecto.Changeset.change(changeset, tags: tags)
  end

  defp page_title(%Wiki.Article{title_text: title}), do: "#{title} - Wiki"
  defp page_title(_), do: "New Article - Wiki"

  def save(nil, article_params, revision_params) do
    Wiki.create_article(article_params, revision_params)
  end

  def save(article, article_params, revision_params) do
    Wiki.update_article(article, article_params, revision_params)
  end
end
