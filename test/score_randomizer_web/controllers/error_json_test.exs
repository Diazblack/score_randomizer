defmodule ScoreRandomizerWeb.ErrorJSONTest do
  use ScoreRandomizerWeb.ConnCase, async: true

  test "renders 404" do
    assert ScoreRandomizerWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ScoreRandomizerWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
