defmodule HetProject.ProgramContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HetProject.ProgramContext` context.
  """

  @doc """
  Generate a program.
  """
  def program_fixture(attrs \\ %{}) do
    {:ok, program} =
      attrs
      |> Enum.into(%{
        author: "some author",
        difficulty: "some difficulty",
        duration: 42,
        name: "some name",
        type: "some type"
      })
      |> HetProject.ProgramContext.create_program()

    program
  end
end
