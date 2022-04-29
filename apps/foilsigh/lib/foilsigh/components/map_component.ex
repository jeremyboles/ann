defmodule Foilsigh.MapComponent do
  use Foilsigh, :component

  import Foilsigh.GraphicsComponent

  def locations(assigns) do
    ~H"""
      <dl class="locations">
        <div>
          <dt>Belgium</dt>
          <dd>
            <a href="/map/gcyby"><b>Ath</b> <i>1 Post</i></a>
          </dd>
        </div>
      
        <div>
          <dt>United States</dt>
          <dd><a href="/map/gcyby"><b>Ath</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Boston</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>New York City</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Springfield, MO</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Washington, DC</b> <i>1 Post</i></a></dd>
        </div>
      
                <div>
          <dt>Belgium</dt>
          <dd>
            <a href="/map/gcyby"><b>Ath</b> <i>1 Post</i></a>
          </dd>
        </div>
      
        <div>
          <dt>United States</dt>
          <dd><a href="/map/gcyby"><b>Ath</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Boston</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>New York City</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Springfield, MO</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Washington, DC</b> <i>1 Post</i></a></dd>
        </div>
      
                <div>
          <dt>Belgium</dt>
          <dd>
            <a href="/map/gcyby"><b>Ath</b> <i>1 Post</i></a>
          </dd>
        </div>
      
        <div>
          <dt>United States</dt>
          <dd><a href="/map/gcyby"><b>Ath</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Boston</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>New York City</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Springfield, MO</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Washington, DC</b> <i>1 Post</i></a></dd>
        </div>
      
                <div>
          <dt>Belgium</dt>
          <dd>
            <a href="/map/gcyby"><b>Ath</b> <i>1 Post</i></a>
          </dd>
        </div>
      
        <div>
          <dt>United States</dt>
          <dd><a href="/map/gcyby"><b>Ath</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Boston</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>New York City</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Springfield, MO</b> <i>1 Post</i></a></dd>
          <dd><a href="/map/gcyby"><b>Washington, DC</b> <i>1 Post</i></a></dd>
        </div>
      </dl>
    """
  end

  def world(assigns) do
    ~H"""
      <.map height="736" width="1680"/>
    """
  end
end
