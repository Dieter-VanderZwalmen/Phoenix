defmodule HetProject.ExerciseContext.Exercise do
  use Ecto.Schema
  import Ecto.Changeset
  alias HetProject.ProgramContext.Program
  schema "exercises" do
    field :difficulty, :string
    field :explanation, :string
    field :muscles, :string
    field :name, :string

    many_to_many :program, Program, join_through: "program_exercises" # I'm new!

    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
   
    exercise
    |> cast(attrs, [:name, :muscles, :difficulty, :explanation])
    |> validate_required([:name, :muscles, :difficulty, :explanation])
  end
end
