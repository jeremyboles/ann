defmodule Bainistigh.WikiView do
  use Bainistigh, :view

  import Bainistigh.CommonComponent
  import Bainistigh.WikiComponent

  alias Taifead.Wiki.Article

  def current_page(%Article{id: id}, %Article{id: id}), do: "page"
  def current_page(_, _), do: nil
end
