defmodule Taifead.Repo.Migrations.CreateTopicDrafts do
  use Ecto.Migration

  def change do
    create table(:topics, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :appendices, {:array, :map}, default: []
      add :content_html, :text
      add :content_text, :text
      add :doc, :map
      add :path, :ltree, null: false, default: ""
      add :short_title, :string
      add :tags, {:array, :string}, default: []
      add :title_html, :string
      add :title_text, :string
      add :url_slug, :string

      timestamps()
    end
  end
end
