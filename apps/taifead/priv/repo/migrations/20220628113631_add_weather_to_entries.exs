defmodule Taifead.Repo.Migrations.AddWeatherToEntries do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      add :weatherkit_response, :map
    end
  end
end
