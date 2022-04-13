defmodule Foilsigh.Router do
  use Foilsigh, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Foilsigh.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphics do
    plug :accepts, ["svg", "svgz"]
  end

  scope "/", Foilsigh do
    pipe_through :browser

    get "/", HomeController, :index

    get "/essays", EssaysController, :index
    get "/calendar", CalendarController, :index
    get "/map", MapController, :index

    # Journal section
    get "/journal", JournalController, :index
    get "/journal/:slug", JournalController, :show

    # Wiki section
    get "/wiki", WikiController, :index
    get "/recipe", WikiController, :recipe
    get "/:slug", WikiController, :show
  end

  scope "/g", Foilsigh do
    pipe_through :graphics

    get "/map.svg", GraphicsController, :map
    get "/points.svg", GraphicsController, :points
  end
end
