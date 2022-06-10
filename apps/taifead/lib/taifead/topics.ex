defmodule Taifead.Topics do
  import Ecto.Query, warn: false

  alias Taifead.Repo
  alias Taifead.Topics.Draft
  alias Taifead.Topics.Publication

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

  defp broadcast({:error, _reason} = error, _event), do: error
end
