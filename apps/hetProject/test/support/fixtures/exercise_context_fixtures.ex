defmodule HetProject.ExerciseContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HetProject.ExerciseContext` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        difficulty: "some difficulty",
        explanation: "some explanation",
        muscles: "some muscles",
        name: "some name"
      })
      |> HetProject.ExerciseContext.create_exercise()

    exercise
  end
end
