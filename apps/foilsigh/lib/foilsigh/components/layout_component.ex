defmodule Foilsigh.LayoutComponent do
  use Foilsigh, :component

  def header(assigns) do
    ~H"""
      <header role="banner">
        Look at banner Micheal:-)
      </header>
    """
  end
end
