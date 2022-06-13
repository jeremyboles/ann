defmodule Taifead.Repo.Migrations.RemoveOldWikiTables do
  use Ecto.Migration

  def change do
    drop table(:article_revisions), mode: :cascade
    drop table(:articles), mode: :cascade
    drop table(:supplemental_groups), mode: :cascade
    drop table(:supplemental_links), mode: :cascade
    drop table(:supplemental_terms), mode: :cascade
  end
end
