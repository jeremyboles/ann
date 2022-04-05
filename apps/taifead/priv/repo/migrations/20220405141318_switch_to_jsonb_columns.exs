defmodule Taifead.Repo.Migrations.SwitchToJSONBColumns do
  use Ecto.Migration

  def up do
    alter table(:articles) do
      modify :doc, :map
    end

    alter table(:article_revisions) do
      modify :changes, :map
      modify :mapkit_response, :map
    end
  end

  def down do
    alter table(:articles) do
      modify :doc, :json
    end

    alter table(:article_revisions) do
      modify :changes, :json
      modify :mapkit_response, :json
    end
  end
end
