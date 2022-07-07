defmodule Foilsigh.JournalComponent do
  use Foilsigh, :component

  import Foilsigh.GraphicsComponent

  alias Taifead.Journal.Entry

  def blogroll(assigns) do
    ~H"""
      <aside class="blogroll">
        <h3>Websites I Frequent</h3>
      
        <dl>
          <dt><a href="https://jeremyboles.com/" rel="external nofollow noopener">Jeremy Boles</a></dt>
          <dd>A short description about what I like about the site or why I subscribe.</dd>
      
          <dt><a href="https://100r.co/" rel="external nofollow noopener">Hundred Rabbits</a></dt>
          <dd>Rekka and Devine are sort of archetypes for me.</dd>
      
          <dt><a href="https://craigmod.com/" rel="external nofollow noopener">Craig Mod</a></dt>
          <dd>Walks, writing, and photography.</dd>
        </dl>
      </aside>
    """
  end

  def entry_detail(assigns) do
    ~H"""
      <div class="entry_detail">
        <.entry_header slug={@slug} />
        <.entry_content type={@slug} />
        <.entry_footer />
      </div>
    """
  end

  def entry_header(assigns) do
    ~H"""
      <header class={"entry_header #{@slug}"}>
        <h2>
          <a class="h-card p-author" href="/">
            <picture>
              <img alt="I" class="u-photo" loading="lazy" src="/images/avatar@880w.jpg">
            </picture>
          </a>
          <a class="u-uid u-url" href={"/journal/#{@slug}"}>Published the Following Note</a>
          <span class="vh">at</span> <time class="dt-published" datetime="2013-06-13 12:00:00"><span>5:53 AM</span> <span class="vh">on</span> December 2nd, 2014</time><span class="vh">,</span>
          <span class="vh">from</span> <a class="h-adr p-location" href="/map">Quartier de Bonne-Nouvelle</a><span class="vh">:</span>
        </h2>
      </header>
    """
  end

  def entry_footer(assigns) do
    ~H"""
      <footer class="entry_footer">
        <h3 class="vh">Types of Responses to This Note</h3>
        <ul>
          <li class="replies"><data>5</data> <span>Replies</span></li>
          <li class="likes"><data>9</data> <span>Likes</span></li>
          <li class="reposts"><data>1</data> <span>Repost</span></li>
          <li class="bookmarks"><data>3</data> <span>Bookmarks</span></li>
        </ul>
      
        <h3 class="vh">Syndication of This Note</h3>
        <ul>
          <li><a href="https://twitter.com/jeremyboles/status/539749149538009090">Twitter</a></li>
          <li><a href="https://www.instagram.com/p/B89FdgKBC7m/">Instgram</a></li>
          <li><a href="https://www.youtube.com/watch?v=Jd0EiwY-jbg">Youtube</a></li>
          <li><a href="https://boles.social/web/@freedcreative@merveilles.town/107572377410561742">Mastodon</a></li>
        </ul>
      </footer>
    """
  end

  def entry_summary(assigns) do
    ~H"""
      <article class={"entry_summary #{@entry.kind}"}>
        <p>
          <span class="vh">On </span><.local_time entry={@entry} /><span class="vh">,</span>
          <a class="vh" href="/">I</a> <a href={"/journal/#{@entry.kind}"}>posted a <%= @entry.kind %></a>
          <span class="vh">from</span> <.location entry={@entry} /><span class="vh">:</span>
        </p>
      
        <blockquote cite={"/journal/#{@entry.kind}"}>
          <.content entry={@entry} />
        </blockquote>
      </article>
    """
  end

  defp local_time(%{entry: %Entry{mapkit_response: resp, published_at: published_at}} = assigns) do
    date = DateTime.shift_zone!(published_at, resp["timezone"])

    ~H"""
      <time timestamp={DateTime.to_iso8601(date)}>
        <%= Calendar.strftime(date, "%b %-d") %><span class="vh">,</span><%= Calendar.strftime(date, " %Y ") %>
        <span class="vh">@</span><%= Calendar.strftime(date, " %-I:%M %p") %>
      </time>
    """
  end

  defp location(%{entry: %Entry{mapkit_response: resp}} = assigns) do
    case resp do
      %{"country" => "United States"} ->
        ~H"""
        <span><span><%= resp["locality"] %></span><span class="vh">,</span> <abbr title={resp["administrativeArea"]}><%= resp["administrativeAreaCode"] %></abbr><span class="vh">,</span> <abbr title="United States">US</abbr></span>
        """

      _ ->
        ~H"""
        <span><span><%= resp["locality"] %></span><span class="vh">,</span> <abbr title={resp["country"]}><%= resp["countryCode"] %></abbr></span>
        """
    end
  end

  def filter_by_type(assigns) do
    ~H"""
      <form class="filter_by_type">
        <fieldset>
          <legend class="vh">Filter by entry type:</legend>
          <ul>
            <li><label><input checked name="notes" type="checkbox" value> <span>Notes</span></label></li>
            <li><label><input checked name="photos" type="checkbox" value> <span>Photos</span></label></li>
            <li><label><input checked name="videos" type="checkbox" value> <span>Videos</span></label></li>
            <li><label><input checked name="quotes" type="checkbox" value> <span>Quotes</span></label></li>
            <li><label><input checked name="bookmarks" type="checkbox" value> <span>Bookmarks</span></label></li>
            <li><label><input checked name="checkins" type="checkbox" value> <span>Check-Ins</span></label></li>
            <li><label><input checked name="reposts" type="checkbox" value> <span>Reposts</span></label></li>
            <li><label><input name="likes" type="checkbox" value> <span>Likes</span></label></li>
            <li><label><input name="replies" type="checkbox" value> <span>Replies</span></label></li>
            <li><label><input name="rsvps" type="checkbox" value> <span>RSVPs</span></label></li>
            <li><label><input name="read" type="checkbox" value> <span>Read</span></label></li>
            <li><label><input name="walks" type="checkbox" value> <span>Walks</span></label></li>
          </ul>
      
          <p class="vh"><button type="submit">Filter Entries</button></p>
        </fieldset>
      </form>
    """
  end

  def location_map(assigns) do
    ~H"""
      <aside class="location_map">
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
      </aside>
    """
  end

  def metadata(assigns) do
    ~H"""
      <aside class="metadata">
        <h4 class="vh">Metadata about This Note</h4>
      
        <p>
          <span class="vh">This note was posted under the topic “</span><a href="/topic">This is a Topic Title</a><span class="vh">” and was tagged with:</span>
          <a href="/tags/pizza" rel="tag">pizza</a><span class="vh">>,</span>
          <a href="/tags/pizza" rel="tag">test</a><span class="vh">>,</span>
          <a href="/tags/pizza" rel="tag">more-test</a><span class="vh">>,</span>
          <a href="/tags/pizza" rel="tag">make-it-long</a><span class="vh">>,</span>  
          <a href="/tags/arugula" rel="tag">arugula</a><span class="vh">>,&nbsp;and</span>&nbsp;<a href="/tags/prosciutto" rel="tag">prosciutto</a><span class="vh">.</span>
        </p>
      
        <dl>
          <dt>Coordinates</dt>
          <dd data-icon="globe">48°52′4.8″N 2°21′6.5″E</dd>
      
          <dt>Location</dt>
          <dd data-icon="location-dot">Paris <abbr title="France">FR</abbr></dd>
      
          <dt>Activity</dt>
          <dd data-icon="plane">Flying</dd>
      
          <dt>Weather</dt>
          <dd data-icon="sun"><data value="24.5°C">24°<abbr title="Celsius">C</abbr></data></dd>
      
          <dt>Currently Playing</dt>
          <dd data-icon="music">Roadrunner</dd>
      
          <dt>Posted Via</dt>
          <dd data-icon="arrow-down-to-arc">Twitter</dd>
      
          <dt>Device</dt>
          <dd data-icon="tablet-screen">iPad</dd>
      
          <dt>Aperture</dt>
          <dd data-icon="aperture">ƒ/2.4</dd>
      
          <dt>Shutter</dt>
          <dd data-icon="circle-half-stroke">1⁄500</dd>
      
          <dt>Camera</dt>
          <dd data-icon="camera">iPhone 5</dd>
        </dl>
      </aside>
    """
  end

  def recent_locations(assigns) do
    ~H"""
      <footer class="recent_locations">
        <figure>      
          <figcaption>
            <p>
              There have been forty-six journal entries published over the last sixty days from four different&nbsp;locations.
            </p>
          </figcaption>
          
          <.map height="168" width="384">
            <p>Locations that I’ve posted journal entries from:</p>
            <ul>
              <li><data value="37.202039578772734,-93.27147187929123">Springfield, MO (37°12'07.3"N 93°16'17.3"W')</data></li>
              <li><data value="56.11932088728583,-3.9401846057621692">Stirling, Scotland (56°07'09.6"N 3°56'24.7"W)</data></li>
              <li><data value="43.842596263769565,10.503018539613965">Lucca, Italy (43°50'33.4"N 10°30'10.9"E)</data></li>
            </ul>
          </.map>
        </figure>
      </footer>
    """
  end

  def recent_tags(assigns) do
    ~H"""
      <aside class="recent_tags">
        <h3>Recent Tags <span class="vh">in the Journal</span></h3>
      
        <ol>
          <li><a href="/tags/colophon" rel="tag">colophon</a></li>
          <li><a href="/tags/programming" rel="tag">programming</a></li>
          <li><a href="/tags/computers" rel="tag">computers</a></li>
          <li><a href="/tags/cookware" rel="tag">cookware</a></li>
          <li><a href="/tags/beverage" rel="tag">beverage</a></li>
          <li><a href="/tags/cooking" rel="tag">cooking</a></li>
          <li><a href="/tags/wiki" rel="tag">wiki</a></li>
          <li><a href="/tags/motivation" rel="tag">motivation</a></li>
          <li><a href="/tags/mornings" rel="tag">mornings</a></li>
          <li><a href="/tags/productivity" rel="tag">productivity</a></li>
          <li><a href="/tags/ideas" rel="tag">ideas</a></li>
          <li><a href="/tags/work" rel="tag">work</a></li>
          <li><a href="/tags/git" rel="tag">git</a></li>
          <li><a href="/tags/geotracking" rel="tag">geotracking</a></li>
          <li><a href="/tags/mushrooms" rel="tag">mushrooms</a></li>
          <li><a href="/tags/valley-water-mill" rel="tag">valley-water-mill</a></li>
          <li><a href="/tags/foraging" rel="tag">foraging</a></li>
          <li><a href="/tags/garum" rel="tag">garum</a></li>
          <li><a href="/tags/fish-sauce" rel="tag">fish-sauce</a></li>
        </ol>
      </aside>
    """
  end

  def responses(assigns) do
    ~H"""
      <section class="responses">
        <h3 class="vh">Responses to This Note</h3>
      
        <article class="response">
          <header>
            <picture>
              <img alt="Brent Smith’s avatar." loading="lazy" src="/images/avatar@880w.jpg">
            </picture>
            <h4>
              <a href="https://twitter.com/BrentChad/" rel="external nofollow noopener">Brent Smith</a>
              <a href="https://twitter.com/BrentChad/status/539761772497211392" rel="external nofollow noopener">Replied on Twitter</a>
              <span class="vh">at</span> <time datetime="">6:43 am <abbr title="Central European Time">CET</abbr> <span class="vh">on</span> December 2nd, 2015</time>
            </h4>
          </header>
        
          <blockquote cite="https://twitter.com/BrentChad/status/539761772497211392">
            <p>that’s spot on</p>
          </blockquote>
        </article>
      </section>
    """
  end

  # Private components

  defp content(%{type: "bookmark"} = assigns) do
    ~H"""
      <p><a href="https://thepan-handler.com/griswold-cast-iron/" rel="external noopener">https://thepan-handler.com/griswold-cast-iron/</a></p>
      <p>We cook on one of the 1930-1939 era Griswold pans nearly every day.</p>
        
    """
  end

  defp content(%{entry: %Entry{kind: :checkin}} = assigns) do
    ~H"""
      <p>Checked in at <span class="h-card p-name u-checkin"><%= @entry.mapkit_response["name"] %></span></p>
      <%= raw @entry.content_html %>
    """
  end

  defp content(%{entry: %Entry{kind: :note}} = assigns) do
    ~H"""
      <%= raw @entry.content_html %>
    """
  end

  defp content(%{type: "photo"} = assigns) do
    ~H"""
      <figure>
        <picture>
          <source sizes="400px" srcset="https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@800w.jpg 800w, https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@400w.jpg 400w" type="image/jpeg">
          <img alt="Mansard rooftops in Paris, France" class="u-photo" loading="lazy" src="https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@400w.jpg">
        </picture>
        <figcaption>
          <p>The view from my the window outside of my apartment in&nbsp;Paris.</p>
        </figcaption>
      </figure>
    """
  end

  defp content(%{type: "quote"} = assigns) do
    ~H"""
      <figure>
        <blockquote>Travel changes you. As you move through this life and this world you change things slightly, you leave marks behind, however small. And in return, life—and travel—leaves marks on&nbsp;you.</blockquote>
        <figcaption>Anthony Bourdain, <cite>The Nasty Bits</cite></figcaption>
      </figure>
    """
  end

  defp content(%{type: "video"} = assigns) do
    ~H"""
      <figure>
        <video loop muted playsinline poster="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@240p.jpg" preload="none">
          <source src="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@240p.mp4" type="video/mp4">
          
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

        <figcaption>
          <p>I’ve never felt so out of place in my life.</p>
        </figcaption>
      </figure>
    """
  end

  defp entry_content(%{type: "bookmark"} = assigns) do
    ~H"""
      <div class="entry_content bookmark">
        <figure>
          <p><a href="https://thepan-handler.com/griswold-cast-iron/" rel="external noopener">https://thepan-handler.com/griswold-cast-iron/</a></p>
          <figcaption><p>This Airbnb that I booked is perfect for solo exploration during my first trip to Paris.</p></figcaption>
        </figure>
      </div>
    """
  end

  defp entry_content(%{type: "checkin"} = assigns) do
    ~H"""
      <div class="entry_content checkin">
        <figure>
          <p>Checked in at <a href="https://www.schiphol.nl/">Amsterdam Airport Schiphol</a></p>
          <figcaption><%= raw @entry.content_html %></figcaption>
        </figure>
      </div>
    """
  end

  defp entry_content(%{type: "note"} = assigns) do
    ~H"""
      <div class="entry_content note">
        <%= raw @entry.content_html %>
      </div>
    """
  end

  defp entry_content(%{type: "photo"} = assigns) do
    ~H"""
      <div class="entry_content photo">
        <figure>
          <picture>
            <source sizes="1124px" srcset="https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@800w.jpg 800w, https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@400w.jpg 400w" type="image/jpeg">
            <img alt="Mansard rooftops in Paris, France" class="u-photo" loading="lazy" src="https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@400w.jpg">
          </picture>
          <figcaption class="e-content p-name">
            <p>The view from my the window outside of my apartment in&nbsp;Paris.</p>
          </figcaption>
        </figure>
      </div>
    """
  end

  defp entry_content(%{type: "quote"} = assigns) do
    ~H"""
      <div class="entry_content quote">
         <figure>
           <blockquote>Travel changes you. As you move through this life and this world you change things slightly, you leave marks behind, however small. And in return, life—and travel—leaves marks on&nbsp;you.</blockquote>
           <figcaption>Anthony Bourdain, <cite>The Nasty Bits</cite></figcaption>
         </figure>
      </div>
    """
  end

  defp entry_content(%{type: "video"} = assigns) do
    ~H"""
      <div class="entry_content video">
        <figure>
          <video controls loop muted playsinline poster="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@240p.jpg" preload="none">
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
        
          <figcaption>
            <p>I’ve never felt so out of place in my life.</p>
          </figcaption>
        </figure>
      </div>
    """
  end
end
