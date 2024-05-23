defmodule ScoreRandomizerWeb.ScoreJSON do
  alias ScoreRandomizer.Data.Score

  @doc """
  Renders a list of scores.
  """
  def index(%{scores: scores}) do
    %{data: for(score <- scores, do: data(score))}
  end

  @doc """
  Renders a single score.
  """
  def show(%{score: score}) do
    %{data: data(score)}
  end

  defp data(%Score{} = score) do
    %{
      value: score.value,
      id: score.id
    }
  end
end
