defmodule HetProject.UserContextTest do
  use HetProject.DataCase

  alias HetProject.UserContext

  describe "users" do
    alias HetProject.UserContext.User

    import HetProject.UserContextFixtures

    @invalid_attrs %{email: nil, gender: nil, hashed_password: nil, name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert UserContext.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert UserContext.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", gender: "some gender", hashed_password: "some hashed_password", name: "some name"}

      assert {:ok, %User{} = user} = UserContext.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.gender == "some gender"
      assert user.hashed_password == "some hashed_password"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserContext.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", gender: "some updated gender", hashed_password: "some updated hashed_password", name: "some updated name"}

      assert {:ok, %User{} = user} = UserContext.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.gender == "some updated gender"
      assert user.hashed_password == "some updated hashed_password"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = UserContext.update_user(user, @invalid_attrs)
      assert user == UserContext.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = UserContext.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserContext.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = UserContext.change_user(user)
    end
  end
end
