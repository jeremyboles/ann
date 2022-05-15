defmodule Bainistigh.CommonComponent do
  use Bainistigh, :component

  def combo_button(assigns) do
    ~H"""
      <div class="combo_button">
        <%= render_slot(@inner_block) %>
        <input form="none" type="checkbox"/>
        <div class="options"><%= render_slot(@options) %></div>
      </div>
    """
  end

  def header_button(assigns) do
    ~H"""
      <input class="header_button" type="checkbox">
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

  def toggle_switch(assigns) do
    ~H"""
      <label class="toggle_switch">
        <input type="checkbox" />
        <span><%= render_slot(@inner_block) %></span>
      </label>
    """
  end
end
