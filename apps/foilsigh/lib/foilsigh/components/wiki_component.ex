defmodule Foilsigh.WikiComponent do
  use Foilsigh, :component

  def breadcrumbs(assigns) do
    ~H"""
      <nav aria-labelledby="topic-breadcrumb-nav-label" class="breadcrumbs" id="topic-breadcrumb">
        <p><span id="topic-breadcrumb-nav-label">Breadcrumb</span> navigation:</p>
        <ol>
          <li><a href="/wiki">Wiki</a></li>
          <li><a href="/travel">Travel</a></li>
          <li><a href="/trips">Trips</a></li>
          <li><a aria-current="page" href="/scotland-2018">Scotland, 2018</a></li>
        </ol>
      </nav>
    """
  end

  def content(assigns) do
    ~H"""
      <div class="content">
        <nav aria-labelledby="topic-table-of-contents">
          <p id="topic-table-of-contents">Table of contents:</p>
          <ol>
            <li><a href="#theitinerary">The&nbsp;Itinerary</a></li>
            <li><a href="#memorablefood">Memorable&nbsp;Food</a></li>
            <li><a href="#notable-gearused">Notable Gear&nbsp;Used</a></li>
            <li><a href="#favoritesmoments">Favorites&nbsp;Moments</a></li>
            <li><a href="#things-ilearned">Things I&nbsp;Learned</a></li>
          </ol>
        </nav>
      
        <div>
          <p>This trip was my first time leaving North America and, thus, my first overnight flight across the Atlantic. This was also the first&nbsp;major <a href="/solo-travel">solo&nbsp;travel</a> trek that I&nbsp;took.</p>
          <p>
            I used&nbsp;the <a href="http://2012.ull.ie" rel="external noopener">Úll&nbsp;conference</a> in Dublin as an excuse to travel to Ireland. However, my ulterior motive was selfish: with the quickly approaching birth of my daughter, I
            thought that this was my last chance to go on a trip like&nbsp;this.
          </p>
          <p>I was away from home for seven days while I stayed in Dublin and took a small one-night trip down to&nbsp;Wicklow.</p>
          <h2 id="theitinerary">The&nbsp;Itinerary</h2>
          <ul>
            <li>I left Springfield mid-afternoon on April 24th and arrived in Dublin the morning of the&nbsp;25th.</li>
            <li>I stayed in a grubby hostel north of O’Connell Street that used to be a&nbsp;convent.</li>
            <li>I attended the conference, which was held at Dublin Castle, on the 27th and&nbsp;28th.</li>
            <li>On April 29th, I took the train down to Wicklow to escape hostel fatigue and stayed in a&nbsp;bed-and-breakfast.</li>
            <li>On April 30th, I headed back to Dublin and rented a room at O’Shea’s&nbsp;pub.</li>
            <li>I flew back home to Springfield on May&nbsp;1st.</li>
          </ul>
      
          <h2 id="memorablefood">Memorable&nbsp;Food</h2>
          <p>
            Before this trip, I was a full-on craft beer stob and used to turn my nose at Guinness. After escaping the dreary weather inside a warm, cozy pub with a pint of Guinness, how can you not become romantically enthralled with
            the&nbsp;drink?
          </p>
          <p>While staying at the inn in Wicklow, I was served a fish that was so tough that I couldn’t even cut through it with my knife. I think I offended the server by not eating&nbsp;it.</p>
          <h2 id="notable-gearused">Notable Gear&nbsp;Used</h2>
          <p>I used the heavy backpack that I used for overnight backpacking excursions on this trip, and it nearly killed me. Not only was it heavy, but it was also bulky, and I kept bumping into&nbsp;things.</p>
          <p>
            I had just started working&nbsp;with <a href="/hipstamatic">Hipstamatic</a> the year before&nbsp;and <em>heavily</em> into that style of mobile photography. Nearly all of my photos from that trip are heavily filtered and look like there
            were taken on expired&nbsp;film.
          </p>
          <h2 id="favoritesmoments">Favorites&nbsp;Moments</h2>
          <p>
            I met one of Ireland’s barista champions at a cafe that I frequented while I was there. She gave me free coffee when she found out that my wife was also a barista. It was a pleasant environment to hang out in, especially when I felt
            like a fish out of water being in a different culture for the first&nbsp;time.
          </p>
          <p>
            I shared a few beers ins the hostel dormitory with a strange Irish man that kept asking me about guns in America. He had a thick Irish accent, wore old-timey striped pajamas, and kept asking how far a shotgun could shoot. It creeped me
            out, but I had to sleep in the same room as him. To avoid seeing him again the next day, I snuck out very early in the morning to catch the train to&nbsp;Wicklow.
          </p>
          <h2 id="things-ilearned">Things I&nbsp;Learned</h2>
          <p>Things like what side of the road you drive on the influence your instincts in ways you don’t realize. I kept running into people on the street because my instinct was to pass them on the right, and theirs was the&nbsp;opposite.</p>
          <p>The Guinness factory is just a giant commercial. The view from the pub up top is nice,&nbsp;though.</p>
        </div>
      </div>
    """
  end

  def essays(assigns) do
    ~H"""
      <aside class="essays">
        <h3>Related Essays</h3>
      
        <article class="h-entry article">
          <picture>
            <source sizes="558px" srcset="https://f000.backblazeb2.com/file/jeremyboles-com/topic_essay@588w.jpg 588w, https://f000.backblazeb2.com/file/jeremyboles-com/topic_essay@1176w.jpg 1176w" type="image/jpeg">
            <img alt="A chapel of an old, stone church with sunlight streaming through" src="https://f000.backblazeb2.com/file/jeremyboles-com/topic_essay@588w.jpg" />
          </picture>
          <h4 class="p-name"><a class="u-uid u-url" href="/essays/asdf">Getting to My Airbnb in Paris</a></h4>
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
        <h2><a href="/" rel="bookmark">Trip to Scotland, 2018</a></h2>
        <p>
          <span>Tagged with:</span>
          <a href="/tags/trip" rel="tag">trips</a>
          <a href="/tags/scotland" rel="tag">scotland</a>
          <a href="/tags/kids" rel="tag">kids</a>
          <a href="/tags/europe" rel="tag">europe</a>
        </p>
      </header>
    """
  end

  def journal(assigns) do
    ~H"""
      <section class="h-feed journal">
        <h3 class="p-name">Latest Journal Entries About “Scotland, 2018”</h3>
      
        <article class="h-entry note">
          <p>
            <span>On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span>,</span> 2014 <span>@</span> 5:53 am</time><span>,</span>
            <a class="h-card p-author" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">posted a note</a>
            <span>from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span>,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span>:</span>
          </p>
      
          <blockquote cite="/journal/6T51WU" class="e-content p-name">
            <p>Nothing says “long flight to Europe” like Nescafé.</p>
          </blockquote>
        </article>
      
        <article class="h-entry photo">
          <p>
            <span>On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span>,</span> 2014 <span>@</span> 5:53 am</time><span>,</span>
            <a class="h-card p-author" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">posted a photo</a>
            <span>from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span>,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span>:</span>
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
            <span>On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span>,</span> 2014 <span>@</span> 5:53 am</time><span>,</span>
            <a class="h-card p-author" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">was at a location</a>
            <span>in</span> <span class="h-adr p-location"><span class="p-locality">Amsterdam</span><span>,</span> <abbr class="p-country-name" title="Netherlands">NL</abbr></span><span>:</span>
          </p>
      
          <blockquote cite="/journal/6T51WU" class="e-content p-name">
            <p>Checked in at <span class="h-card p-name u-checkin">Schiphol Airport</span></p>
            <p>AMS ✈ DAR</p>
          </blockquote>
        </article>
      
        <article class="h-entry video">
          <p>
            <span>On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span>,</span> 2014 <span>@</span> 5:53 am</time><span>,</span>
            <a class="h-card p-author" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">posted a video</a>
            <span>from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span>,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span>:</span>
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
            <span>On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span>,</span> 2014 <span>@</span> 5:53 am</time><span>,</span>
            <a class="h-card p-author" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">bookmarked a webpage</a>
            <span>from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span>,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span>:</span>
          </p>
      
          <blockquote cite="/journal/6T51WU" class="e-content p-name">
            <p><a class="u-bookmark-of" href="https://thepan-handler.com/griswold-cast-iron/" rel="external noopener" to="https://thepan-handler.com/griswold-cast-iron">https://thepan-handler.com/griswold-cast-iron/</a></p>
            <p>We cook on one of the 1930-1939 era Griswold pans nearly every day.</p>
          </blockquote>
        </article>
      
        <article class="h-entry quote">
          <p>
            <span>On</span> <time class="dt-published" datetime="2013-06-13 12:00:00">Dec 2<span>,</span> 2014 <span>@</span> 5:53 am</time><span>,</span>
            <a class="h-card p-author" href="/">I</a> <a class="u-uid u-url" href="/journal/6T51WU">posted a quote</a>
            <span>from</span> <span class="h-adr p-location"><span class="p-locality">Paris</span><span>,</span> <abbr class="p-country-name" title="France">FR</abbr></span><span>:</span>
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
        <li>
            <a href="/about">About&nbsp;Jeremy</a>
            <ul>
              <li><a href="/now">What I’m Doing&nbsp;Now</a></li>
              <li><a href="/uses">Things I&nbsp;Use</a></li>
            </ul>
        </li>
        <li><a href="/adhd">ADHD</a></li>
        <li><a href="/camper">Camper</a></li>
        <li><a href="/colophon">Colophon</a></li>
        <li>
            <a href="/food">Food &amp;&nbsp;Drink</a>
            <ul>
              <li><a href="/coffee">Coffee</a></li>
              <li>
                  <a href="/cooking">Cooking</a>
                  <ul>
                    <li><a href="/gluten-free">Gluten-Free</a></li>
                    <li><a href="/sous-vide">Sous&nbsp;Vide</a></li>
                  </ul>
              </li>
              <li>
                  <a href="/foraging">Foraging</a>
                  <ul>
                    <li><a href="/wine-caps">Wine Cap&nbsp;Mushrooms</a></li>
                  </ul>
              </li>
              <li><a href="/pizza">Pizza</a></li>
            </ul>
        </li>
        <li>
            <a href="/life">Life</a>
            <ul>
              <li><a href="/covid-19">COVID-19</a></li>
            </ul>
        </li>
        <li>
            <a href="/technology">Technology</a>
            <ul>
              <li><a href="/blimpos">BlimpOS</a></li>
              <li><a href="/fish-shell">Fish&nbsp;Shell</a></li>
              <li><a href="/nixos">NixOS</a></li>
              <li>
                  <a href="/programming">Programming</a>
                  <ul>
                    <li><a href="/javascript">Javascript</a></li>
                  </ul>
              </li>
              <li>
                  <a href="/web">World-Wide&nbsp;Web</a>
                  <ul>
                    <li><a href="/indieweb">IndieWeb</a></li>
                    <li><a href="/ssg">Static Site&nbsp;Generators</a></li>
                  </ul>
              </li>
            </ul>
        </li>
        <li>
            <a href="/travel">Travel</a>
            <ul>
              <li><a href="/solo-travel">Solo&nbsp;Travel</a></li>
              <li><a href="/travel-gear">Travel&nbsp;Gear</a></li>
              <li>
                  <a href="/trips">Trips</a>
                  <ul>
                    <li><a href="/ireland-2012">Ireland,&nbsp;2012</a></li>
                    <li><a href="/ireland-2013">Ireland,&nbsp;2013</a></li>
                    <li><a href="/ireland-2015">Ireland,&nbsp;2015</a></li>
                    <li><a href="/ireland-2017">Ireland,&nbsp;2017</a></li>
                    <li><a href="/italy-2013">Italy,&nbsp;2013</a></li>
                    <li><a href="/italy-2016">Italy,&nbsp;2016</a></li>
                    <li><a href="/italy-2017">Italy,&nbsp;2017</a></li>
                    <li><a href="/italy-2018">Italy,&nbsp;2018</a></li>
                    <li><a href="/new-england-2014">New England,&nbsp;2014</a></li>
                    <li><a href="/new-york-2014">New York City,&nbsp;2014</a></li>
                    <li><a href="/scotland-2019">Scotland,&nbsp;2019</a></li>
                    <li><a href="/tanzania-2014">Tanzania,&nbsp;2014</a></li>
                    <li><a href="/vancouver-2012">Vancouver BC,&nbsp;2013</a></li>
                  </ul>
              </li>
            </ul>
        </li>
        <li><a href="/valley-water-mill">Valley Water&nbsp;Mill</a></li>
        <li>
            <a href="/work">Work</a>
            <ul>
              <li>
                  <a href="/central-standard">Central&nbsp;Standard</a>
                  <ul>
                    <li><a href="/office">Office</a></li>
                  </ul>
              </li>
              <li><a href="/hipstamatic">Hipstamatic</a></li>
              <li>
                  <a href="/projects">Projects</a>
                  <ul>
                    <li><a href="/bloom">Bloom</a></li>
                    <li><a href="/mockingbird">Mockingbird</a></li>
                    <li><a href="/scribe">Scribe</a></li>
                  </ul>
              </li>
            </ul>
        </li>
        <li>
            <a href="/about">About&nbsp;Jeremy</a>
            <ul>
              <li><a href="/now">What I’m Doing&nbsp;Now</a></li>
              <li><a href="/uses">Things I&nbsp;Use</a></li>
            </ul>
        </li>
        <li><a href="/adhd">ADHD</a></li>
        <li><a href="/camper">Camper</a></li>
        <li><a href="/colophon">Colophon</a></li>
        <li>
            <a href="/food">Food &amp;&nbsp;Drink</a>
            <ul>
              <li><a href="/coffee">Coffee</a></li>
              <li>
                  <a href="/cooking">Cooking</a>
                  <ul>
                    <li><a href="/gluten-free">Gluten-Free</a></li>
                    <li><a href="/sous-vide">Sous&nbsp;Vide</a></li>
                  </ul>
              </li>
              <li>
                  <a href="/foraging">Foraging</a>
                  <ul>
                    <li><a href="/wine-caps">Wine Cap&nbsp;Mushrooms</a></li>
                  </ul>
              </li>
              <li><a href="/pizza">Pizza</a></li>
            </ul>
        </li>
        <li>
            <a href="/life">Life</a>
            <ul>
              <li><a href="/covid-19">COVID-19</a></li>
            </ul>
        </li>
        <li>
            <a href="/technology">Technology</a>
            <ul>
              <li><a href="/blimpos">BlimpOS</a></li>
              <li><a href="/fish-shell">Fish&nbsp;Shell</a></li>
              <li><a href="/nixos">NixOS</a></li>
              <li>
                  <a href="/programming">Programming</a>
                  <ul>
                    <li><a href="/javascript">Javascript</a></li>
                  </ul>
              </li>
              <li>
                  <a href="/web">World-Wide&nbsp;Web</a>
                  <ul>
                    <li><a href="/indieweb">IndieWeb</a></li>
                    <li><a href="/ssg">Static Site&nbsp;Generators</a></li>
                  </ul>
              </li>
            </ul>
        </li>
        <li>
            <a href="/travel">Travel</a>
            <ul>
              <li><a href="/solo-travel">Solo&nbsp;Travel</a></li>
              <li><a href="/travel-gear">Travel&nbsp;Gear</a></li>
              <li>
                  <a href="/trips">Trips</a>
                  <ul>
                    <li><a href="/ireland-2012">Ireland,&nbsp;2012</a></li>
                    <li><a href="/ireland-2013">Ireland,&nbsp;2013</a></li>
                    <li><a href="/ireland-2015">Ireland,&nbsp;2015</a></li>
                    <li><a href="/ireland-2017">Ireland,&nbsp;2017</a></li>
                    <li><a href="/italy-2013">Italy,&nbsp;2013</a></li>
                    <li><a href="/italy-2016">Italy,&nbsp;2016</a></li>
                    <li><a href="/italy-2017">Italy,&nbsp;2017</a></li>
                    <li><a href="/italy-2018">Italy,&nbsp;2018</a></li>
                    <li><a href="/new-england-2014">New England,&nbsp;2014</a></li>
                    <li><a href="/new-york-2014">New York City,&nbsp;2014</a></li>
                    <li><a href="/scotland-2019">Scotland,&nbsp;2019</a></li>
                    <li><a href="/tanzania-2014">Tanzania,&nbsp;2014</a></li>
                    <li><a href="/vancouver-2012">Vancouver BC,&nbsp;2013</a></li>
                  </ul>
              </li>
            </ul>
        </li>
        <li><a href="/valley-water-mill">Valley Water&nbsp;Mill</a></li>
        <li>
            <a href="/work">Work</a>
            <ul>
              <li>
                  <a href="/central-standard">Central&nbsp;Standard</a>
                  <ul>
                    <li><a href="/office">Office</a></li>
                  </ul>
              </li>
              <li><a href="/hipstamatic">Hipstamatic</a></li>
              <li>
                  <a href="/projects">Projects</a>
                  <ul>
                    <li><a href="/bloom">Bloom</a></li>
                    <li><a href="/mockingbird">Mockingbird</a></li>
                    <li><a href="/scribe">Scribe</a></li>
                  </ul>
              </li>
            </ul>
        </li>
      </ul>
    """
  end

  def related(assigns) do
    ~H"""
      <aside class="related">
        <h3>Related Wiki Topics</h3>
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
end
