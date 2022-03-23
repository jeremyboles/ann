defmodule Giorraigh.Router do
  use Giorraigh, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Giorraigh do
    pipe_through :api

    get "/", PageController, :index
  end
end
