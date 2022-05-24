defmodule Bainistigh.WikiLive.GlossaryComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
      <section class="GlossaryComponent" role="tabpanel">
        Glossary
      </section>
    """
  end
end
