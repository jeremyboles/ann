defmodule Foilsigh.MapComponent do
  use Foilsigh, :component

  import Foilsigh.GraphicsComponent

  def locations(assigns) do
    ~H"""
      <dl class="locations">
        <%= for {country, cities} <- @locations do %>
          <div>
            <dt><%= country %></dt>
            <%= for {city, count} <- cities do %>
              <dd>
                <a href="/map/gcyby"><b><%= city %></b> <i><%= count %> <%= Inflex.inflect("Post", count) %></i></a>
              </dd>
            <% end %>
          </div>
        <% end %>
      </dl>
    """
  end

  def world(assigns) do
    ~H"""
      <.map height="736" width="1680"/>
    """
  end
end
