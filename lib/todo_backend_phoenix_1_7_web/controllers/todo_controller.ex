defmodule TodoBackendPhoenix17Web.TodoController do
  use TodoBackendPhoenix17Web, :controller

  alias TodoBackendPhoenix17.ToDos
  alias TodoBackendPhoenix17.ToDos.Todo

  action_fallback TodoBackendPhoenix17Web.FallbackController

  def index(conn, _params) do
    todos = ToDos.list_todos()
    base_url = build_base_url(conn)
    render(conn, :index, todos: todos, base_url: base_url)
  end

  def create(conn, todo_params) do
    Map.put_new_lazy(todo_params, :order, &query_next_order/0)
    base_url = build_base_url(conn)

    with {:ok, %Todo{} = todo} <- ToDos.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/todos/#{todo}")
      |> render(:show, todo: todo, base_url: base_url)
    end
  end

  defp query_next_order() do
    max_order = ToDos.query_max_order()

    if max_order do
      max_order + 1
    else
      0
    end
  end

  def show(conn, %{"id" => id}) do
    todo = ToDos.get_todo!(id)
    base_url = build_base_url(conn)
    render(conn, :show, todo: todo, base_url: base_url)
  end

  def update(conn, %{"id" => id} = todo_params) do
    todo = ToDos.get_todo!(id)
    base_url = build_base_url(conn)

    with {:ok, %Todo{} = todo} <- ToDos.update_todo(todo, todo_params) do
      render(conn, :show, todo: todo, base_url: base_url)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = ToDos.get_todo!(id)

    with {:ok, %Todo{}} <- ToDos.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete_all(conn, _params) do
    ToDos.delete_all()

    send_resp(conn, :no_content, "")
  end

  defp build_base_url(conn) do
    case conn do
      %{scheme: :http, host: host, port: 80} -> "http://#{host}"
      %{scheme: :http, host: host, port: port} -> "http://#{host}:#{port}"
      %{scheme: :https, host: host, port: 443} -> "https://#{host}"
      %{scheme: :https, host: host, port: port} -> "https://#{host}:#{port}"
    end
  end
end
