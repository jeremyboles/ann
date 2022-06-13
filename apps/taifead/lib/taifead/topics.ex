defmodule Taifead.Topics do
  import Ecto.Query, warn: false
  import Ecto.Changeset, only: [put_change: 3, put_embed: 3]

  alias Ecto.Multi
  alias Taifead.Repo
  alias Taifead.Topics.{Appendix, Draft, Link, Publication, Term}

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

  def delete_draft(%Draft{} = draft), do: Repo.delete(draft)

  def get_draft!(id), do: Repo.get!(Draft, id)

  def get_publication!(id), do: Repo.get!(Publication, id)

  def get_published!(url_slug) do
    query = from p in Publication, limit: 1, where: [latest: true, url_slug: ^url_slug]

    query
    |> Repo.one()
    |> Repo.preload(draft: :publications)
  end

  def list_drafts, do: Repo.all(Draft)

  def latest_draft do
    Repo.one(from d in Draft, limit: 1, order_by: [desc: d.updated_at])
  end

  def publish(%Draft{} = draft, attrs \\ %{}) do
    attributes = draft |> Map.from_struct() |> Map.drop([:__meta__, :id, :inserted_at, :path, :publications, :updated_at])
    publication_changeset = draft |> Ecto.build_assoc(:publications, attributes) |> change_publication(attrs) |> put_path_change(draft)
    draft_changeset = draft |> change_draft() |> put_change(:status, :live)

    {:ok, previous_id} =
      Repo.one(from p in Publication, select: p.id, where: [draft_id: ^draft.id, latest: true]) |> Hierarch.Ecto.UUIDLTree.dump()

    IO.inspect(previous_id, label: "current id")

    Multi.new()
    |> Multi.update(:draft, draft_changeset)
    |> Multi.update_all(:unmark_live, from(p in Publication, where: p.draft_id == ^draft.id), set: [latest: false])
    |> Multi.insert(:publication, publication_changeset)
    |> Multi.update_all(
      :paths,
      fn %{publication: publication} ->
        {:ok, next_id} = Hierarch.Ecto.UUIDLTree.dump(publication.id)
        from(p in Publication, update: [set: [path: fragment("text2ltree(REPLACE(ltree2text(?), ?, ?))", p.path, ^previous_id, ^next_id)]])
      end,
      []
    )
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
