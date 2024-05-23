defmodule ScoreRandomizerWeb.ScoreController do
  use ScoreRandomizerWeb, :controller

  alias ScoreRandomizer.Data
  alias ScoreRandomizer.Data.Score

  action_fallback ScoreRandomizerWeb.FallbackController

  def index(conn, _params) do
    scores = Data.list_scores()
    render(conn, :index, scores: scores)
  end

  def create(conn, %{"score" => score_params}) do
    with {:ok, %Score{} = score} <- Data.create_score(score_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/scores/#{score}")
      |> render(:show, score: score)
    end
  end

  def show(conn, %{"id" => id}) do
    score = Data.get_score!(id)
    render(conn, :show, score: score)
  end

  def update(conn, %{"id" => id, "score" => score_params}) do
    score = Data.get_score!(id)

    with {:ok, %Score{} = score} <- Data.update_score(score, score_params) do
      render(conn, :show, score: score)
    end
  end

  def delete(conn, %{"id" => id}) do
    score = Data.get_score!(id)

    with {:ok, %Score{}} <- Data.delete_score(score) do
      send_resp(conn, :no_content, "")
    end
  end

  def rand_scores(conn, _params) do
    scores = Data.get_random_scores()
    render(conn, :index, scores: scores)
  end
end
