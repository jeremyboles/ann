defmodule Bainistigh.WikiLive do
  use Bainistigh, :live_view

  import Bainistigh.CommonComponent
  import Bainistigh.WikiComponent

  alias Taifead.Wiki

  def handle_event("add-group", %{"kind" => "glossary"}, socket) do
    term = %{definition: "", term: ""}
    group = %{kind: :glossary, terms: [term], title: "Glossary of Terms"}
    groups = [group | Ecto.Changeset.fetch_field!(socket.assigns.changeset, :supplemental_groups)]
    changeset = Ecto.Changeset.put_assoc(socket.assigns.changeset, :supplemental_groups, groups)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("add-group", %{"kind" => "links"}, socket) do
    link = %{title: "Jeremy Boles", url: "https://jeremyboles.com/"}
    group = %{kind: :links, links: [link], title: "External Links"}
    groups = [group | Ecto.Changeset.fetch_field!(socket.assigns.changeset, :supplemental_groups)]
    changeset = Ecto.Changeset.put_assoc(socket.assigns.changeset, :supplemental_groups, groups)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"_delete" => id}, socket) do
    case socket.assigns.article do
      %Wiki.Article{id: ^id} = article ->
        Wiki.delete_article(article)

        socket =
          assign(socket,
            article: nil,
            articles: Wiki.ordered_articles(),
            changeset: Wiki.change_article(%Wiki.Article{}),
            page_title: page_title(article)
          )

        {:noreply, push_redirect(socket, to: "/wiki")}

      _ ->
        {:noreply, socket}
    end
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

        {:noreply, push_redirect(socket, to: "/wiki/#{article.id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("validate", %{"article" => params}, socket) do
    {:noreply, assign(socket, changeset: Wiki.change_article(%Wiki.Article{}, params))}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    article =
      Wiki.get_article!(id)
      |> Taifead.Repo.preload([:revisions, supplemental_groups: [:links, :terms]])

    {:noreply, assign_article(socket, article)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, assign_article(socket, nil)}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :editor_sidebar_visible, true)}
  end

  defp assign_article(socket, nil) do
    changeset = Wiki.change_article(%Wiki.Article{})
    assign(socket, article: nil, changeset: changeset, page_title: "New Article - Wiki")
  end

  defp assign_article(socket, %Wiki.Article{title_text: title} = article) do
    changeset = Wiki.change_article(article)
    assign(socket, article: article, changeset: changeset, page_title: "#{title} - Wiki")
  end

  defp page_title(%Wiki.Article{title_text: title}), do: "#{title} - Wiki"
  defp page_title(_), do: "New Article - Wiki"

  defp save(nil, article_params, revision_params) do
    Wiki.create_article(article_params, revision_params)
  end

  defp save(article, article_params, revision_params) do
    Wiki.update_article(article, article_params, revision_params)
  end
end
