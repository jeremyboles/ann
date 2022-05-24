defmodule Bainistigh.WikiLive.HistoryComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
      <section class="HistoryComponent" role="tabpanel">
        History
      </section>
    """
  end
end
