defmodule Bainistigh.WikiLive.SupplementaryComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
      <section class="SupplementaryComponent">
        supplementary
      </section>
    """
  end
end
