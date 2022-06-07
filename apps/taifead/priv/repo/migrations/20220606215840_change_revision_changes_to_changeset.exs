defmodule Taifead.Repo.Migrations.ChangeRevisionChangesToChangeset do
  use Ecto.Migration

  def change do
    rename table("article_revisions"), :changes, to: :changeset
  end
end
