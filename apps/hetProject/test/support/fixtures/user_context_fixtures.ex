defmodule HetProject.UserContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HetProject.UserContext` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        gender: "some gender",
        hashed_password: "some hashed_password",
        name: "some name"
      })
      |> HetProject.UserContext.create_user()

    user
  end
end
