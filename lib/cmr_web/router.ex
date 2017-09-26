defmodule CmrWeb.Router do
  use CmrWeb, :router
  use Addict.RoutesHelper

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CmrWeb do
    pipe_through :browser # Use the default browser stack
    get "/intro", PageController, :index
    resources "/users", UserController
  end

  scope "/" do
    addict :routes
  end

end
