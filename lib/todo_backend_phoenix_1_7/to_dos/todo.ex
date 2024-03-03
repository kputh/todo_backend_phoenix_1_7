defmodule TodoBackendPhoenix17.ToDos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :title, :string
    field :order, :integer
    field :completed, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :order, :completed])
    |> validate_required([:title, :order, :completed])
  end
end
