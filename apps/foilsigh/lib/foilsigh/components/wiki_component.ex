defmodule Foilsigh.WikiComponent do
  use Foilsigh, :component
  
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
end