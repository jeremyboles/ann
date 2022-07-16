defmodule Taifead.Topics do
  import Ecto.Query, warn: false
  import Ecto.Changeset, only: [change: 2, put_change: 3, put_embed: 3]

  alias Ecto.Multi
  alias Taifead.Repo
  alias Taifead.Topics.{Appendix, Draft, Link, Publication, Term}

  def ancestors(%Publication{} = publication) do
    publication |> Publication.ancestors() |> Repo.all()
  end

  def add_appendix(%Draft{appendices: appendices} = draft, %Appendix{} = appendix) do
    draft |> change_draft() |> put_embed(:appendices, [appendix | appendices]) |> Repo.update() |> broadcast(:draft_updated)
  end

  def add_appendix(%Draft{} = draft, _kind = :glossary) do
    appendix = %Appendix{kind: :glossary, terms: [%Term{title: "", definition: ""}], title: "Glossary of Terms"}
    add_appendix(draft, appendix)
  end

  def add_appendix(%Draft{} = draft, _kind = :links) do
    appendix = %Appendix{kind: :links, links: [%Link{title: "", url: ""}], title: "External Links"}
    add_appendix(draft, appendix)
  end

  def add_to_appendix(%Draft{appendices: appendices} = draft, %Appendix{id: id, kind: :glossary} = appendix) do
    terms = appendix.terms ++ [%Term{definition: "", title: ""}]
    appendix = appendix |> Appendix.changeset(%{}) |> put_embed(:terms, terms)
    changeset = appendices |> replace_when(&(&1.id == id), appendix)
    draft |> change_draft() |> put_embed(:appendices, changeset) |> put_change(:status, :changed) |> Repo.update() |> broadcast(:draft_updated)
  end

  def add_to_appendix(%Draft{appendices: appendices} = draft, %Appendix{id: id, kind: :links} = appendix) do
    links = appendix.links ++ [%Link{title: "", url: ""}]
    appendix = appendix |> Appendix.changeset(%{}) |> put_embed(:links, links)
    changeset = appendices |> replace_when(&(&1.id == id), appendix)
    draft |> change_draft() |> put_embed(:appendices, changeset) |> put_change(:status, :changed) |> Repo.update() |> broadcast(:draft_updated)
  end

  def add_to_appendix(%Draft{appendices: appendices} = draft, id) do
    draft |> add_to_appendix(Enum.find(appendices, &(&1.id == id)))
  end

  def change_draft(%Draft{} = draft, attrs \\ %{}), do: Draft.changeset(draft, attrs)

  def change_publication(%Publication{} = publication, attrs \\ %{}), do: Publication.changeset(publication, attrs)

  def create_draft(attrs \\ %{}) do
    %Draft{} |> Draft.changeset(attrs) |> Repo.insert() |> broadcast(:draft_created)
  end

  def current_publications() do
    Repo.all(from(p in Publication, distinct: p.draft_id, where: [latest: true]))
  end

  def delete_draft(%Draft{} = draft), do: Repo.delete(draft) |> broadcast(:draft_deleted)

  def descendants(%Publication{} = publication) do
    publication |> Publication.descendants() |> Repo.all()
  end

  def get_draft!(id), do: Repo.get!(Draft, id)

  def get_publication!(id), do: Repo.get!(Publication, id)

  def get_published!(nil), do: nil

  def get_published!(id) do
    query = from d in Draft, where: d.id == ^id, join: p in Publication, on: p.draft_id == d.id, select: p, where: p.latest == true
    query |> Repo.one()
  end

  def get_published_by_slug!(url_slug) do
    query = from p in Publication, limit: 1, where: [latest: true, url_slug: ^url_slug]

    query
    |> Repo.one()
    |> Repo.preload(draft: :publications)
  end

  def links_from(%Publication{doc: doc}) do
    matches = ~r["href":"/(\w+)/"] |> Regex.scan(Jason.encode!(doc)) |> Enum.map(fn [_, slug] -> slug end)
    Repo.all(from p in Publication, where: p.url_slug in ^matches and p.latest == true)
  end

  def links_to(%Publication{url_slug: url_slug}) do
    Repo.all(from p in Publication, where: fragment("?::text LIKE '%/'||?||'/%'", p.doc, ^url_slug) and p.latest == true)
  end

  def list_drafts, do: Repo.all(Draft) |> Repo.preload(:publications)

  def latest_draft do
    Repo.one(from d in Draft, limit: 1, order_by: [desc: d.updated_at])
  end

  def latest_publication do
    Repo.one(from p in Publication, limit: 1, order_by: [desc: p.updated_at])
  end

  def locations(eps \\ 2) do
    %{rows: rows} =
      Repo.query!("""
        SELECT ST_Centroid(ST_Collect(coords)) AS coords, array_agg(id) AS ids, array_agg(inserted_at) AS dates FROM (
          SELECT id, inserted_at, ST_ClusterDBSCAN(coords, eps := #{eps}, minpoints := 1) OVER () AS cid, coords FROM topic_publications
        ) AS sq GROUP BY cid;
      """)

    rows
    |> Enum.sort_by(fn [_, _, dates] -> latest(dates) end, :desc)
    |> Enum.map(fn [coords, _, _] -> coords end)
  end

  def publish(%Draft{} = draft, attrs \\ %{}) do
    attributes = draft |> Map.from_struct() |> Map.drop([:__meta__, :id, :inserted_at, :path, :publications, :updated_at])
    publication_changeset = draft |> Ecto.build_assoc(:publications, attributes) |> change_publication(attrs) |> put_path_change(draft)
    draft_changeset = draft |> change_draft() |> put_change(:status, :live)

    Multi.new()
    |> Multi.one(:previous_id, from(p in Publication, select: p.id, where: [draft_id: ^draft.id, latest: true]))
    |> Multi.update(:draft, draft_changeset)
    |> Multi.update_all(:unmark_live, from(p in Publication, where: p.draft_id == ^draft.id), set: [latest: false])
    |> Multi.insert(:publication, publication_changeset)
    |> Multi.update_all(
      :paths,
      fn
        %{previous_id: previous_id, publication: publication} when not is_nil(previous_id) ->
          {:ok, previous_id} = Hierarch.Ecto.UUIDLTree.dump(previous_id)

          {:ok, next_id} = Hierarch.Ecto.UUIDLTree.dump(publication.id)
          from(p in Publication, update: [set: [path: fragment("text2ltree(REPLACE(ltree2text(?), ?, ?))", p.path, ^previous_id, ^next_id)]])

        # Figure out a better way to do a noop
        _ ->
          from(p in Publication, update: [set: [updated_at: nil]], where: is_nil(p.id))
      end,
      []
    )
    |> Repo.transaction()
    |> broadcast(:draft_updated)
  end

  def replace_publication(%Draft{} = draft) do
    attributes = draft |> Map.from_struct() |> Map.drop([:__meta__, :id, :inserted_at, :path, :publications, :status, :updated_at])
    draft_changeset = draft |> change_draft() |> put_change(:status, :live)

    Multi.new()
    |> Multi.update(:draft, draft_changeset)
    |> Multi.one(:latest, from(p in Publication, where: [draft_id: ^draft.id, latest: true]))
    |> Multi.update(:publication, fn %{latest: publication} ->
      publication |> change_publication() |> change(attributes)
    end)
    |> Repo.transaction()
    |> broadcast(:draft_updated)
  end

  def remove_appendix(%Draft{appendices: appendices} = draft, id) do
    draft |> change_draft() |> put_embed(:appendices, Enum.filter(appendices, &(&1.id != id))) |> Repo.update() |> broadcast(:draft_updated)
  end

  def remove_from_appendix(%Draft{appendices: appendices} = draft, %Appendix{id: appendix_id, kind: :glossary} = appendix, id) do
    terms = Enum.filter(appendix.terms, &(&1.id != id))
    appendix = appendix |> Appendix.changeset(%{}) |> put_embed(:terms, terms)
    changeset = appendices |> replace_when(&(&1.id == appendix_id), appendix)
    draft |> change_draft() |> put_embed(:appendices, changeset) |> put_change(:status, :changed) |> Repo.update() |> broadcast(:draft_updated)
  end

  def remove_from_appendix(%Draft{appendices: appendices} = draft, %Appendix{id: appendix_id, kind: :links} = appendix, id) do
    links = Enum.filter(appendix.links, &(&1.id != id))
    appendix = appendix |> Appendix.changeset(%{}) |> put_embed(:links, links)
    changeset = appendices |> replace_when(&(&1.id == appendix_id), appendix)
    draft |> change_draft() |> put_embed(:appendices, changeset) |> put_change(:status, :changed) |> Repo.update() |> broadcast(:draft_updated)
  end

  def remove_from_appendix(%Draft{appendices: appendices} = draft, appendix_id, id) do
    draft |> remove_from_appendix(Enum.find(appendices, &(&1.id == appendix_id)), id)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Taifead.PubSub, "topics")
  end

  def update_draft(%Draft{} = draft, attrs) do
    draft |> Draft.changeset(attrs) |> put_change(:status, :changed) |> Repo.update() |> broadcast(:draft_updated)
  end

  def with_simpliar_tags(%Publication{id: id, tags: tags}) do
    Repo.all(from p in Publication, where: fragment("? && ?", p.tags, ^tags) and p.latest == true and p.id != ^id)
  end

  defp broadcast({:ok, %{draft: draft, publication: publication}}, event) do
    Phoenix.PubSub.broadcast(Taifead.PubSub, "topics", {event, draft})
    {:ok, publication}
  end

  defp broadcast({:ok, draft}, event) do
    Phoenix.PubSub.broadcast(Taifead.PubSub, "topics", {event, draft})
    {:ok, draft}
  end

  defp broadcast({:error, _reason} = error, _event) do
    IO.inspect(error, label: "error")
    error
  end

  defp latest(dates) do
    dates |> Enum.sort(:desc)
  end

  defp put_path_change(changeset, %Draft{} = draft) do
    path =
      Draft.ancestors(draft)
      |> Repo.all()
      |> Enum.map(fn d -> Repo.one(from p in Publication, select: p.id, where: [draft_id: ^d.id, latest: true]) end)
      |> Hierarch.LTree.join()

    if is_nil(path), do: changeset, else: put_change(changeset, :path, path)
  end

  defp replace_when(list, fun, value) do
    List.replace_at(list, Enum.find_index(list, fun), value)
  end
end
