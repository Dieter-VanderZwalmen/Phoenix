defmodule HetProject.UserContext do
  @moduledoc """
  The UserContext context.
  """
  import Ecto.Query, only: [from: 2]
  import Ecto.Query, warn: false
  alias HetProject.Repo

  alias HetProject.UserContext.User
  alias HetProject.MetricContext.Metric
  alias HetProject.MetricContext


@spec authenticate_user(any, any) ::
        {:error, :invalid_credentials}
        | {:ok, atom | %{:hashed_password => <<_::64, _::_*8>>, optional(any) => any}}
@doc """
  Login
  check of de user naam bestaat of niet
  zo niet? => error
  zo wel? => verify passwoord
  => succes
  of
  => error

  """
  def authenticate_user(name, plain_text_password) do
    #case Repo.all(from u in User, where: like(u.name,^name)) do
    case Repo.get_by(User, name: name) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.hashed_password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)

  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  # UserContext
  def get_user(id), do: Repo.get(User, id)


  #de get_user by id werkt niet omdat ik werk met naam + passwoord en de repo.get gaat er vanuit dat je met ids werkt
  #def get_userByName(name) do
   #query = from u in "users", where: u.name like ^name, select: name
   #Repo.all(from u in "users", where: u.name LIKE ^name)

   #ik denk dat deze versie wel werkt
   #Repo.all(from u in User, where: like(u.name,^name))
  #end

  def load_programs(user = %User{}) do

    user = Repo.preload(user, :program)

    user
  end
  def load_metrics(user = %User{}) do

    user = Repo.preload(user, :metric)

    user
  end



  def load_api_keys(user = %User{}) do

    user |>Repo.preload([:api_key])


  end

  @spec create_user(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do

    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end



  @spec get_acceptable_genders :: [nonempty_binary, ...]
  defdelegate get_acceptable_genders(), to: User


  defdelegate get_acceptable_roles(), to: User


end
