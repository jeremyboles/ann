defmodule Bainistigh.WikiLive.AppendicesComponent do
  use Bainistigh, :live_component

  alias Taifead.Topics

  def handle_event("add-appendix", %{"kind" => "glossary"}, %{assigns: %{draft: draft}} = socket) do
    {:ok, _draft} = Topics.add_appendix(draft, :glossary)
    {:noreply, socket}
  end

  def handle_event("add-appendix", %{"kind" => "links"}, %{assigns: %{draft: draft}} = socket) do
    {:ok, _draft} = Topics.add_appendix(draft, :links)
    {:noreply, socket}
  end

  def handle_event("add-to-appendix", %{"appendix-id" => id}, socket) do
    {:ok, _draft} = Topics.add_to_appendix(socket.assigns.draft, id)
    {:noreply, socket}
  end

  def handle_event("remove-from-appendix", %{"appendix-id" => appendix_id, "id" => id}, socket) do
    IO.inspect("Appendix")
    IO.inspect(%{appendix_id: appendix_id, id: id}, label: "remove-from-appendix")
    {:ok, _draft} = Topics.remove_from_appendix(socket.assigns.draft, appendix_id, id)
    {:noreply, socket}
  end

  def handle_event("remove-appendix", %{"id" => id}, %{assigns: %{draft: draft}} = socket) do
    {:ok, _draft} = Topics.remove_appendix(draft, id)
    {:noreply, socket}
  end

  def handle_event("update", %{"draft" => params}, %{assigns: %{draft: draft}} = socket) do
    {:ok, _draft} = Topics.update_draft(draft, params)
    {:noreply, socket}
  end

  def mount(socket) do
    {:ok, assign(socket, :marked_for_deletion, [])}
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign_changeset()
    {:ok, socket}
  end

  defp assign_changeset(%{assigns: %{draft: draft}} = socket) do
    socket |> assign(:changeset, Topics.change_draft(draft))
  end

  defp placeholder(:glossary), do: "e.g. Glossary of Terms"
  defp placeholder(:links), do: "e.g. External Links"
  defp placeholder(%Phoenix.HTML.Form{} = form), do: form |> input_value(:kind) |> placeholder()
  defp placeholder(_), do: nil
end
