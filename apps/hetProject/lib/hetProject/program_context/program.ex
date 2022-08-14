defmodule HetProject.ProgramContext.Program do
  use Ecto.Schema
  import Ecto.Changeset

  alias HetProject.UserContext
  alias HetProject.UserContext.User

  alias HetProject.ExerciseContext.Exercise

  alias HetProject.ProgramContext

  alias HetProject.Repo


  schema "programs" do
    field :author, :string
    field :difficulty, :string
    field :duration, :integer
    field :name, :string
    field :type, :string

    many_to_many :users, User, join_through: "user_programs" # I'm new!
    many_to_many :exercises, Exercise, join_through: "program_exercises" # I'm new!

    timestamps()
  end

  @doc false
  def changeset(program, attrs) do
    program
    |> cast(attrs, [:name, :author, :duration, :difficulty, :type])
    |> validate_required([:name, :author, :duration, :difficulty, :type])
  end

  # def create_changeset(program, attrs, user) do
  #   program
  #   |> cast(attrs, [:name, :author, :duration, :difficulty, :type])
  #   |> validate_required([:name, :author, :duration, :difficulty, :type])
  #   |> put_assoc(:user, user)
  # end

  def assign_program_to_user_changeset(program, user) do
    preloaded_program = Repo.preload(program, :users)

    new_users = [user | preloaded_program.users]

    preloaded_program
    |> cast(%{}, [])
    |> put_assoc(:users, new_users)
  end
  def assign_exercise_to_program_changeset(program, exercise) do
    preloaded_program = Repo.preload(program, :exercises)

    new_exercise = [exercise | preloaded_program.exercises]

    preloaded_program
    |> cast(%{}, [])
    |> put_assoc(:exercises, new_exercise)
  end
end
