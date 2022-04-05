defmodule Taifead.Repo.Migrations.CreateArticleRevisions do
  use Ecto.Migration

  def change do
    create table(:article_revisions, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :article_id, references(:articles, on_delete: :delete_all), null: false

      add :changes, :json, null: false
      add :coords, :"geometry(Point, 4326)"
      add :mapkit_response, :json
      add :note, :string

      timestamps()
    end

    create index(:article_revisions, [:article_id])
    create index(:article_revisions, [:coords], using: "GIST")
  end
end
