defmodule Taifead.JournalTest do
  use Taifead.DataCase

  alias Taifead.Journal

  describe "entries" do
    alias Taifead.Journal.Entry

    import Taifead.JournalFixtures

    @invalid_attrs %{published_at: nil}

    test "list_entries/0 returns all entries" do
      entries = entries_fixture()
      assert Journal.list_entries() == [entries]
    end

    test "get_entry!/1 returns the entries with given id" do
      entries = entries_fixture()
      assert Journal.get_entry!(entries.id) == entries
    end

    test "create_entry/1 with valid data creates a entries" do
      valid_attrs = %{published_at: ~N[2022-06-16 20:05:00]}

      assert {:ok, %Entry{} = entries} = Journal.create_entry(valid_attrs)
      assert entries.published_at == ~N[2022-06-16 20:05:00]
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journal.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entries" do
      entries = entries_fixture()
      update_attrs = %{published_at: ~N[2022-06-17 20:05:00]}

      assert {:ok, %Entry{} = entries} = Journal.update_entry(entries, update_attrs)
      assert entries.published_at == ~N[2022-06-17 20:05:00]
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entries = entries_fixture()
      assert {:error, %Ecto.Changeset{}} = Journal.update_entry(entries, @invalid_attrs)
      assert entries == Journal.get_entry!(entries.id)
    end

    test "delete_entry/1 deletes the entries" do
      entries = entries_fixture()
      assert {:ok, %Entry{}} = Journal.delete_entry(entries)
      assert_raise Ecto.NoResultsError, fn -> Journal.get_entry!(entries.id) end
    end

    test "change_entry/1 returns a entries changeset" do
      entries = entries_fixture()
      assert %Ecto.Changeset{} = Journal.change_entry(entries)
    end
  end
end
