defmodule TodoBackendPhoenix17Web.TodoController do
  use TodoBackendPhoenix17Web, :controller

  alias TodoBackendPhoenix17.ToDos
  alias TodoBackendPhoenix17.ToDos.Todo

  action_fallback TodoBackendPhoenix17Web.FallbackController

  def index(conn, _params) do
    todos = ToDos.list_todos()
    render(conn, :index, todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- ToDos.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/todos/#{todo}")
      |> render(:show, todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = ToDos.get_todo!(id)
    render(conn, :show, todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = ToDos.get_todo!(id)

    with {:ok, %Todo{} = todo} <- ToDos.update_todo(todo, todo_params) do
      render(conn, :show, todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = ToDos.get_todo!(id)

    with {:ok, %Todo{}} <- ToDos.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
