defmodule Taifead.Geo do
  def city_name(%{"country" => "Ireland", "locality" => "Dublin" <> _}) do
    "Dublin"
  end

  def city_name(%{"country" => "United States"} = resp) do
    ~s(#{resp["locality"]}, #{resp["administrativeAreaCode"]})
  end

  def city_name(%{"locality" => city}), do: city
  def city_name(_), do: "Unknown"
end
