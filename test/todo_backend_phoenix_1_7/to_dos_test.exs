defmodule TodoBackendPhoenix17.ToDosTest do
  use TodoBackendPhoenix17.DataCase

  alias TodoBackendPhoenix17.ToDos

  describe "todos" do
    alias TodoBackendPhoenix17.ToDos.Todo

    import TodoBackendPhoenix17.ToDosFixtures

    @invalid_attrs %{title: nil, order: nil, completed: nil}

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert ToDos.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert ToDos.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      valid_attrs = %{title: "some title", order: 42, completed: true}

      assert {:ok, %Todo{} = todo} = ToDos.create_todo(valid_attrs)
      assert todo.title == "some title"
      assert todo.order == 42
      assert todo.completed == true
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ToDos.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      update_attrs = %{title: "some updated title", order: 43, completed: false}

      assert {:ok, %Todo{} = todo} = ToDos.update_todo(todo, update_attrs)
      assert todo.title == "some updated title"
      assert todo.order == 43
      assert todo.completed == false
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = ToDos.update_todo(todo, @invalid_attrs)
      assert todo == ToDos.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = ToDos.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> ToDos.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = ToDos.change_todo(todo)
    end
  end
end
