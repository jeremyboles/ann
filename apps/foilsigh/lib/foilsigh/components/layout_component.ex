defmodule Foilsigh.LayoutComponent do
  use Foilsigh, :component

  def aside(assigns) do
    ~H"""
      <aside role="complementary">
        <div>
          <article class="h-card">
            <h2>About Me, in Fifteen Seconds</h2>
            <picture>
              <img alt="Jeremy Boles, indoors and smiling" class="u-photo" loading="lazy" src="/images/avatar@880w.jpg" width="440">
            </picture>
            <p class="p-note">
              Hi! I’m <a class="p-name u-uid u-url" href="/" rel="me"><span class="p-given-name">Jeremy</span> <span class="p-family-name">Boles</span></a>, an American programmer and designer based out of <span class="h-adr p-adr">Southwest <span class="p-region">Missouri</span>, in the <span class="p-country-name">United States</span></span>. I currently work for <span class="h-card p-org"><a class="p-name u-url" href="https://cloudflare.com/" rel="external noopener">Cloudflare</a> as a <span class="p-job-title">Software Engineer</span></span>, but I also run a small software studio called <span class="h-card p-org"><a class="p-name u-url" href="https://centralstandard.com/" rel="external noopener">Central Standard</a></span> on the side. Outside of work, I like to cook, travel, go for walks in the woods, and hang out with my family.
              <b class="p-gender-identity">
                <span><a class="u-pronoun" href="https://en.wiktionary.org/wiki/he#Pronoun" rel="external noopener">he</a></span> / 
                <span><a class="u-pronoun" href="https://en.wiktionary.org/wiki/him#Pronoun" rel="external noopener">him</a></span> / 
                <span><a class="u-pronoun" href="https://en.wiktionary.org/wiki/his#Pronoun" rel="external noopener">his</a></span>
              </b>
            </p>
          </article>
          
          <nav aria-labelledby="secondary-nav-label">
            <h3 id="secondary-nav-label">Concerning Myself</h3>
            <ul>
              <li><a href="/">About Me, in Roughly Ten Minutes</a></li>
              <li><a href="/">Notable Work and Projects</a></li>
              <li><a href="/">What I’m Up to Now</a></li>
              <li><a href="/">Various Writings and Such</a></li>
              <li><a href="/">Places That I've Published From</a></li>
            </ul>
          </nav>
          
          <div>
            <h3>Also Me, but Elsewhere</h3>
            <ul>
              <li><a href="https://boles.social/@jeremy" rel="external me noopener">jeremy@boles.social on Mastodon</a></li>
              <li><a href="https://twitter.com/jeremyboles" rel="external me noopener">@jeremyboles on Twitter</a></li>
              <li><a href="https://instagram.com/germybowls/" rel="external me noopener">@germyboles on Instagram</a></li>
              <li><a href="https://facebook.com/germybowls" rel="external me noopener">@germyboles on Facebook</a></li>
              <li><a href="https://github.com/jeremyboles" rel="external me noopener">@jeremyboles on Github</a></li>
            </ul>
          </div>
        </div>
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
