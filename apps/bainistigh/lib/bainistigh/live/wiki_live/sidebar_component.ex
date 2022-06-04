defmodule Bainistigh.WikiLive.SidebarComponent do
  use Bainistigh, :live_component

  def handle_event("select-tab", %{"tab" => tab}, socket) do
    case socket.assigns.selected do
      ^tab -> {:noreply, assign(socket, :selected, nil)}
      _ -> {:noreply, assign(socket, :selected, tab)}
    end
  end

  def mount(socket) do
    {:ok, assign(socket, :selected, nil)}
  end

  def tab(assigns) do
    ~H"""
      <li aria-controls={"#{@id}-panel"} aria-selected={if @id == @selected, do: "true"} phx-click="select-tab" phx-target={@myself} phx-value-tab={@id} role="tab">
        <span><%= render_slot(@inner_block) %></span>
      </li>
    """
  end
end
