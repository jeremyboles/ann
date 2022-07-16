defmodule Foilsigh.GraphicsComponent do
  use Foilsigh, :component

  def map(%{inner_block: _} = assigns) do
    [recent | previous] = assigns.locations

    previous_params =
      Enum.map_join(previous, "&", fn coords -> "locations[previous][]=#{geohash(coords)}" end)

    ~H"""
      <svg class="map" role="img" viewBox={"0 0 #{@width} #{@height}"}>
        <desc><%= render_slot(@inner_block) %></desc>
        <use href={"/g/map.svg?height=#{@height}&width=#{@width}#map"}/>
        <use href={"/g/points.svg?locations[recent][]=#{geohash(recent)}&#{previous_params}&height=#{@height}&width=#{@width}#points"}/>
      </svg>
    """
  end

  def map(assigns) do
    location_params =
      Enum.map_join(assigns.locations, "&", fn coords -> "locations[]=#{geohash(coords)}" end)

    ~H"""
      <svg class="map" role="img" viewBox={"0 0 #{@width} #{@height}"}>
        <use href={"/g/map.svg?height=#{@height}&width=#{@width}#map"}/>
        <use href={"/g/points.svg?#{location_params}&height=#{@height}&width=#{@width}#points"}/>
      </svg>
    """
  end

  def geohash(coords), do: Foilsigh.Geo.to_geohash_string(coords, 5)
end
