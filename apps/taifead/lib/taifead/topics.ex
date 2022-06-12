defmodule Taifead.Topics do
  import Ecto.Query, warn: false

  import Ecto.Changeset, only: [put_embed: 3]

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
    draft |> change_draft() |> put_embed(:appendices, changeset) |> Repo.update() |> broadcast(:draft_updated)
  end

  def add_to_appendix(%Draft{appendices: appendices} = draft, %Appendix{id: id, kind: :links} = appendix) do
    links = appendix.links ++ [%Link{title: "", url: ""}]
    appendix = appendix |> Appendix.changeset(%{}) |> put_embed(:links, links)
    changeset = appendices |> replace_when(&(&1.id == id), appendix)
    draft |> change_draft() |> put_embed(:appendices, changeset) |> Repo.update() |> broadcast(:draft_updated)
  end

  def add_to_appendix(%Draft{appendices: appendices} = draft, id) do
    draft |> add_to_appendix(Enum.find(appendices, &(&1.id == id)))
  end

  def change_draft(%Draft{} = draft, attrs \\ %{}), do: Draft.changeset(draft, attrs)

  def change_publication(%Publication{} = publication, attrs \\ %{}), do: Publication.changeset(publication, attrs)

  def create_draft(attrs \\ %{}) do
    %Draft{} |> Draft.changeset(attrs) |> Repo.insert() |> broadcast(:draft_created)
  end

  def delete_draft(%Draft{} = draft), do: Repo.delete(draft)

  def get_draft!(id), do: Repo.get!(Draft, id)

  def get_publication!(id), do: Repo.get!(Publication, id)

  def list_drafts, do: Repo.all(Draft)

  def latest_draft do
    Repo.one(from d in Draft, limit: 1, order_by: [desc: d.updated_at])
  end

  def remove_appendix(%Draft{appendices: appendices} = draft, id) do
    draft |> change_draft() |> put_embed(:appendices, Enum.filter(appendices, &(&1.id != id))) |> Repo.update() |> broadcast(:draft_updated)
  end

  def remove_from_appendix(%Draft{appendices: appendices} = draft, %Appendix{id: appendix_id, kind: :glossary} = appendix, id) do
    terms = Enum.filter(appendix.terms, &(&1.id != id))
    appendix = appendix |> Appendix.changeset(%{}) |> put_embed(:terms, terms)
    changeset = appendices |> replace_when(&(&1.id == appendix_id), appendix)
    draft |> change_draft() |> put_embed(:appendices, changeset) |> Repo.update() |> broadcast(:draft_updated)
  end

  def remove_from_appendix(%Draft{appendices: appendices} = draft, %Appendix{id: appendix_id, kind: :links} = appendix, id) do
    links = Enum.filter(appendix.links, &(&1.id != id))
    appendix = appendix |> Appendix.changeset(%{}) |> put_embed(:links, links)
    changeset = appendices |> replace_when(&(&1.id == appendix_id), appendix)
    draft |> change_draft() |> put_embed(:appendices, changeset) |> Repo.update() |> broadcast(:draft_updated)
  end

  def remove_from_appendix(%Draft{appendices: appendices} = draft, appendix_id, id) do
    draft |> remove_from_appendix(Enum.find(appendices, &(&1.id == appendix_id)), id)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Taifead.PubSub, "topic_drafts")
  end

  def update_draft(%Draft{} = draft, attrs) do
    draft |> Draft.changeset(attrs) |> Repo.update() |> broadcast(:draft_updated)
  end

  defp broadcast({:ok, draft}, event) do
    Phoenix.PubSub.broadcast(Taifead.PubSub, "topic_drafts", {event, draft})
    {:ok, draft}
  end

  defp broadcast({:error, _reason} = error, _event) do
    IO.inspect(error, label: "error")
    error
  end

  defp replace_when(list, fun, value) do
    List.replace_at(list, Enum.find_index(list, fun), value)
  end
end
