defmodule Taifead.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :content_html, :text
      add :content_text, :text
      add :doc, :json
      add :short_title, :string
      add :tags, {:array, :string}
      add :title_html, :string
      add :title_text, :string
      add :url_slug, :string
      add :visibility, :string, default: "private"

      add :parent_id, references(:articles, on_delete: :nilify_all, type: :binary_id)

      timestamps()
    end

    create index(:articles, [:parent_id])
    create index(:articles, [:tags], using: "GIN")
    create index(:articles, [:url_slug], unique: true)
  end
end
