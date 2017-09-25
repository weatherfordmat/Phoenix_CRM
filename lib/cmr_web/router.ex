defmodule CmrWeb.Router do
  use CmrWeb, :router

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
    resources "/", UserController
    
  end

  # Other scopes may use custom stacks.
  # scope "/api", CmrWeb do
  #   pipe_through :api
  # end
end
