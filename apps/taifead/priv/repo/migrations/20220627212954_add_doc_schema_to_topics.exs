defmodule Taifead.Repo.Migrations.AddDocSchemaToTopics do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE wiki_kind AS ENUM('article')",
            "DROP TYPE wiki_kind"

    alter table(:topics) do
      add :kind, :wiki_kind, default: "article"
    end
  end
end
