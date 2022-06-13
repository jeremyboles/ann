defmodule Taifead.Repo.Migrations.AddNotNullToLocationFields do
  use Ecto.Migration

  def change do
    alter table(:topic_publications) do
      modify :coords, :"geometry(Point, 4326)",
        null: false,
        from: {:"geometry(Point, 4326)", null: true}

      modify :mapkit_response, :map,
        null: false,
        from: {:map, null: true}
    end
  end
end
