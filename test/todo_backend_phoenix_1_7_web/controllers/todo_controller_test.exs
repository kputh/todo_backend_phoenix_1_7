defmodule TodoBackendPhoenix17Web.TodoControllerTest do
  use TodoBackendPhoenix17Web.ConnCase

  import TodoBackendPhoenix17.ToDosFixtures

  alias TodoBackendPhoenix17.ToDos.Todo

  @create_attrs %{
    title: "some title"
  }
  @update_attrs %{
    title: "some updated title",
    order: 43,
    completed: true
  }
  @invalid_attrs %{title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all todos", %{conn: conn} do
      conn = get(conn, ~p"/api/todos")
      assert json_response(conn, 200) == []
    end
  end

  describe "create todo" do
    test "renders todo when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/todos", @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, ~p"/api/todos/#{id}")
      url = "http://www.example.com/api/todos/#{id}"

      assert %{
               "id" => ^id,
               "completed" => false,
               "order" => 0,
               "title" => "some title",
               "url" => ^url
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/todos", todo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update todo" do
    setup [:create_todo]

    test "renders todo when data is valid", %{conn: conn, todo: %Todo{id: id} = todo} do
      conn = put(conn, ~p"/api/todos/#{todo}", @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, ~p"/api/todos/#{id}")
      url = "http://www.example.com/api/todos/#{id}"

      assert %{
               "id" => ^id,
               "completed" => true,
               "order" => 43,
               "title" => "some updated title",
               "url" => ^url
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, todo: todo} do
      conn = put(conn, ~p"/api/todos/#{todo}", @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete todo" do
    setup [:create_todo]

    test "deletes chosen todo", %{conn: conn, todo: todo} do
      conn = delete(conn, ~p"/api/todos/#{todo}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/todos/#{todo}")
      end
    end
  end

  defp create_todo(_) do
    todo = todo_fixture()
    %{todo: todo}
  end
end
