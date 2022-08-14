defmodule HetProject.ExerciseContextTest do
  use HetProject.DataCase

  alias HetProject.ExerciseContext

  describe "exercises" do
    alias HetProject.ExerciseContext.Exercise

    import HetProject.ExerciseContextFixtures

    @invalid_attrs %{difficulty: nil, explanation: nil, muscles: nil, name: nil}

    test "list_exercises/0 returns all exercises" do
      exercise = exercise_fixture()
      assert ExerciseContext.list_exercises() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert ExerciseContext.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{difficulty: "some difficulty", explanation: "some explanation", muscles: "some muscles", name: "some name"}

      assert {:ok, %Exercise{} = exercise} = ExerciseContext.create_exercise(valid_attrs)
      assert exercise.difficulty == "some difficulty"
      assert exercise.explanation == "some explanation"
      assert exercise.muscles == "some muscles"
      assert exercise.name == "some name"
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ExerciseContext.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()
      update_attrs = %{difficulty: "some updated difficulty", explanation: "some updated explanation", muscles: "some updated muscles", name: "some updated name"}

      assert {:ok, %Exercise{} = exercise} = ExerciseContext.update_exercise(exercise, update_attrs)
      assert exercise.difficulty == "some updated difficulty"
      assert exercise.explanation == "some updated explanation"
      assert exercise.muscles == "some updated muscles"
      assert exercise.name == "some updated name"
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = ExerciseContext.update_exercise(exercise, @invalid_attrs)
      assert exercise == ExerciseContext.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = ExerciseContext.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> ExerciseContext.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = ExerciseContext.change_exercise(exercise)
    end
  end
end
