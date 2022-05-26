defmodule Bainistigh.WikiLive.TagsComponent do
  use Bainistigh, :live_component

  def handle_event("add-tag", _params, socket) do
    tags =
      case socket.assigns do
        %{focused_index: nil} -> socket.assigns.tags ++ [""]
        %{focused_index: index, tags: tags} -> List.insert_at(tags, index + 1, "")
      end

    {:noreply, assign(socket, :tags, tags)}
  end

  def handle_event("input-focus", %{"index" => index}, socket) do
    {index, _} = Integer.parse(index)
    {:noreply, assign(socket, :focused_index, index)}
  end

  def update(assigns, socket) do
    tags = Phoenix.HTML.Form.input_value(assigns.form, :tags)
    socket = socket |> assign(assigns) |> assign(focused_index: nil, tags: tags)
    {:ok, socket}
  end
end
