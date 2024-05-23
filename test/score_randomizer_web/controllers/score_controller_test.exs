defmodule ScoreRandomizerWeb.ScoreControllerTest do
  use ScoreRandomizerWeb.ConnCase

  import ScoreRandomizer.DataFixtures

  alias ScoreRandomizer.Data.Score

  @create_attrs %{
    value: 42
  }
  @update_attrs %{
    value: 43
  }
  @invalid_attrs %{id: nil, value: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all scores", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/scores")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create score" do
    test "renders score when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/scores", score: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/scores/#{id}")

      assert %{
               "id" => ^id,
               "value" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/scores", score: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update score" do
    setup [:create_score]

    test "renders score when data is valid", %{conn: conn, score: %Score{id: id} = score} do
      conn = put(conn, ~p"/api/v1/scores/#{score}", score: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/scores/#{id}")

      assert %{
               "id" => ^id,
               "value" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, score: score} do
      conn = put(conn, ~p"/api/v1/scores/#{score}", score: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete score" do
    setup [:create_score]

    test "deletes chosen score", %{conn: conn, score: score} do
      conn = delete(conn, ~p"/api/v1/scores/#{score}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/scores/#{score}")
      end
    end
  end

  defp create_score(_) do
    score = score_fixture()
    %{score: score}
  end

  describe "get scores" do
    test "should return all the scores with values greated than 50", %{conn: conn} do
      _s1 = score_fixture(%{value: 1})
      _s2 = score_fixture(%{value: 20})
      s3 = score_fixture(%{value: 50})
      s4 = score_fixture(%{value: 75})
      s5 = score_fixture(%{value: 90})

      %{"data" => data} =
        conn
        |> get(~p"/api/v1/get_scores/")
        |> json_response(200)

      assert length(data) == 3

      Enum.each([s5.id, s4.id, s3.id], fn id ->
        assert Enum.any?(data, &(&1["id"] == id))
      end)
    end
  end
end
