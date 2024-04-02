defmodule TodoBackendPhoenix17Web.Router do
  use TodoBackendPhoenix17Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodoBackendPhoenix17Web do
    pipe_through :api

    resources "/todos", TodoController, except: [:new, :edit]
    delete "/todos", TodoController, :delete_all
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:todo_backend_phoenix_1_7, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TodoBackendPhoenix17Web.Telemetry
    end
  end
end
