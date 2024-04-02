defmodule TodoBackendPhoenix17Web.ErrorJSONTest do
  use TodoBackendPhoenix17Web.ConnCase, async: true

  test "renders 404" do
    assert TodoBackendPhoenix17Web.ErrorJSON.render("404.json", %{}) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500" do
    assert TodoBackendPhoenix17Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
