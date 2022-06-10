defmodule Bainistigh.WikiLive.MetadataComponent do
  use Bainistigh, :live_component

  import String, only: [contains?: 2]

  alias Taifead.Topics
  alias Taifead.Topics.Draft

  def handle_event("update", %{"draft" => params}, %{assigns: %{draft: draft}} = socket) do
    {:ok, _draft} = Topics.update_draft(draft, params)
    {:noreply, socket}
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign_changeset()
    {:ok, socket}
  end

  defp assign_changeset(%{assigns: %{draft: draft}} = socket) do
    socket |> assign(:changeset, Topics.change_draft(draft))
  end

  defp parent_select(%{data: %{id: id}} = form, field, catalog, opts) do
    catalog = catalog |> Enum.reject(&(&1.id == id)) |> Enum.reject(&contains?(&1.path, id))

    opts = Keyword.put(opts, :disabled, Enum.empty?(catalog))

    select(form, field, Enum.map(catalog, &select_value/1), opts)
  end

  defp select_value(%Draft{id: id, path: path, title_text: title}) do
    {title, Hierarch.LTree.concat(path, id)}
  end
end
