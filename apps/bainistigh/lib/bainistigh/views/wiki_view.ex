defmodule Bainistigh.WikiView do
  use Bainistigh, :view

  import Bainistigh.CommonComponent

  alias Taifead.Wiki.Article

  def current_page(%Article{id: id}, %Article{id: id}), do: "page"
  def current_page(_, _), do: nil

  def json(nil), do: ""
  def json(map), do: Jason.encode!(map)
end
