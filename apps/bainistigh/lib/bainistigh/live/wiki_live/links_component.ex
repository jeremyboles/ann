defmodule Bainistigh.WikiLive.LinksComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
      <section class="LinksComponent" role="tabpanel">
        Links
      </section>
    """
  end
end
