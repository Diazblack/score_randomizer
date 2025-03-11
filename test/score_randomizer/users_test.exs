defmodule ScoreRandomizer.UsersTest do
  use ScoreRandomizer.DataCase

  alias ScoreRandomizer.Users
  alias ScoreRandomizer.Users.User

  import ScoreRandomizer.UsersFixtures

  @invalid_attrs %{points: 101}

  describe "Users.list_user" do
    test "returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end
  end

  describe "Users.get_user!/1" do
    test "returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end
  end

  describe "Users.get_users_by_min_number/1" do
    test "returns two random users with points greater than min_number" do
      number = 50
      [u1, u2] = Users.get_users_by_min_number(number)
      assert u1.points >= number
      assert u2.points >= number
    end
  end

  describe "Users.create_user/1" do
    test " with valid data creates a user" do
      valid_attrs = %{points: 42}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.points == 42
    end

    test "creates a user with default values" do
      assert {:ok, %User{} = user} = Users.create_user(%{})
      assert user.points == 0
    end

    test " with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end
  end

  describe "Users.create_multiple_users/0" do
    test "should create 100 users at the same time" do
      :ok = Users.create_multiple_users(100)
      assert Repo.aggregate(User, :count) == 100
    end

    test "should create 1_00_000 users at the same time" do
      :ok = Users.create_multiple_users(100_000)
      assert Repo.aggregate(User, :count) == 100_000
    end

    test "should create 1_000_000 users at the same time" do
      :ok = Users.create_multiple_users(1_000_000)
      assert Repo.aggregate(User, :count) == 1_000_000
    end
  end

  describe "Users.update_user/2" do
    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{points: 43}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.points == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end
  end

  describe "Users.delete_user/1" do
    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
