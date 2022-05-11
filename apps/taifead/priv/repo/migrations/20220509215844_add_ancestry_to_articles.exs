defmodule Taifead.Repo.Migrations.AddAncestryToArticles do
  use Ecto.Migration

  def change do
    drop index(:articles, [:parent_id])

    execute "CREATE EXTENSION IF NOT EXISTS ltree", "DROP EXTENSION IF EXISTS ltree"

    alter table(:articles) do
      add :path, :ltree, null: false, default: ""
      remove :parent_id, references(:articles, on_delete: :nilify_all, type: :binary_id)
    end

    create index(:articles, [:path], using: "GIST")
  end
end
