defmodule Taifead.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :entry_id, references(:entries, on_delete: :delete_all), null: false

      add :content_html, :text
      add :content_text, :text
      add :doc, :map

      timestamps()
    end

    create index(:notes, [:entry_id])
  end
end
