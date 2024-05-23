defmodule ScoreRandomizer.DataTest do
  use ScoreRandomizer.DataCase

  alias ScoreRandomizer.Data

  describe "scores" do
    alias ScoreRandomizer.Data.Score

    import ScoreRandomizer.DataFixtures

    @invalid_attrs %{value: nil}

    test "list_scores/0 returns all scores" do
      score = score_fixture()
      assert Data.list_scores() == [score]
    end

    test "get_score!/1 returns the score with given id" do
      score = score_fixture()
      assert Data.get_score!(score.id) == score
    end

    test "create_score/1 with valid data creates a score" do
      valid_attrs = %{value: 42}

      assert {:ok, %Score{} = score} = Data.create_score(valid_attrs)
      assert score.value == 42
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_score(@invalid_attrs)

      assert {:error, %Ecto.Changeset{}} = Data.create_score(%{value: 1002})
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      update_attrs = %{value: 43}

      assert {:ok, %Score{} = score} = Data.update_score(score, update_attrs)
      assert score.value == 43
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_score(score, @invalid_attrs)
      assert score == Data.get_score!(score.id)

      assert {:error, %Ecto.Changeset{}} = Data.create_score(%{value: 101})

      assert score == Data.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = Data.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> Data.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = Data.change_score(score)
    end
  end
end
