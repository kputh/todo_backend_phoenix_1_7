defmodule TodoBackendPhoenix17Web.TodoJSON do
  alias TodoBackendPhoenix17.ToDos.Todo
  use TodoBackendPhoenix17Web, :verified_routes

  @doc """
  Renders a list of todos.
  """
  def index(%{todos: todos, base_url: base_url}) do
    for(todo <- todos, do: data(todo, base_url))
  end

  @doc """
  Renders a single todo.
  """
  def show(%{todo: todo, base_url: base_url}) do
    data(todo, base_url)
  end

  defp data(%Todo{} = todo, base_url) do
    %{
      id: todo.id,
      title: todo.title,
      order: todo.order,
      completed: todo.completed,
      url: base_url <> ~p"/api/todos/#{todo}"
    }
  end
end
