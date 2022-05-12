defmodule Foilsigh.WikiComponent do
  use Foilsigh, :component

  alias Taifead.Wiki.Article

  def breadcrumbs(assigns) do
    ~H"""
      <nav aria-labelledby="topic-breadcrumb-nav-label" class="breadcrumbs" id="topic-breadcrumb">
        <p class="vh"><span id="topic-breadcrumb-nav-label">Breadcrumb</span> navigation:</p>
        <ol>
          <li><a href="/wiki">Wiki</a></li>
          <%= for article <- @ancestors do %>
            <li><a href={"/#{article.url_slug}"}><%= title(article) %></a></li>
          <% end %>
          <li><a aria-current="page" href={"/#{@article.url_slug}"}><%= title(@article) %></a></li>
        </ol>
      </nav>
    """
  end

  def content(assigns) do
    ~H"""
      <div class="content">
        <.table_of_contents />
        <div><%= raw @article.content_html %></div>
      </div>
    """
  end

  def essays(assigns) do
    ~H"""
      <aside class="essays">
        <h3 class="vh">Related Essays</h3>
      
        <article class="h-entry article">
          <picture>
            <source sizes="558px" srcset="https://f000.backblazeb2.com/file/jeremyboles-com/topic_essay@588w.jpg 588w, https://f000.backblazeb2.com/file/jeremyboles-com/topic_essay@1176w.jpg 1176w" type="image/jpeg">
            <img alt="A chapel of an old, stone church with sunlight streaming through" src="https://f000.backblazeb2.com/file/jeremyboles-com/topic_essay@588w.jpg" />
          </picture>
          <h4 class="p-name"><a class="u-uid u-url" href="/essays/asdf">Getting to My Airbnb in Paris</a></h4>
          <p class="p-summary">Part one of the story about visiting my friend in Tanzania in which I navigate the streets and subways of Paris without a smartphone and after a sleepless night on a plane.</p>
        </article>
      
        <article class="h-entry article">
          <h4 class="p-name"><a class="u-uid u-url" href="/essays/asdf">Frozen in Paris</a></h4>
          <p class="p-summary">Part two of the story of getting myself to Tanzania in which I am found with cash and with a frozen debit&nbsp;card.</p>
        </article>
      </aside>
    """
  end

  def footer(assigns) do
    ~H"""
      <footer class="footer">
        <figure>
          <figcaption>
            <p>
              The topic <i>Trip to Scotland, 2018</i> was created <time>eleven months ago</time> in <a href="/map/dfasdf">Springfield, MO, United States</a>.
              It’s currently considered a <b><i>seedling topic</i></b> and has been updated three times, the last time being <time>two days ago</time>, also from <a href="/map/dfasdf">Springfield, MO, United States</a>.
            </p>
          </figcaption>
          
          <svg role="img" viewBox="0 0 384 168">
            <desc>
              <p><i>Trip to Scotland, 2018</i> has been updated from the following locations:</p>
              <ul>
                <li><data value="37.202039578772734,-93.27147187929123">Springfield, MO (37°12'07.3"N 93°16'17.3"W')</data></li>
                <li><data value="56.11932088728583,-3.9401846057621692">Stirling, Scotland (56°07'09.6"N 3°56'24.7"W)</data></li>
                <li><data value="43.842596263769565,10.503018539613965">Lucca, Italy (43°50'33.4"N 10°30'10.9"E)</data></li>
              </ul>
            </desc>
          
            <use href="/g/map.svg?height=168&width=384#map"/>
            <use href="/g/points.svg?locations[primary][]=9ytetsdz2&locations[secondary][]=spz3rj21d&locations[secondary][]=gcvpq24ye&height=168&width=384#points"/>
          </svg>
        </figure>
      </footer>
    """
  end

  def header(assigns) do
    ~H"""
      <header class="header">
        <h1><a href={"/#{@article.url_slug}"} rel="bookmark"><%= raw @article.title_html %></a></h1>
        
        <%= if Enum.count(@article.tags) > 0 do %>
          <p>
            <span class="vh">Tagged with:</span>
            <%= for tag <- @article.tags do %>
              <a href={"/tags/#{tag}"} rel="tag"><%= tag %></a>
            <% end %>
          </p>
        <% end %>
      </header>
    """
  end

  def journal(assigns) do
    ~H"""
      <section class="journal">
        <h3 class="vh">Latest Journal Entries About “Scotland, 2018”</h3>
      
        <article class="h-entry note">
          <p>
            <span class="vh">On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span class="vh">,</span> 2014 <span class="vh">@</span> 5:53 am</time><span class="vh">,</span>
            <a class="h-card p-author vh" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">posted a note</a>
            <span class="vh">from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span class="vh">,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span class="vh">:</span>
          </p>
      
          <blockquote cite="/journal/6T51WU" class="e-content p-name">
            <p>Nothing says “long flight to Europe” like Nescafé.</p>
          </blockquote>
        </article>
      
        <article class="h-entry photo">
          <p>
            <span class="vh">On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span class="vh">,</span> 2014 <span class="vh">@</span> 5:53 am</time><span class="vh">,</span>
            <a class="h-card p-author vh" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">posted a photo</a>
            <span class="vh">from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span class="vh">,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span class="vh">:</span>
          </p>
          <blockquote cite="/journal/6T51WU">
            <figure>
              <picture>
                <source sizes="400px" srcset="https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@800w.jpg 800w, https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@400w.jpg 400w" type="image/jpeg">
                <img alt="Mansard rooftops in Paris, France" class="u-photo" loading="lazy" src="https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@400w.jpg">
              </picture>
              <figcaption class="e-content p-name">
                <p>The view from my the window outside of my apartment in&nbsp;Paris.</p>
              </figcaption>
            </figure>
          </blockquote>
        </article>
      
        <article class="h-entry checkin">
          <p>
            <span class="vh">On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span class="vh">,</span> 2014 <span class="vh">@</span> 5:53 am</time><span class="vh">,</span>
            <a class="h-card p-author vh" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">was at a location</a>
            <span class="vh">in</span> <span class="h-adr p-location"><span class="p-locality">Amsterdam</span><span class="vh">,</span> <abbr class="p-country-name" title="Netherlands">NL</abbr></span><span class="vh">:</span>
          </p>
      
          <blockquote cite="/journal/6T51WU" class="e-content p-name">
            <p>Checked in at <span class="h-card p-name u-checkin">Schiphol Airport</span></p>
            <p>AMS ✈ DAR</p>
          </blockquote>
        </article>
      
        <article class="h-entry video">
          <p>
            <span class="vh">On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span class="vh">,</span> 2014 <span class="vh">@</span> 5:53 am</time><span class="vh">,</span>
            <a class="h-card p-author vh" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">posted a video</a>
            <span class="vh">from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span class="vh">,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span class="vh">:</span>
          </p>
      
          <blockquote cite="/journal/6T51WU">
            <figure>
              <video loop muted playsinline poster="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@240p.jpg" preload="none">
                <source class="u-video" src="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@240p.mp4" type="video/mp4">
                
                <img alt="The view from inside of a car on a highway in Tanzania" src="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@240p.jpg" />
                <p>Video downloads in h.264 format:</p>
                <ul>
                  <li><a download href="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@240p.mp4" type="video/mp4">240p resolution</a> - 6.6 <abbr title="megabyte">MB</abbr></li>
                  <li><a download href="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@480p.mp4" type="video/mp4">480p resolution</a> - 8.9 <abbr title="megabyte">MB</abbr></li>
                  <li><a download href="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@540p.mp4" type="video/mp4">540p resolution</a> - 21.7 <abbr title="megabyte">MB</abbr></li>
                  <li><a download href="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@720p.mp4" type="video/mp4">720p resolution</a> - 42.5 <abbr title="megabyte">MB</abbr></li>
                  <li><a download href="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@1080p.mp4" type="video/mp4">1080p resolution</a> - 63.7 <abbr title="megabyte">MB</abbr></li>
                </ul>
              </video>
      
              <figcaption class="e-content p-name">
                <p>I’ve never felt so out of place in my life.</p>
              </figcaption>
            </figure>
          </blockquote>
        </article>
      
        <article class="h-entry bookmark">
          <p>
            <span class="vh">On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span class="vh">,</span> 2014 <span class="vh">@</span> 5:53 am</time><span class="vh">,</span>
            <a class="h-card p-author vh" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">bookmarked a webpage</a>
            <span class="vh">from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span class="vh">,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span class="vh">:</span>
          </p>
      
          <blockquote cite="/journal/6T51WU" class="e-content p-name">
            <p><a class="u-bookmark-of" href="https://thepan-handler.com/griswold-cast-iron/" rel="external noopener" to="https://thepan-handler.com/griswold-cast-iron">https://thepan-handler.com/griswold-cast-iron/</a></p>
            <p>We cook on one of the 1930-1939 era Griswold pans nearly every day.</p>
          </blockquote>
        </article>
      
        <article class="h-entry quote">
          <p>
            <span class="vh">On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span class="vh">,</span> 2014 <span class="vh">@</span> 5:53 am</time><span class="vh">,</span>
            <a class="h-card p-author vh" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">posted a quote</a>
            <span class="vh">from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span class="vh">,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span class="vh">:</span>
          </p>
      
          <blockquote cite="/journal/6T51WU" class="e-content p-name">
            <figure class="p-content">
              <blockquote>Travel changes you. As you move through this life and this world you change things slightly, you leave marks behind, however small. And in return, life—and travel—leaves marks on&nbsp;you.</blockquote>
              <figcaption>Anthony Bourdain, <cite>The Nasty Bits</cite></figcaption>
            </figure>
          </blockquote>
        </article>
      </section>
    """
  end

  def nested_list(assigns) do
    ~H"""
      <ul class="nested_list">
        <%= for article <- children_of(@articles) do %>
          <.article_item article={article} articles={@articles} />
        <% end %>
      </ul>
    """
  end

  def related(assigns) do
    ~H"""
      <aside class="related">
        <h3 class="vh">Related Wiki Topics</h3>
        <dl>
          <div>
            <dt>Other Topics Under “Trip to Scotland, 2018”</dt>
            <dd><a href="/">Topic This Is Long</a></dd>
            <dd><a href="/">Topic This Is Longer Yet</a></dd>
            <dd><a href="/">IndieWeb</a></dd>
          </div>
          <div>
            <dt>Topics That Link <i>to</i> Here</dt>
            <dd><a href="/">IndieWeb</a></dd>
            <dd><a href="/">Topic This Is Long</a></dd>
            <dd><a href="/">Topic This Is Longer Yet</a></dd>
          </div>
          <div>
            <dt>Topics Linked <i>from</i> Here</dt>
            <dd><a href="/">Topic This Is Longer Yet</a></dd>
            <dd><a href="/">IndieWeb</a></dd>
            <dd><a href="/">Topic This Is Long</a></dd>
          </div>
          <div>
            <dt>Topics with Similiar Tags</dt>
            <dd><a href="/">Topic This Is Long</a></dd>
            <dd><a href="/">Topic This Is Longer Yet</a></dd>
            <dd><a href="/">IndieWeb</a></dd>
          </div>
        </dl>
      </aside>
    """
  end

  def supplementary(assigns) do
    ~H"""
      <aside class="supplementary">
        <article>
          <h3>Special Equipment</h3>
          <ul>
            <li><a href="https://wikipedia.com/" rel="external noopener">Ooni</a> — A small, wood-pellet fuel pizza oven for home&nbsp;use</li>
          </ul>
        </article>
      
        <article>
          <h3>Glossary of Terms</h3>
          <dl>
            <dt>mise en place</dt>
            <dd>the preparations to cook, having the ingredients&nbsp;ready</dd>
          </dl>
        </article>
      
        <article>
          <h3>External Links</h3>
          <ul>
            <li><a href="https://wikipedia.com/" rel="external noopener">Wikipedia</a> — Its a great resource</li>
            <li><a href="https://wikipedia.com/" rel="external noopener">Jeremy Boles’ Old Website</a></li>
          </ul>
        </article>
      </aside>
    """
  end

  defp article_item(assigns) do
    path = Hierarch.LTree.concat(assigns.article.path, assigns.article.id)
    assigns = assign(assigns, children: children_of(assigns.articles, path))

    ~H"""
      <li>
          <a href={"/#{@article.url_slug}"}><%= title(@article)%></a>
          <%= if Enum.count(@children) > 0 do %>
            <ul>
              <%= for article <- @children do %>
                <.article_item article={article} articles={@articles} />
              <% end %>
            </ul>
          <% end %>
      </li>
    """
  end

  defp children_of(articles, path \\ "") do
    articles |> Enum.filter(&(&1.path == path)) |> Enum.sort_by(&title/1)
  end

  defp title(%Article{short_title: short_title, title_text: title_text}) do
    short_title || title_text
  end

  defp table_of_contents(assigns) do
    ~H"""
      <nav aria-labelledby="topic-table-of-contents" class="table_of_contents">
        <p class="vh" id="topic-table-of-contents">Table of contents:</p>
        <ol>
          <li><a href="#theitinerary">The&nbsp;Itinerary</a></li>
          <li><a href="#memorablefood">Memorable&nbsp;Food</a></li>
          <li><a href="#notable-gearused">Notable Gear&nbsp;Used</a></li>
          <li><a href="#favoritesmoments">Favorites&nbsp;Moments</a></li>
          <li><a href="#things-ilearned">Things I&nbsp;Learned</a></li>
        </ol>
      </nav>
    """
  end
end
