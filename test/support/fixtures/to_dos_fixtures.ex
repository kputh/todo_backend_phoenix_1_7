defmodule TodoBackendPhoenix17.ToDosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoBackendPhoenix17.ToDos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        completed: true,
        order: 42,
        title: "some title"
      })
      |> TodoBackendPhoenix17.ToDos.create_todo()

    todo
  end
end
