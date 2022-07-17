defmodule Foilsigh.CalendarComponent do
  use Foilsigh, :component

  alias Taifead.Journal.Entry
  alias Taifead.Topics.Publication

  def chronology(assigns) do
    ~H"""
      <section class="chronology">
        <h2><span class="vh">Published in</span> 2022</h2>
      
        <section>
          <h3><span class="vh">Content from</span> September<span class="vh">, 2022</span></h3>
      
          <section>
            <.event type="note">
              <p>Nothing says “long flight to Europe” like Nescafé.</p>
            </.event>
            <.event type="essay">
              <h5><a href="#">SVGs Are Cool</a></h5>
              <p>Suddenly, everyone I know is abandoning their&nbsp;pod.</p>
            </.event>
          </section>
        </section>
      
        <section>
          <h3><span class="vh">Content from</span> October<span class="vh">, 2022</span></h3>
      
          <section>
            <.event type="photo">
              <picture>
                <source sizes="800px" srcset="https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@800w.jpg 800w, https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@400w.jpg 400w" type="image/jpeg">
                <img alt="Mansard rooftops in Paris, France" class="u-photo" loading="lazy" src="https://f000.backblazeb2.com/file/jeremyboles-com/topic_journal@400w.jpg">
              </picture>
            </.event>
            
            <.event type="wiki_new">
            </.event>
            
            <.event type="wiki_update">
            </.event>
      
            <.event type="checkin">
              <p>AMS ✈ DAR</p>
            </.event>

            <.event type="bookmark">
              <p><a href="#">https://www.airbnb.com/rooms/3528969</a></p>
            </.event>

          </section>
        </section>
      
        <section>
          <h3><span class="vh">Content from</span> August<span class="vh">, 2022</span></h3>
      
          <section>
            <.event type="video">
              <picture>
                <source sizes="800px" srcset="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@720p.jpg 800w" type="image/jpeg">
                <img alt="Mansard rooftops in Paris, France" class="u-photo" loading="lazy" src="https://f000.backblazeb2.com/file/jeremyboles-com/journal_video@240p.jpg">
              </picture>
            </.event>
            
            <.event type="quote">
             <p>“Travel changes you. As you move through this life and this world you change things…”</p>
            </.event>
          </section>
        </section>
      </section>
    """
  end

  def event(%{type: type} = assigns) do
    ~H"""
      <article class={"event #{type}"}>
        <h4><span class="vh">On</span> <.local_time_abbr item={@item} /><span class="vh">,</span> <a href={url_path(@item)}><span class="vh">I</span> <%= event_text(type, @item) %></a><span class="vh">:</span></h4>
        <blockquote><%= render_slot(@inner_block) %></blockquote>
      </article>
    """
  end

  def url_path(%Entry{url_slug: url_slug}), do: "/journal/#{url_slug}/"
  def url_path(%Publication{url_slug: url_slug}), do: "/#{url_slug}/"

  def month_breakdown(assigns) do
    ~H"""
      <div class="month_breakdown">
        <h3>Throughout the Months</h3>
        <ol>
          <li>
            <a href="/2021">2018</a>
            <ol>
              <li><a href="/calendar/2021/1">January<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/2">February<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/3">March<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/4">April<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/5">May<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/6">June<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/7">July<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/8">August<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/9">September<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/10">October<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/11">November<span class="vh"> 2018</span></a></li>
              <li><a href="/calendar/2021/12">December<span class="vh"> 2018</span></a></li>
            </ol>
          </li>
          <li>
            <a href="/2021">2019</a>
            <ol>
              <li><a href="/calendar/2021/2">February<span class="vh"> 2019</span></a></li>
              <li><a href="/calendar/2021/3">March<span class="vh"> 2019</span></a></li>
              <li><a href="/calendar/2021/4">April<span class="vh"> 2019</span></a></li>
              <li><a href="/calendar/2021/5">May<span class="vh"> 2019</span></a></li>
              <li><a href="/calendar/2021/6">June<span class="vh"> 2019</span></a></li>
              <li><a href="/calendar/2021/8">August<span class="vh"> 2019</span></a></li>
              <li><a href="/calendar/2021/9">September<span class="vh"> 2019</span></a></li>
              <li><a href="/calendar/2021/10">October<span class="vh"> 2019</span></a></li>
              <li><a href="/calendar/2021/12">December<span class="vh"> 2019</span></a></li>
            </ol>
          </li>
          <li>
            <a href="/2021">2020</a>
            <ol>
              <li><a href="/calendar/2021/1">January<span class="vh"> 2020</span></a></li>
              <li><a href="/calendar/2021/2">February<span class="vh"> 2020</span></a></li>
              <li><a href="/calendar/2021/3">March<span class="vh"> 2020</span></a></li>
            </ol>
          </li>
          <li>
            <a href="/2021">2021</a>
            <ol>
              <li><a href="/calendar/2021/1">January<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/2">February<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/3">March<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/4">April<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/5">May<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/6">June<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/7">July<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/8">August<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/9">September<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/10">October<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/11">November<span class="vh"> 2021</span></a></li>
              <li><a href="/calendar/2021/12">December<span class="vh"> 2021</span></a></li>
            </ol>
          </li>
        </ol>
      </div>
    """
  end

  def publishing_frequency(assigns) do
    ~H"""
      <div class="publishing_frequency">
        <h3>Publishing Frequency</h3>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="44 40 800 320"
          width="100%"
          height="80"
          preserveAspectRatio="none"
        >
        <g style="transform: translateY(-66%) scale(1, 1.6)">
          <path
            class="wiki"
            d="M37.625,287.3054329827288C62.70833333333333,256.5516794789961,87.79166666666667,225.7979259752634,112.875,225.7979259752634C137.95833333333331,225.7979259752634,163.04166666666666,307.2602891793633,188.12499999999997,307.2602891793633C213.20833333333331,307.2602891793633,238.29166666666666,279.9549949583252,263.375,266.931285210779C288.4583333333333,253.90757546323275,313.5416666666667,229.11803069408595,338.625,229.11803069408595C363.7083333333333,229.11803069408595,388.7916666666667,262.1736093765899,413.875,263.0464204109196C438.9583333333333,263.9192314452493,464.04166666666663,263.4828259280844,489.12499999999994,264.3556369624141C514.2083333333333,265.2284479967438,539.2916666666665,331.2198077688045,564.3749999999999,331.2198077688045C589.4583333333333,331.2198077688045,614.5416666666665,185.70566486893185,639.6249999999999,178.5634464703651C664.7083333333333,171.42122807179837,689.7916666666666,167.850118872515,714.875,167.850118872515C739.9583333333333,167.850118872515,765.0416666666666,297.01759498237726,790.1249999999999,297.01759498237726C815.2083333333333,297.01759498237726,840.2916666666665,256.7484898102665,865.3749999999999,216.47938463815575L865.3749999999999,262.0794826964172C840.2916666666665,293.9370854494491,815.2083333333333,325.79468820248104,790.1249999999999,325.79468820248104C765.0416666666666,325.79468820248104,739.9583333333333,263.6168851392396,714.875,251.22068659284545C689.7916666666666,238.82448804645128,664.7083333333333,232.62638877325418,639.6249999999999,232.62638877325418C614.5416666666665,232.62638877325418,589.4583333333333,351.42281612225827,564.3749999999999,351.42281612225827C539.2916666666665,351.42281612225827,514.2083333333333,319.96453867905035,489.12499999999994,310.4605963052387C464.04166666666663,300.95665393142707,438.9583333333333,298.5535712633789,413.875,294.3991618793883C388.7916666666667,290.24475249539773,363.7083333333333,285.5341400012951,338.625,285.5341400012951C313.5416666666667,285.5341400012951,288.4583333333333,290.46152909215937,263.375,299.7130408236894C238.29166666666666,308.9645525552195,213.20833333333331,341.0432103904754,188.12499999999997,341.0432103904754C163.04166666666666,341.0432103904754,137.95833333333331,245.01688267236514,112.875,245.01688267236514C87.79166666666667,245.01688267236514,62.70833333333333,267.4190325534926,37.625,289.8211824346201Z"
          />
          <path
            class="journal"
            d="M37.625,289.8211824346201C62.70833333333333,267.4190325534926,87.79166666666667,245.01688267236514,112.875,245.01688267236514C137.95833333333331,245.01688267236514,163.04166666666666,341.0432103904754,188.12499999999997,341.0432103904754C213.20833333333331,341.0432103904754,238.29166666666666,308.9645525552195,263.375,299.7130408236894C288.4583333333333,290.46152909215937,313.5416666666667,285.5341400012951,338.625,285.5341400012951C363.7083333333333,285.5341400012951,388.7916666666667,290.24475249539773,413.875,294.3991618793883C438.9583333333333,298.5535712633789,464.04166666666663,300.95665393142707,489.12499999999994,310.4605963052387C514.2083333333333,319.96453867905035,539.2916666666665,351.42281612225827,564.3749999999999,351.42281612225827C589.4583333333333,351.42281612225827,614.5416666666665,232.62638877325418,639.6249999999999,232.62638877325418C664.7083333333333,232.62638877325418,689.7916666666666,238.82448804645128,714.875,251.22068659284545C739.9583333333333,263.6168851392396,765.0416666666666,325.79468820248104,790.1249999999999,325.79468820248104C815.2083333333333,325.79468820248104,840.2916666666665,293.9370854494491,865.3749999999999,262.0794826964172L865.3749999999999,290.18913218438655C840.2916666666665,318.6581744511975,815.2083333333333,347.12721671800847,790.1249999999999,347.12721671800847C765.0416666666666,347.12721671800847,739.9583333333333,315.65752998023413,714.875,306.0879841626657C689.7916666666666,296.5184383450972,664.7083333333333,289.7099418125977,639.6249999999999,289.7099418125977C614.5416666666665,289.7099418125977,589.4583333333333,368.75068224497915,564.3749999999999,368.75068224497915C539.2916666666665,368.75068224497915,514.2083333333333,362.1061943218716,489.12499999999994,357.2757842348218C464.04166666666663,352.445374147772,438.9583333333333,349.7527806301014,413.875,339.76822172268015C388.7916666666667,329.7836628152589,363.7083333333333,297.3684307902941,338.625,297.3684307902941C313.5416666666667,297.3684307902941,288.4583333333333,339.2576557908336,263.375,340.82072914643055C238.29166666666666,342.3838025020275,213.20833333333331,343.16533917982593,188.12499999999997,343.16533917982593C163.04166666666666,343.16533917982593,137.95833333333331,301.15061193905586,112.875,301.15061193905586C87.79166666666667,301.15061193905586,62.70833333333333,331.6219854022701,37.625,362.0933588654844Z"
          />
          <path
            class="essays"
            d="M37.625,362.0933588654844C62.70833333333333,331.6219854022701,87.79166666666667,301.15061193905586,112.875,301.15061193905586C137.95833333333331,301.15061193905586,163.04166666666666,343.16533917982593,188.12499999999997,343.16533917982593C213.20833333333331,343.16533917982593,238.29166666666666,342.3838025020275,263.375,340.82072914643055C288.4583333333333,339.2576557908336,313.5416666666667,297.3684307902941,338.625,297.3684307902941C363.7083333333333,297.3684307902941,388.7916666666667,329.7836628152589,413.875,339.76822172268015C438.9583333333333,349.7527806301014,464.04166666666663,352.445374147772,489.12499999999994,357.2757842348218C514.2083333333333,362.1061943218716,539.2916666666665,368.75068224497915,564.3749999999999,368.75068224497915C589.4583333333333,368.75068224497915,614.5416666666665,289.7099418125977,639.6249999999999,289.7099418125977C664.7083333333333,289.7099418125977,689.7916666666666,296.5184383450972,714.875,306.0879841626657C739.9583333333333,315.65752998023413,765.0416666666666,347.12721671800847,790.1249999999999,347.12721671800847C815.2083333333333,347.12721671800847,840.2916666666665,318.6581744511975,865.3749999999999,290.18913218438655L865.3749999999999,370C840.2916666666665,370,815.2083333333333,370,790.1249999999999,370C765.0416666666666,370,739.9583333333333,370,714.875,370C689.7916666666666,370,664.7083333333333,370,639.6249999999999,370C614.5416666666665,370,589.4583333333333,370,564.3749999999999,370C539.2916666666665,370,514.2083333333333,370,489.12499999999994,370C464.04166666666663,370,438.9583333333333,370,413.875,370C388.7916666666667,370,363.7083333333333,370,338.625,370C313.5416666666667,370,288.4583333333333,370,263.375,370C238.29166666666666,370,213.20833333333331,370,188.12499999999997,370C163.04166666666666,370,137.95833333333331,370,112.875,370C87.79166666666667,370,62.70833333333333,370,37.625,370Z"
          />
          </g>
        </svg>
      </div>
    """
  end

  defp event_text("bookmark", _), do: "Bookmarked a Webpage"
  defp event_text("checkin", %Entry{mapkit_response: resp}), do: "Checked-In at #{resp["name"]}"
  defp event_text("essay", _), do: "Published an Essay"
  defp event_text("note", _), do: "Posted a Note"
  defp event_text("photo", _), do: "Posted a Photo"
  defp event_text("quote", _), do: "Posted a Quote"
  defp event_text("video", _), do: "Posted a Video"
  defp event_text("wiki_new", _), do: "Created the Topic “Trip to Ireland, 2012”"

  defp event_text("wiki_update", %Publication{title_html: title}),
    do: raw("Updated the Topic “#{title}”")

  def ordinal(num) when is_integer(num) and num > 100 do
    rem(num, 100) |> ordinal()
  end

  def ordinal(num) when num in 11..13, do: "th"
  def ordinal(num) when num > 10, do: rem(num, 10) |> ordinal()
  def ordinal(1), do: "st"
  def ordinal(2), do: "nd"
  def ordinal(3), do: "rd"
  def ordinal(_), do: "th"

  defp local_time_abbr(%{item: %Entry{mapkit_response: resp, published_at: date}} = assigns) do
    date = DateTime.shift_zone!(date, resp["timezone"])

    ~H"""
      <time timestamp={DateTime.to_iso8601(date)}><%= Calendar.strftime(date, "%b %-d") %><span class="vh">,</span><%= Calendar.strftime(date, " %Y ") %><span class="vh">@</span><%= Calendar.strftime(date, " %-I:%M %p") %></time>
    """
  end

  defp local_time_abbr(%{item: %Publication{mapkit_response: resp, inserted_at: date}} = assigns) do
    date = DateTime.shift_zone!(date, resp["timezone"])

    ~H"""
      <time timestamp={DateTime.to_iso8601(date)}><%= Calendar.strftime(date, "%b %-d") %><span class="vh">,</span><%= Calendar.strftime(date, " %Y ") %><span class="vh">@</span><%= Calendar.strftime(date, " %-I:%M %p") %></time>
    """
  end
end
