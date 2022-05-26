defmodule Bainistigh.CommonComponent do
  use Bainistigh, :component

  def header_button(assigns) do
    ~H"""
    <input class="header_button" form="none" type="checkbox" />
    """
  end

  def section_header(assigns) do
    assigns =
      assigns
      |> assign_new(:controls, fn -> [] end)
      |> assign_new(:inner_block, fn -> [] end)

    ~H"""
    <header class="section_header">
      <%= if render_slot(@inner_block) do %>
        <div><%= render_slot(@inner_block) %></div>
      <% end %>

      <%= if render_slot(@controls) do %>
        <div class="controls"><%= render_slot(@controls) %></div>
      <% end %>
    </header>
    """
  end
end
