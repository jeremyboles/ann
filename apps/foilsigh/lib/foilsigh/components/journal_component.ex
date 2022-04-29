defmodule Foilsigh.JournalComponent do
  use Foilsigh, :component

  import Foilsigh.GraphicsComponent

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

  def entry_summary(%{type: type} = assigns) do
    ~H"""
      <article class={"entry_summary #{type}"}>
        <p>
          <span class="vh">On</span> <time datetime="2013-06-13 12:00:00">Dec 2<span class="vh">,</span> 2014 <span class="vh">@</span> 5:53 am</time><span class="vh">,</span>
          <a class="vh" href="/">I</a> <a href={"/journal/#{type}"}>posted a <%= type %></a>
          <span class="vh">from</span> <span><span>Paris</span><span class="vh">,</span> <abbr title="France">FR</abbr></span><span class="vh">:</span>
        </p>
      
        <blockquote cite={"/journal/#{type}"}>
          <.content type={type} />
        </blockquote>
      </article>
    """
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

  # Private components

  defp content(%{type: "bookmark"} = assigns) do
    ~H"""
      <p><a href="https://thepan-handler.com/griswold-cast-iron/" rel="external noopener">https://thepan-handler.com/griswold-cast-iron/</a></p>
      <p>We cook on one of the 1930-1939 era Griswold pans nearly every day.</p>
        
    """
  end

  defp content(%{type: "checkin"} = assigns) do
    ~H"""
      <p>Checked in at <span class="h-card p-name u-checkin">Schiphol Airport</span></p>
      <p>AMS ✈ DAR</p>
    """
  end

  defp content(%{type: "note"} = assigns) do
    ~H"""
      <p>Nothing says “long flight to Europe” like&nbsp;Nescafé. Nothing says “long flight to Europe” like&nbsp;Nescafé.</p>
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
end
