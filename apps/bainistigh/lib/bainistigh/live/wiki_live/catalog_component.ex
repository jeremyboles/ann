defmodule Bainistigh.WikiLive.CatalogComponent do
  use Bainistigh, :live_component

  alias Taifead.Topics
  alias Taifead.Topics.Draft

  def handle_event("create-draft", _params, socket) do
    {:ok, draft} = Topics.create_draft()
    {:noreply, push_patch(socket, to: "/wiki/#{draft.id}")}
  end

  defp aria_current(%{id: id}, %{id: id}), do: 'page'
  defp aria_current(_article, _current), do: false

  defp children_of(catalog, path \\ "") do
    catalog |> Enum.filter(&(&1.path == path)) |> Enum.sort_by(&{&1.title_text})
  end

  defp class_list(%Draft{publications: []}) do
    "unpublished"
  end

  defp class_list(%Draft{status: :changed}) do
    "published changed"
  end

  defp class_list(%Draft{status: :live}) do
    "published live"
  end

  defp list_item(%{catalog: catalog, draft: draft} = assigns) do
    path = Hierarch.LTree.concat(draft.path, draft.id)
    assigns = assigns |> Map.put(:children, children_of(catalog, path))

    ~H"""
      <li>
        <%= live_patch 'aria-current': aria_current(@current, @draft), class: class_list(@draft), to: "/wiki/#{@draft.id}" do %>
          <%= if @draft.title_html do %>
            <%= raw @draft.title_html %>
          <% else %>
            <i>No Title</i>
          <% end %>
        <% end %>
        
        <%= if Enum.count(@children) > 0 do %>
          <ul>
            <%= for draft <- @children do %>
              <.list_item catalog={@catalog} current={@current} draft={draft}  />
            <% end %>
          </ul>
        <% end %>
      </li>
    """
  end
end
