defmodule Foilsigh.LayoutComponent do
  use Foilsigh, :component

  def aside(assigns) do
    ~H"""
      <aside role="complementary">
        Aside
      </aside>
    """
  end

  def footer(assigns) do
    ~H"""
    <footer role="contentinfo">
      <div>
        <.logo />
        <nav>
          <ul>
            <li><a href="/subscribe/">Subscribe</a></li>
            <li><a href="/contact/">Contact</a></li>
            <li><a href="/privacy/">I Don’t Track You</a></li>
            <li><a href="/colophon/">Colophon</a></li>
            <li><a href="/sitemap/">Site Map</a></li>
            <li><a href="http://github.com/jeremyboles/ann/">Source Code</a></li>
          </ul>
        </nav>
        <p>
          Copyright <span>©</span> 2021 Jeremy Boles. Content licensed under the <a href="https://creativecommons.org/licenses/by-sa/4.0/" rel="external license noopener">Creative Commons Attribution-ShareAlike 4.0 International</a>&nbsp;license.
        </p>        
      </div>
    </footer>
    """
  end

  def grid(assigns) do
    ~H"""
      <div class="grid-guide" role="presentation">
        <div class="grid wrapper">
          <%= for num <- 1..16 do %>
            <div data-column-num={num} />
          <% end %>
        </div>
        <div class="baseline"></div>
        <link href="/assets/components/layout/grid-guide.css" rel="stylesheet">
      </div>
    """
  end

  def header(assigns) do
    ~H"""
      <header role="banner">
        <.logo />
        <p>A disorderly online home and digital garden.</p>
        
        <nav>
          <p class="vh"><span id="site-nav-label">Main</span> navigation:</p>
          <ul>
            <li><a href="/journal/">Journal</a></li>
            <li><a href="/wiki/">Wiki</a></li>
            <li><a href="/essays/">Essays</a></li>
            <li><a href="/calendar/">Calendar</a></li>
            <li><a href="/map/">Map</a></li>
          </ul>
        </nav>
      </header>
    """
  end

  def logo(assigns) do
    ~H"""
      <a href="/" role="home">
        <svg focusable="false" height="27" width="160" viewBox="0 0 160 27">
          <use href="/images/logo.svg#logo" />
        </svg>
        <span class="vh">Jeremy Boles</span>
      </a>
    """
  end
end
