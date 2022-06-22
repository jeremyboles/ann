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

  describe "notes" do
    alias Taifead.Journal.Note

    import Taifead.JournalFixtures

    @invalid_attrs %{content_html: nil, content_text: nil, doc: nil}

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Journal.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Journal.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      valid_attrs = %{content_html: "some content_html", content_text: "some content_text", doc: %{}}

      assert {:ok, %Note{} = note} = Journal.create_note(valid_attrs)
      assert note.content_html == "some content_html"
      assert note.content_text == "some content_text"
      assert note.doc == %{}
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journal.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      update_attrs = %{content_html: "some updated content_html", content_text: "some updated content_text", doc: %{}}

      assert {:ok, %Note{} = note} = Journal.update_note(note, update_attrs)
      assert note.content_html == "some updated content_html"
      assert note.content_text == "some updated content_text"
      assert note.doc == %{}
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Journal.update_note(note, @invalid_attrs)
      assert note == Journal.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Journal.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Journal.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Journal.change_note(note)
    end
  end
end
