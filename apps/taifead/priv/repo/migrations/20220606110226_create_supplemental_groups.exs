defmodule Taifead.Repo.Migrations.CreateSupplementalGroups do
  use Ecto.Migration

  def change do
    create table(:supplemental_groups, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :article_id, references(:articles, on_delete: :delete_all), null: false

      add :kind, :string, null: false
      add :title, :string

      timestamps()
    end

    create index(:supplemental_groups, [:article_id])

    create table(:supplemental_links, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :group_id, references(:supplemental_groups, on_delete: :delete_all), null: false

      add :description, :string
      add :title, :string
      add :url, :string

      timestamps()
    end

    create index(:supplemental_links, [:group_id])

    create table(:supplemental_terms, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :group_id, references(:supplemental_groups, on_delete: :delete_all), null: false

      add :definition, :string
      add :term, :string

      timestamps()
    end

    create index(:supplemental_terms, [:group_id])
  end
end
