defmodule Foilsigh.ContactView do
  use Foilsigh, :view

  import Foilsigh.ContactComponent

  def stylesheets(_action, _assigns), do: ~w(/assets/templates/contact/index.css)

  def title(_action, _assigns), do: "Contact · Jeremy Boles"
end
