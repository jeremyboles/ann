defmodule Bainistigh.JournalLive.ComposeButtonComponent do
  use Bainistigh, :live_component
  
  def handle_event("collapse", _, socket) do
   {:noreply, assign(socket, :expanded, false)}
  end
  
  def handle_event("toggle", _, %{assigns: %{expanded: false}} = socket) do
   {:noreply, assign(socket, :expanded, true)}
  end
  
  def handle_event("toggle", _, %{assigns: %{expanded: true}} = socket) do
   {:noreply, assign(socket, :expanded, false)}
  end
  
  def mount(socket) do
    {:ok, assign(socket, :expanded, false)}
  end
end