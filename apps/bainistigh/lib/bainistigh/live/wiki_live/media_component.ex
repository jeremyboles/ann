defmodule Bainistigh.WikiLive.MediaComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
      <section class="MediaComponent" role="tabpanel">
        Media
      </section>
    """
  end
end
