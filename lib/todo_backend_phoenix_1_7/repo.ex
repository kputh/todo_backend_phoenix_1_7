defmodule TodoBackendPhoenix17.Repo do
  use Ecto.Repo,
    otp_app: :todo_backend_phoenix_1_7,
    adapter: Ecto.Adapters.Postgres
end
