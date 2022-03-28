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

  scope "/", Foilsigh do
    pipe_through :browser

    get "/", HomeController, :index

    get "/essays", EssaysController, :index
    get "/journal", JournalController, :index
    get "/calendar", CalendarController, :index
    get "/map", MapController, :index

    get "/wiki", WikiController, :index
    get "/:slug", WikiController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Foilsigh do
  #   pipe_through :api
  # end
end
