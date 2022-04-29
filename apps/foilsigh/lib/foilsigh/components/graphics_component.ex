defmodule Foilsigh.GraphicsComponent do
  use Foilsigh, :component
  
  def map(%{inner_block: _} = assigns) do
    ~H"""
      <svg class="map" role="img" viewBox={"0 0 #{@width} #{@height}"}>
        <desc><%= render_slot(@inner_block) %></desc>
        <use href={"/g/map.svg?height=#{@height}&width=#{@width}#map"}/>
        <use href={"/g/points.svg?locations[recent][]=9ytetsdz2&locations[previous][]=spz3rj21d&locations[previous][]=gcvpq24ye&height=#{@height}&width=#{@width}#points"}/>
      </svg>
    """
  end
  
  def map(assigns) do
    ~H"""
      <svg class="map" role="img" viewBox={"0 0 #{@width} #{@height}"}>
        <use href={"/g/map.svg?height=#{@height}&width=#{@width}#map"}/>
        <use href={"/g/points.svg?locations[recent][]=9ytetsdz2&locations[previous][]=spz3rj21d&locations[previous][]=gcvpq24ye&height=#{@height}&width=#{@width}#points"}/>
      </svg>
    """
  end
end