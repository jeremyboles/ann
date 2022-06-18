defmodule Bainistigh.JournalLive.SidebarComponent do
  use Bainistigh, :live_component

  alias Bainistigh.JournalLive.{DateComponent, LocationComponent, TagsComponent}

  def handle_event("select-tab", %{"tab" => tab}, socket) do
    case socket.assigns.selected do
      ^tab -> {:noreply, assign(socket, :selected, nil)}
      _ -> {:noreply, assign(socket, :selected, tab)}
    end
  end

  def mount(socket) do
    {:ok, assign(socket, :selected, nil)}
  end

  defp panel(assigns) do
    ~H"""
      <div aria-hidden={if @id != @selected, do: "true", else: "false"} id={"#{@id}-panel"} role="tabpanel">
        <%= render_slot(@inner_block) %>
      </div>
    """
  end

  defp tab(assigns) do
    ~H"""
      <li aria-controls={"#{@id}-panel"} aria-selected={if @id == @selected, do: "true"} phx-click="select-tab" phx-target={@myself} phx-value-tab={@id} role="tab">
        <%= render_slot(@inner_block) %>
      </li>
    """
  end
end
