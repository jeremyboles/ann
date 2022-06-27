defmodule Taifead.Repo.Migrations.AddDocsToEntries do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      add :content_html, :text
      add :content_text, :text
      add :doc, :map
    end

    drop table(:notes)
  end
end
