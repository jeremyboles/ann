defmodule Taifead.Repo.Migrations.AddTopicDraftsAndPublications do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE draft_status AS ENUM('changed', 'live')", "DROP TYPE draft_status"

    create table(:topic_drafts, options: "INHERITS (topics)", primary_key: false) do
      add :status, :draft_status, default: "changed"
    end

    create index(:topic_drafts, [:id], unique: true)
    create index(:topic_drafts, [:path], using: "GIST")
    create index(:topic_drafts, [:status])
    create index(:topic_drafts, [:tags], using: "GIN")

    create table(:topic_publications, options: "INHERITS (topics)", primary_key: false) do
      add :draft_id, references(:topic_drafts, on_delete: :delete_all), null: false

      add :coords, :"geometry(Point, 4326)"
      add :mapkit_response, :map
    end

    create index(:topic_publications, [:id], unique: true)
    create index(:topic_publications, [:coords], using: "GIST")
    create index(:topic_publications, [:draft_id])
    create index(:topic_publications, [:draft_id, "updated_at DESC"])
    create index(:topic_publications, [:path], using: "GIST")
    create index(:topic_publications, [:tags], using: "GIN")
    create index(:topic_publications, [:url_slug, "updated_at DESC"])
  end
end
