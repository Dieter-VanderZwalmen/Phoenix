defmodule HetProject.Repo.Migrations.CreateProgramExercise do
  use Ecto.Migration

  def change do
    create table(:program_exercises) do
      add :exercise_id, references(:exercises, on_delete: :delete_all), null: false
      add :program_id, references(:programs, on_delete: :delete_all), null: false

    end

    create unique_index(:program_exercises, [:exercise_id, :program_id],on_delete: :delete_all)
  end
end
