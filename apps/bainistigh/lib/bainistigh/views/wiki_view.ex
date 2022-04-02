defmodule Bainistigh.WikiView do
  use Bainistigh, :view

  alias Taifead.Wiki.Article

  def current_page(%Article{id: id}, %Article{id: id}), do: "page"
  def current_page(_, _), do: nil
end
