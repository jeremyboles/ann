defmodule Taifead.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    execute "CREATE TYPE entry_kind AS ENUM('bookmark','checkin','note','photo','quote', 'video')",
            "DROP TYPE entry_kind"

    create table(:entries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :topic_id, references(:topic_drafts, on_delete: :nilify_all)

      add :coords, :"geometry(Point, 4326)"
      add :is_published, :boolean, default: false
      add :kind, :entry_kind, null: false
      add :mapkit_response, :map
      add :published_at, :utc_datetime_usec
      add :tags, {:array, :string}, default: []
      add :url_slug, :string, null: false

      timestamps()
    end

    create index(:entries, [:coords], using: "GIST")
    create index(:entries, ["published_at DESC"])
    create index(:entries, [:tags], using: "GIN")
    create index(:entries, [:topic_id])
    create index(:entries, [:url_slug], unique: true)
  end
end
