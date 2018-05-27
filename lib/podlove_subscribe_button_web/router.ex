defmodule PodloveSubscribeButtonWeb.Router do
  use PodloveSubscribeButtonWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", PodloveSubscribeButtonWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/feed", PageController, :feed)
    get("/feed/mp3", PageController, :feed)
    get("/feed/m4a", PageController, :feed)
  end

  # Other scopes may use custom stacks.
  # scope "/api", PodloveSubscribeButtonWeb do
  #   pipe_through :api
  # end
end
