defmodule HetProjectWeb.Router do
  use HetProjectWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HetProjectWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HetProjectWeb.Plugs.Locale
  end

  pipeline :metric do
    plug HetProjectWeb.Plugs.MetricsPlug
  end
  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ensure_api_auth do
    plug HetProjectWeb.Plugs.ApiPlug
  end

  pipeline :auth do
    plug HetProjectWeb.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :allowed_for_users do
    plug HetProjectWeb.Plugs.AuthorizationPlug, ["Admin", "Manager", "User","Business Analyst"]
  end

  pipeline :allowed_for_managers do
    plug HetProjectWeb.Plugs.AuthorizationPlug, ["Admin", "Manager"]
  end
  pipeline :allowed_for_business_analysts do
    plug HetProjectWeb.Plugs.AuthorizationPlug, ["Admin","Business Analyst"]
  end
  pipeline :allowed_for_admins do
    plug HetProjectWeb.Plugs.AuthorizationPlug, ["Admin"]
  end

  scope "/", HetProjectWeb do
    pipe_through [:browser, :auth,:metric]

    get "/", PageController, :index
    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
    # , only: [:new, :create,:show]
    resources "/users", UserController

    # resources "/users", UserController # enkel aanzetten als je wilt debuggen
    # resources "/programs", ProgramController#een niet user zou enkel mogen kunnen zien en niet meer

    # resources "/exercises", ExerciseController #een niet user zou enkel mogen kunnen zien en niet meer
  end

  scope "/", HetProjectWeb do
    pipe_through [:browser, :auth,:metric, :ensure_auth, :allowed_for_users]

    get "/metrics", UserController, :show_metrics
    get "/user_scope", PageController, :user_index
    resources "/users", UserController
    get "/users/generate/ApiKey/:user_id", UserController, :generate_api_key
    get "/users/delete/ApiKey/:user_id", UserController, :delete_api_key
    resources "/programs", ProgramController
    resources "/exercises", ExerciseController
    get "/programs/addToUser/:program_id", ProgramController, :addToUser
    get "/programs/addExercises/:program_id", ProgramController, :addExercises
    get "/programs/addExercises/:program_id/:exercise_id", ProgramController, :addToProgram
  end

  scope "/", HetProjectWeb do
    pipe_through [:browser, :auth, :metric,:ensure_auth, :allowed_for_managers]

    get "/manager_scope", PageController, :manager_index
  end

  scope "/", HetProjectWeb do
    pipe_through [:browser, :auth,:metric, :ensure_auth, :allowed_for_admins]

    resources "/users", UserController
    get "/admin", PageController, :admin_index
  end

  scope "/business-analyst", HetProjectWeb do
    pipe_through [:browser, :auth,:metric, :ensure_auth, :allowed_for_business_analysts]

    get "/statistics", MetricController, :index
    get "/details/:pad/:type", MetricController, :details
  end

  scope "/api", HetProjectWeb.API do
    pipe_through :api

    resources "/users", UserController
  end

  scope "/api", HetProjectWeb.API do
    pipe_through [:api, :ensure_api_auth]

    resources "/programs", ProgramController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HetProjectWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HetProjectWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  scope "/", HetProjectWeb do
    pipe_through :browser
    get "/*path", WrongGetRequestController, :index
  end
end
