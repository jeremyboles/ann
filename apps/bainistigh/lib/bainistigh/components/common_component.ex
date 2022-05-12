defmodule Bainistigh.CommonComponent do
  use Bainistigh, :component

  def section_header(assigns) do
    ~H"""
      <header class="section_header">
        <%= render_slot(@inner_block) %>
      </header>
    """
  end
end
