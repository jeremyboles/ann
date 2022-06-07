defmodule Taifead.SupplementalTest do
  use Taifead.DataCase

  alias Taifead.Supplemental

  describe "supplemental_groups" do
    alias Taifead.Supplemental.Group

    import Taifead.SupplementalFixtures

    @invalid_attrs %{title: nil}

    test "list_supplemental_groups/0 returns all supplemental_groups" do
      group = group_fixture()
      assert Supplemental.list_supplemental_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Supplemental.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Group{} = group} = Supplemental.create_group(valid_attrs)
      assert group.title == "some title"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supplemental.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Group{} = group} = Supplemental.update_group(group, update_attrs)
      assert group.title == "some updated title"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Supplemental.update_group(group, @invalid_attrs)
      assert group == Supplemental.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Supplemental.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Supplemental.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Supplemental.change_group(group)
    end
  end

  describe "supplemental_links" do
    alias Taifead.Supplemental.Link

    import Taifead.SupplementalFixtures

    @invalid_attrs %{description: nil, title: nil, url: nil}

    test "list_supplemental_links/0 returns all supplemental_links" do
      link = link_fixture()
      assert Supplemental.list_supplemental_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Supplemental.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{description: "some description", title: "some title", url: "some url"}

      assert {:ok, %Link{} = link} = Supplemental.create_link(valid_attrs)
      assert link.description == "some description"
      assert link.title == "some title"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supplemental.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", url: "some updated url"}

      assert {:ok, %Link{} = link} = Supplemental.update_link(link, update_attrs)
      assert link.description == "some updated description"
      assert link.title == "some updated title"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Supplemental.update_link(link, @invalid_attrs)
      assert link == Supplemental.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Supplemental.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Supplemental.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Supplemental.change_link(link)
    end
  end

  describe "supplemental_terms" do
    alias Taifead.Supplemental.Term

    import Taifead.SupplementalFixtures

    @invalid_attrs %{definition: nil, term: nil}

    test "list_supplemental_terms/0 returns all supplemental_terms" do
      term = term_fixture()
      assert Supplemental.list_supplemental_terms() == [term]
    end

    test "get_term!/1 returns the term with given id" do
      term = term_fixture()
      assert Supplemental.get_term!(term.id) == term
    end

    test "create_term/1 with valid data creates a term" do
      valid_attrs = %{definition: "some definition", term: "some term"}

      assert {:ok, %Term{} = term} = Supplemental.create_term(valid_attrs)
      assert term.definition == "some definition"
      assert term.term == "some term"
    end

    test "create_term/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supplemental.create_term(@invalid_attrs)
    end

    test "update_term/2 with valid data updates the term" do
      term = term_fixture()
      update_attrs = %{definition: "some updated definition", term: "some updated term"}

      assert {:ok, %Term{} = term} = Supplemental.update_term(term, update_attrs)
      assert term.definition == "some updated definition"
      assert term.term == "some updated term"
    end

    test "update_term/2 with invalid data returns error changeset" do
      term = term_fixture()
      assert {:error, %Ecto.Changeset{}} = Supplemental.update_term(term, @invalid_attrs)
      assert term == Supplemental.get_term!(term.id)
    end

    test "delete_term/1 deletes the term" do
      term = term_fixture()
      assert {:ok, %Term{}} = Supplemental.delete_term(term)
      assert_raise Ecto.NoResultsError, fn -> Supplemental.get_term!(term.id) end
    end

    test "change_term/1 returns a term changeset" do
      term = term_fixture()
      assert %Ecto.Changeset{} = Supplemental.change_term(term)
    end
  end
end
