defmodule HetProject.UserContext.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias HetProject.ProgramContext.Program
  alias HetProject.ApiKeyContext.ApiKeys
  alias HetProject.MetricContext.Metric

  @acceptable_genders ["Male", "Female", "x"]
  @acceptable_roles ["Admin", "Manager", "User","Business Analyst"]

  schema "users" do
    field :email, :string
    field :gender, :string, default: "x"
    field :role, :string, default: "User"
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :name, :string


    has_one :api_key, ApiKeys
    has_one :metric, Metric

    many_to_many :program, Program, join_through: "user_programs"

    timestamps()
  end


  def get_acceptable_genders, do: @acceptable_genders
  def get_acceptable_roles, do: @acceptable_roles
  @doc false
  def changeset(user, attrs) do
    
    user
    |> cast(attrs, [:name, :email, :gender,:role, :password])
    |> validate_required([:name, :email, :gender,:role, :password])

    |> validate_inclusion(:gender, @acceptable_genders)
    |> validate_inclusion(:role, @acceptable_roles)
    |> put_password_hash()
  end


  def changeset_metric(user,%Metric{} = metric,attrs) do

    user
    |> cast(attrs, [:name, :email, :gender,:role, :password])
    |> validate_required([:name, :email, :gender,:role, :password])
    |> put_assoc(:metric, metric)
  end

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
  ) do
change(changeset, hashed_password: Argon2.hash_pwd_salt(password))
end

defp put_password_hash(changeset), do: changeset
end
