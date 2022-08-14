defmodule HetProject.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string
      add :muscles, :string
      add :difficulty, :string
      add :explanation, :string

      timestamps()
    end
  end
end
