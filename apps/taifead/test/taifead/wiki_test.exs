defmodule Taifead.WikiTest do
  use Taifead.DataCase

  alias Taifead.Wiki

  describe "articles" do
    alias Taifead.Wiki.Article

    import Taifead.WikiFixtures

    @invalid_attrs %{content_html: nil, doc: nil, title_html: nil, url_slug: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Wiki.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Wiki.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{content_html: "some content_html", doc: "some doc", title_html: "some title_html", url_slug: "some url_slug"}

      assert {:ok, %Article{} = article} = Wiki.create_article(valid_attrs)
      assert article.content_html == "some content_html"
      assert article.doc == "some doc"
      assert article.title_html == "some title_html"
      assert article.url_slug == "some url_slug"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wiki.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{content_html: "some updated content_html", doc: "some updated doc", title_html: "some updated title_html", url_slug: "some updated url_slug"}

      assert {:ok, %Article{} = article} = Wiki.update_article(article, update_attrs)
      assert article.content_html == "some updated content_html"
      assert article.doc == "some updated doc"
      assert article.title_html == "some updated title_html"
      assert article.url_slug == "some updated url_slug"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Wiki.update_article(article, @invalid_attrs)
      assert article == Wiki.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Wiki.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Wiki.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Wiki.change_article(article)
    end
  end
end
