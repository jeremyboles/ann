defmodule Bainistigh.JournalLive.ComposeComponent do
  use Bainistigh, :live_component
  
  alias Bainistigh.JournalLive.SidebarComponent
  
  def handle_event("publish", _params, socket) do
    IO.inspect("publish")
    {:noreply, push_event(socket, "close-dialog", %{})}
  end
  
  def handle_event("save", _params, socket) do
    IO.inspect("save")
    {:noreply, push_event(socket, "close-dialog", %{})}
  end
end