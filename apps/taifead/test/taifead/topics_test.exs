defmodule Taifead.TopicsTest do
  use Taifead.DataCase

  alias Taifead.Topics

  describe "topic_drafts" do
    alias Taifead.Topics.Draft

    import Taifead.TopicsFixtures

    @invalid_attrs %{doc: nil}

    test "list_topic_drafts/0 returns all topic_drafts" do
      draft = draft_fixture()
      assert Topics.list_topic_drafts() == [draft]
    end

    test "get_draft!/1 returns the draft with given id" do
      draft = draft_fixture()
      assert Topics.get_draft!(draft.id) == draft
    end

    test "create_draft/1 with valid data creates a draft" do
      valid_attrs = %{doc: %{}}

      assert {:ok, %Draft{} = draft} = Topics.create_draft(valid_attrs)
      assert draft.doc == %{}
    end

    test "create_draft/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topics.create_draft(@invalid_attrs)
    end

    test "update_draft/2 with valid data updates the draft" do
      draft = draft_fixture()
      update_attrs = %{doc: %{}}

      assert {:ok, %Draft{} = draft} = Topics.update_draft(draft, update_attrs)
      assert draft.doc == %{}
    end

    test "update_draft/2 with invalid data returns error changeset" do
      draft = draft_fixture()
      assert {:error, %Ecto.Changeset{}} = Topics.update_draft(draft, @invalid_attrs)
      assert draft == Topics.get_draft!(draft.id)
    end

    test "delete_draft/1 deletes the draft" do
      draft = draft_fixture()
      assert {:ok, %Draft{}} = Topics.delete_draft(draft)
      assert_raise Ecto.NoResultsError, fn -> Topics.get_draft!(draft.id) end
    end

    test "change_draft/1 returns a draft changeset" do
      draft = draft_fixture()
      assert %Ecto.Changeset{} = Topics.change_draft(draft)
    end
  end

  describe "topic_publications" do
    alias Taifead.Topics.Publication

    import Taifead.TopicsFixtures

    @invalid_attrs %{doc: nil}

    test "list_topic_publications/0 returns all topic_publications" do
      publication = publication_fixture()
      assert Topics.list_topic_publications() == [publication]
    end

    test "get_publication!/1 returns the publication with given id" do
      publication = publication_fixture()
      assert Topics.get_publication!(publication.id) == publication
    end

    test "create_publication/1 with valid data creates a publication" do
      valid_attrs = %{doc: %{}}

      assert {:ok, %Publication{} = publication} = Topics.create_publication(valid_attrs)
      assert publication.doc == %{}
    end

    test "create_publication/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topics.create_publication(@invalid_attrs)
    end

    test "update_publication/2 with valid data updates the publication" do
      publication = publication_fixture()
      update_attrs = %{doc: %{}}

      assert {:ok, %Publication{} = publication} = Topics.update_publication(publication, update_attrs)
      assert publication.doc == %{}
    end

    test "update_publication/2 with invalid data returns error changeset" do
      publication = publication_fixture()
      assert {:error, %Ecto.Changeset{}} = Topics.update_publication(publication, @invalid_attrs)
      assert publication == Topics.get_publication!(publication.id)
    end

    test "delete_publication/1 deletes the publication" do
      publication = publication_fixture()
      assert {:ok, %Publication{}} = Topics.delete_publication(publication)
      assert_raise Ecto.NoResultsError, fn -> Topics.get_publication!(publication.id) end
    end

    test "change_publication/1 returns a publication changeset" do
      publication = publication_fixture()
      assert %Ecto.Changeset{} = Topics.change_publication(publication)
    end
  end
end
