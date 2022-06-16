defmodule Bainistigh.JournalLive.Component do
  use Bainistigh, :component

  def import_button(assigns) do
    ~H"""
      <button class="JournalLive_Component__import_button">
        <span>Import</span>
      </button>
    """
  end
end
