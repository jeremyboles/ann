defmodule Foilsigh.EssaysComponent do
  use Foilsigh, :component

  def content(assigns) do
    ~H"""
      <div class="content">
        <p>
          Tufte CSS provides tools to style web articles using the ideas demonstrated by Edward Tufte’s books and handouts. Tufte’s style is known for its simplicity, extensive use of sidenotes, tight integration of graphics with text, and
          carefully chosen&nbsp;typography.
        </p>
        <p>
          Tufte CSS was created by Dave Liepmann and is now an Edward Tufte project. The original idea was cribbed from Tufte-LATEX and R Markdown’s Tufte Handout format. We give hearty thanks to all the people who have contributed to
          those&nbsp;projects.
        </p>
      
        <figure class="sidebar">
          <picture>
            <img alt="Jeremy Boles, indoors and smiling" class="u-photo" loading="lazy" src="/images/masthead@2048w.jpg">
          </picture>
          <figcaption>
            There were lots of tired looking commuters on the train ride into&nbsp;Paris.
          </figcaption>
        </figure>
      
        <p>If you see anything that Tufte CSS could improve, we welcome your contribution in the form of an issue or pull request on the GitHub project: tufte-css. Please note the contribution&nbsp;guidelines.</p>
        <p>
          Finally, a reminder about the goal of this project. The web is not print. Webpages are not books. Therefore, the goal of Tufte CSS is not to say “websites should look like this interpretation of Tufte’s books” but rather “here are
          some techniques Tufte developed that we’ve found useful in print; maybe you can find a way to make them useful on the web”. Tufte CSS is merely a sketch of one way to implement this particular set of ideas. It should be a starting
          point, not a design goal, because any project should present their information as best suits their particular&nbsp;circumstances.
        </p>
      
        <h2>Getting&nbsp;Started</h2>
        <p>To use Tufte CSS, copy tufte.css and the et-book directory of font files to your project directory, then add the following to your HTML document’s head&nbsp;block:</p>
        <pre><code>&lt;link rel="stylesheet" href="tufte.css" /&gt;</code></pre>
        <p>Now you just have to use the provided CSS rules, and the Tufte CSS conventions described in this document. For best results, View Source and Inspect Element&nbsp;frequently.</p>
      
        <h2>Fundamentals</h2>
        <h3>Sections and&nbsp;Headings</h3>
        <p>Organize your document with an article element inside your body tag. Inside that, use section tags around each logical grouping of text and&nbsp;headings.</p>
      
        <figure class="full">
          <picture>
            <img alt="" height="1125" loading="lazy" src="/images/masthead@2048w.jpg" width="1688" />
          </picture>
          <figcaption>
            The view from my the window outside of my apartment in&nbsp;Paris.
          </figcaption>
        </figure>
      
        <p>
          Tufte CSS&nbsp;uses <code>h1</code> for the document&nbsp;title, <code>p</code> with class subtitle for the document&nbsp;subtitle, <code>h2</code> for section headings,&nbsp;and <code>h3</code> for low-level headings. More specific
          headings are not supported. If you feel the urge to reach for a heading of level 4 or greater, consider redesigning your&nbsp;document:
        </p>
      
        <blockquote cite="http://www.edwardtufte.com/bboard/q-and-a-fetch-msg?msg_id=0000hB">
          <p>
            [It is] notable that the Feynman lectures (3 volumes) write about all of physics in 1800 pages, using only 2 levels of hierarchical headings: chapters and A-level heads in the text. It also uses the methodology&nbsp;of
            <em>sentences</em> which then cumulate sequentially&nbsp;into <em>paragraphs</em>, rather than the grunts of bullet points. Undergraduate Caltech physics is very complicated material, but it didn’t require an elaborate hierarchy
            to&nbsp;organize.
          </p>
          <footer>
            <a href="http://www.edwardtufte.com/bboard/q-and-a-fetch-msg?msg_id=0000hB">Edward Tufte, forum post, ‘Book design: advice and examples’&nbsp;thread</a>
          </footer>
        </blockquote>
      
        <p>
          As a bonus, this excerpt regarding the use of headings provides an example of block quotes. In Tufte CSS they are just lightly styled, semantically correct HTML using blockquote and footer elements. See page 20 of The Visual Display
          of Quantitative Information for an example in&nbsp;print.
        </p>
        <p>
          In his later&nbsp;books <label for="sd-1"></label><input id="sd-1" type="checkbox" /><span><span>(</span>Beautiful Evidence, right? Its fine. Its not be. Right? That’s not&nbsp;fine.<span>)</span></span>, Tufte starts each section
          with a bit of vertical space, a non-indented paragraph, and the first few words of the sentence set in small caps. For this we use a span with the class newthought, as demonstrated at the beginning of this paragraph. Vertical spacing
          is accomplished separately&nbsp;through <code>&lt;section&gt;</code> tags. Be consistent: though we do so in this paragraph for the purpose of demonstration, do not alternate use of header elements and the newthought technique. Pick
          one approach and stick to&nbsp;it.
        </p>
      
        <h3>Text</h3>
        <p>
          Although paper handouts obviously have a pure white background, the web is better served by the use of slightly off-white and off-black colors. Tufte CSS uses #fffff8 and #111111 because they are nearly indistinguishable from their
          ‘pure’ cousins, but dial down the harsh contrast. We stick to the greyscale for text, reserving color for specific, careful use in figures and&nbsp;images.
        </p>
      
        <h3>Figures</h3>
        <p>
          Tufte emphasizes tight integration of graphics with text. Data, graphs, and figures are kept with the text that discusses them. In print, this means they are not relegated to a separate page. On the web, that means readability of
          graphics and their accompanying text without extra clicks, tab-switching, or&nbsp;scrolling.
        </p>
        <p>
          Figures should try to use the figure element, which by default are constrained to the main column. Don’t wrap figures in a paragraph tag. Any label or margin note goes in a regular margin note inside the figure. For example, most of
          the time one should introduce a figure directly into the main flow of discussion, like&nbsp;so:
        </p>
      
        <figure>
          <picture>
            <img alt="" height="1125" loading="lazy" src="/images/masthead@2048w.jpg" width="1688" />
          </picture>
          <figcaption>
            This is a picture that I took while Danielle and I were in Vernazza,&nbsp;Italy.
          </figcaption>
      
        </figure>
        <p>
          Tufte CSS provides tools to style web articles using the ideas demonstrated by Edward Tufte’s books and handouts. Tufte’s style is known for its simplicity, extensive use of sidenotes, tight integration of graphics with text, and
          carefully chosen&nbsp;typography.
        </p>
      
        <hr>
        
        <p>
          Tufte CSS was created by Dave Liepmann and is now an Edward Tufte project. The original idea was cribbed from Tufte-LATEX and R Markdown’s Tufte Handout format. We give hearty thanks to all the people who have contributed to
          those&nbsp;projects.
        </p>
        <p>If you see anything that Tufte CSS could improve, we welcome your contribution in the form of an issue or pull request on the GitHub project: tufte-css. Please note the contribution&nbsp;guidelines.</p>
      
        <figure class="breakout">
          <picture>
            <img alt="" height="1125" loading="lazy" src="/images/masthead@2048w.jpg" width="1724" />
          </picture>
          <figcaption>
            The view from my the window outside of my apartment in&nbsp;Paris.
          </figcaption>
        </figure>
      
        <p>
          Finally, a reminder about the goal of this project. The web is not print. Webpages are not books. Therefore, the goal of Tufte CSS is not to say “websites should look like this interpretation of Tufte’s books” but rather “here are
          some techniques Tufte developed that we’ve found useful in print; maybe you can find a way to make them useful on the web”. Tufte CSS is merely a sketch of one way to implement this particular set of ideas. It should be a starting
          point, not a design goal, because any project should present their information as best suits their particular&nbsp;circumstances.
        </p>
      </div>
    """
  end

  def header(assigns) do
    ~H"""
      <header class="header">
        <h1><a href="/">Brilliant Hardware in the Valley of the Software&nbsp;Slump</a></h1>
        <p>Our software feels less refined as our hardware achieves platonic&nbsp;ideals.</p>
      
        <aside>
          <p>
            <span class="vh">This piece of writing was posted under the topic “</span><a href="/topic">Topic Title</a><span class="vh">” on</span>
            <time datetime="2021-10-26">October 26<span class="sc">th</span>,&nbsp;2021</time><span class="vh">.</span>
          </p>
        </aside>
      </header>
    """
  end

  def essay_summary(%{featured: true, inner_block: _} = assigns) do
    ~H"""
      <article class="essay_summary featured">
        <a href="/essays/show">
          <.essay_summary_figure />
          <h2><%= @title %></h2>
        </a>
        <p><%= render_slot(@inner_block) %></p>
        <.essay_summary_meta date />
      </article>
    """
  end

  def essay_summary(assigns) do
    ~H"""
      <article class="essay_summary">
        <a href="/essays/show">
          <.essay_summary_figure />
          <h2><%= @title %></h2>
        </a>
        <.essay_summary_meta />
      </article>
    """
  end

  def replies(assigns) do
    ~H"""
      <aside class="replies">
        <h3 class="vh">Replies to “This is the Article Name”</h3>
      
        <article class="reply">
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
      
        <article class="reply">
          <header>
            <picture>
              <img alt="Brent Smith’s avatar." loading="lazy" src="/images/avatar@880w.jpg">
            </picture>
            <h4>
              <a href="https://example.com">Brent Smith</a>
              <a href="https://example.com" rel="external nofollow noopener">Replied on Twitter</a>
              <span class="vh">at</span> <time datetime="">6:43 am <abbr title="Central European Time">CET</abbr> <span class="vh">on</span> December 2nd, 2015</time>
            </h4>
          </header>
      
          <blockquote cite="https://twitter.com/BrentChad/status/539761772497211392">
            <p>I'm sort of relieved to hear that everyone hates the MacBook keyboards and it wasn't just me being grumpy. I bought two of them when they first came out in 2016 and returned them after just a few days because of keyboard misfires and general typing uncomfortableness.</p>
          </blockquote>
        </article>
      </aside>
    """
  end

  def responses(assigns) do
    ~H"""
      <aside class="responses">
        <h3 class="vh">Other Responses to “This is the Article Name”</h3>
      
        <details class="likes responses">
          <summary>Liked 20 Times</summary>
          <p>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">, and</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">, and</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">, and</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg">
            </picture></a>
          </p>
        </details>
      
        <details class="responses reposts">
          <summary>Reposted Once</summary>
          <p>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
              <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg">
            </picture></a>
          </p>
        </details>
      
        <details class="bookmarks responses">
          <summary>Bookmarked Three Times</summary>
          <p>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">,</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg"></picture></a><span class="vh">, and</span>
            <a href="https://jeremyboles.com/" rel="external nofollow noopener"><picture>
                <img alt="Brent Smith" loading="lazy" src="/images/avatar@880w.jpg">
            </picture></a>
          </p>
        </details>
      </aside>
    """
  end

  def syndication(assigns) do
    ~H"""
      <footer class="syndication">
        <p><span class="vh">“This is the Article Name” has been</span> <span> syndicated to:</span></p>
        <ul>
          <li><a href="http://medium.com" title="Syndicated to Medium">Medium</a></li>
          <li><a href="http://soundcloud.com" title="Syndicated to Soundcloud">Soundcloud</a></li>
          <li><a href="http://vimeo.com" title="Syndicated to Vimeo">Vimeo</a></li>
          <li><a href="http://youtube.com" title="Syndicated to Youtube">Youtube</a></li>
        </ul>
      </footer>
    """
  end

  def webmention_form(assigns) do
    ~H"""
      <aside class="webmention_form">
        <p>
          Have a comment or response about this essay? Publish it on your own site and use a
          <a href="/indieweb#webmention">Webmention</a>, or let me know the
          <abbr title="Uniform Resource Locators (i.e. a webpage address)">URL</abbr> by using the form&nbsp;below:
        </p>
      
        <form method="post">
          <p>
            <label for="response-url-field">URL to Your Response</label>
            <input id="response-url-field" name="response-url" placeholder="https://example.com/response" required type="url">
            <button type="submit">Send It to Me</button>
          </p>
        </form>
      </aside>
    """
  end

  defp essay_summary_figure(assigns) do
    ~H"""
      <figure>
        <picture>
          <img alt="" loading="lazy" height="837" src="https://imagedelivery.net/Wfox5u9ZjFI2UCRBV0RBtA/fcfe1709-5c58-499d-cc25-90b26661fc00/public" width="1256">
        </picture>
      </figure>
    """
  end

  defp essay_summary_meta(%{date: _} = assigns) do
    ~H"""
      <aside>
        <p>
          <span class="vh">This piece of writing was posted under the topic “</span><a href="/topic">Topic Title</a><span class="vh">” on</span>
          <time datetime="2021-10-26">October 26<span>th</span>,&nbsp;2021</time><span class="vh">.</span>
        </p>
      </aside>
    """
  end

  defp essay_summary_meta(assigns) do
    ~H"""
      <aside>
        <p>
          <span class="vh">This piece of writing was posted under the topic “</span><a href="/topic">Topic Title</a><span class="vh">.</span>
        </p>
      </aside>
    """
  end
end
