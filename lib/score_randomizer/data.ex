defmodule ScoreRandomizer.Data do
  @moduledoc """
  The Data context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias ScoreRandomizer.Repo

  alias ScoreRandomizer.Data.Score

  @doc """
  Returns the list of scores.

  ## Examples

      iex> list_scores()
      [%Score{}, ...]

  """
  def list_scores do
    Repo.all(Score)
  end

  @doc """
  Returns the list with 5 random scores.

  ## Examples

      iex> get_random_scores()
      [%Score{}, ...]

  """
  def get_random_scores do
    from(s in Score)
    |> where([s], s.value >= 50)
    |> order_by([fragment("RANDOM()")])
    # find another way this could be slow
    |> limit(5)
    |> Repo.all()
  end

  @doc """
  Gets a single score.

  Raises `Ecto.NoResultsError` if the Score does not exist.

  ## Examples

      iex> get_score!(123)
      %Score{}

      iex> get_score!(456)
      ** (Ecto.NoResultsError)

  """
  def get_score!(id), do: Repo.get!(Score, id)

  @doc """
  Creates a score.

  ## Examples

      iex> create_score(%{field: value})
      {:ok, %Score{}}

      iex> create_score(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_score(attrs \\ %{}) do
    %Score{}
    |> Score.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    Creates scores in Bulk

    ## Exmaples
    iex> create_scores(2)
    {:ok, [%Score{}, ...]}

    iex> create_scores_in_bulk(2)
    {:error, any()}
  """

  def create_scores_in_bulk(number \\ 10) do
    1..number
    |> Enum.chunk_every(15_000)
    |> Enum.map(&create_scores/1)
  end

  def create_scores(index_list) do
    Enum.reduce(index_list, Multi.new(), fn index, multi ->
      Multi.insert(
        multi,
        {:score, index},
        Score.changeset(%Score{}, %{value: Enum.random(0..100)})
      )
    end)
    |> Repo.transaction()
  end

  @doc """
  Updates a score.

  ## Examples

      iex> update_score(score, %{field: new_value})
      {:ok, %Score{}}

      iex> update_score(score, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_score(%Score{} = score, attrs) do
    score
    |> Score.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a score.

  ## Examples

      iex> delete_score(score)
      {:ok, %Score{}}

      iex> delete_score(score)
      {:error, %Ecto.Changeset{}}

  """
  def delete_score(%Score{} = score) do
    Repo.delete(score)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking score changes.

  ## Examples

      iex> change_score(score)
      %Ecto.Changeset{data: %Score{}}

  """
  def change_score(%Score{} = score, attrs \\ %{}) do
    Score.changeset(score, attrs)
  end
end
