defmodule Foilsigh.SharedComponent do
  use Foilsigh, :component

  def section_header(assigns) do
    ~H"""
      <header class="section_header">
        <h1><%= @title %></h1>
        <p><%= render_slot(@inner_block) %></p>
      </header>
    """
  end
end
