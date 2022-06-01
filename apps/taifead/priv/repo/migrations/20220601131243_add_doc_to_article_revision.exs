defmodule Taifead.Repo.Migrations.AddDocToArticleRevision do
  use Ecto.Migration

  def change do
    alter table(:article_revisions) do
      add :content_html, :text
      add :doc, :map
    end
  end
end
