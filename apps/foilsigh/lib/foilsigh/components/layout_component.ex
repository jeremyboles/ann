defmodule Foilsigh.LayoutComponent do
  use Foilsigh, :component

  def header(assigns) do
    ~H"""
      <header class="layout-header | center wrapper | text-center" role="banner">
        <.logo />
        <p class="sans step--1 text-tertiary weight-500">A disorderly online home and digital&nbsp;garden.</p>
        
        <nav>
          <p class="vh"><span id="site-nav-label">Main</span> navigation:</p>
          <ul class="main-nav | cluster | kern-loose sans step--2 uppercase weight-800">
            <li><a href="/journal">Journal</a></li>
            <li><a href="/wiki">Wiki</a></li>
            <li><a href="/essays">Essays</a></li>
            <li><a href="/calendar">Calendar</a></li>
            <li><a href="/map">Map</a></li>
          </ul>
        </nav>
      </header>
    """
  end

  def logo(assigns) do
    ~H"""
      <div class="logo">
        <a href="/" rel="home">Jeremy Boles</a>
      </div>
    """
  end
end
