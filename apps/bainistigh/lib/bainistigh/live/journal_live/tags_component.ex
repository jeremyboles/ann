defmodule Bainistigh.JournalLive.TagsComponent do
  use Bainistigh, :live_component

  def handle_event("keydown", %{"key" => " ", "value" => tag}, socket) when tag != "" do
    tags = input_value(socket.assigns.form, :tags) ++ [tag]
    {:noreply, push_event(socket, "update-tags", %{tags: tags})}
  end

  def handle_event("keydown", %{"key" => ",", "value" => tag}, socket) when tag != "" do
    tags = input_value(socket.assigns.form, :tags) ++ [String.trim(tag, ",")]
    {:noreply, push_event(socket, "update-tags", %{tags: tags})}
  end

  def handle_event("keydown", %{"key" => "Enter", "value" => tag}, socket) when tag != "" do
    tags = input_value(socket.assigns.form, :tags) ++ [String.trim(tag)]
    {:noreply, push_event(socket, "update-tags", %{blur: true, tags: tags})}
  end

  def handle_event("keydown", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("remove", %{"tag" => tag}, socket) do
    tags = Enum.reject(input_value(socket.assigns.form, :tags), &(&1 == tag))
    {:noreply, push_event(socket, "update-tags", %{tags: tags})}
  end
end
