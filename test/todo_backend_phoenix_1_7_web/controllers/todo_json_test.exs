defmodule TodoBackendPhoenix17Web.ToDoJSONTest do
  alias TodoBackendPhoenix17.ToDos.Todo
  use TodoBackendPhoenix17Web.ConnCase, async: true

  test "renders single ToDo" do
    assert TodoBackendPhoenix17Web.TodoJSON.show(%{
             todo: %Todo{
               id: "4711",
               title: "the title",
               order: 0,
               completed: true
             },
             base_url: "http://localhost:4000"
           }) ==
             %{
               id: "4711",
               title: "the title",
               order: 0,
               completed: true,
               url: "http://localhost:4000/api/todos/4711"
             }
  end

  test "renders empty array" do
    assert TodoBackendPhoenix17Web.TodoJSON.index(%{
             todos: [],
             base_url: "http://localhost:4000"
           }) ==
             []
  end

  test "renders non-empty array of ToDos" do
    assert TodoBackendPhoenix17Web.TodoJSON.index(%{
             todos: [
               %Todo{
                 id: "4712",
                 title: "the title",
                 order: 1,
                 completed: false
               },
               %Todo{
                 id: "4713",
                 title: "the title",
                 order: 2,
                 completed: true
               }
             ],
             base_url: "http://localhost:4000"
           }) ==
             [
               %{
                 id: "4712",
                 title: "the title",
                 order: 1,
                 completed: false,
                 url: "http://localhost:4000/api/todos/4712"
               },
               %{
                 id: "4713",
                 title: "the title",
                 order: 2,
                 completed: true,
                 url: "http://localhost:4000/api/todos/4713"
               }
             ]
  end
end
