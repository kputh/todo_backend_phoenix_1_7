defmodule TodoBackendPhoenix17.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TodoBackendPhoenix17Web.Telemetry,
      TodoBackendPhoenix17.Repo,
      {DNSCluster,
       query: Application.get_env(:todo_backend_phoenix_1_7, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TodoBackendPhoenix17.PubSub},
      # Start a worker by calling: TodoBackendPhoenix17.Worker.start_link(arg)
      # {TodoBackendPhoenix17.Worker, arg},
      # Start to serve requests, typically the last entry
      TodoBackendPhoenix17Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TodoBackendPhoenix17.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TodoBackendPhoenix17Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
