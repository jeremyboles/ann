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
    <footer class="layout-footer" role="contentinfo">
      <div class="spread wrapper">
        <.logo />
        <div class="flow | sans step--2 weight-500">
          <nav>
            <ul class="cluster">
              <li><a href="/subscribe/">Subscribe</a></li>
              <li><a href="/subscribe/">Contact</a></li>
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
      </div>
    </footer>
    """
  end

  def header(assigns) do
    ~H"""
      <header class="layout-header | center wrapper | text-center" role="banner">
        <.logo />
        <p class="sans step--1 text-tertiary weight-500">A disorderly online home and digital&nbsp;garden.</p>
        
        <nav>
          <p class="vh"><span id="site-nav-label">Main</span> navigation:</p>
          <ul class="main-nav | cluster | kern-loose sans step--2 uppercase weight-800">
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
    <div class="logo">
      <a href="/" rel="home">Jeremy Boles</a>
    </div>
    """
  end
end
