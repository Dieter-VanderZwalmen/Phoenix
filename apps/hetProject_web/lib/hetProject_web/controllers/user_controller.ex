defmodule HetProjectWeb.UserController do
  use HetProjectWeb, :controller

  alias HetProjectWeb.Guardian
  alias HetProject.UserContext
  alias HetProject.UserContext.User
  alias HetProject.ApiKeyContext
  alias HetProject.ApiKeyContext.ApiKeys

  def index(conn, _params) do
    users = UserContext.list_users()
    ingelogdeUser = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", users: users, ingelogdeUser: ingelogdeUser)
  end

  def new(conn, _params) do
    changeset = UserContext.change_user(%User{})
    genders = UserContext.get_acceptable_genders()
    roles = UserContext.get_acceptable_roles()
    ingelogdeUser = Guardian.Plug.current_resource(conn)

    render(conn, "new.html",
      changeset: changeset,
      acceptable_genders: genders,
      acceptable_roles: roles,
      ingelogdeUser: ingelogdeUser
    )
  end

  @spec generate_api_key(Plug.Conn.t(), nil | maybe_improper_list | map) :: Plug.Conn.t()
  def generate_api_key(conn, params) do
    require IEx
    ingelodgeUser = Guardian.Plug.current_resource(conn)

    deUser =
      UserContext.get_user(params["user_id"])
      |> UserContext.load_programs()
      |> UserContext.load_api_keys()

    if deUser.api_key !== nil do
      conn
      |> put_flash(:error, "You cant create a key because you already have one.")
      |> redirect(to: Routes.user_path(conn, :show, deUser))
    else
      if ingelodgeUser == nil do
        conn
      else
        param_id = Integer.parse(params["user_id"]) |> elem(0)
        IEx.pry()

        if ingelodgeUser.id !== param_id and ingelodgeUser.role !== "Admin" do
          conn
          |> put_flash(:error, "You can only interact with your api keys.")
          |> redirect(to: Routes.user_path(conn, :show, deUser))
        else
          case ApiKeyContext.create_api_key(params, deUser) do
            {:ok, _apikey} ->
              conn
              |> put_flash(:info, "Api key created.")
              |> redirect(to: Routes.user_path(conn, :show, deUser))

            {:error, %Ecto.Changeset{} = changeset} ->
              render(conn, "show.html", user: deUser, changeset: changeset)
              # _ ->
              #   conn
              #   |> put_flash(:info, "Api key created.")
              #   |> redirect(to: Routes.user_path(conn, :show, user: ingelodgeUser ))
          end
        end
      end
    end
  end

  def delete_api_key(conn, params) do
    require IEx
    IEx.pry()
    ingelodgeUser = Guardian.Plug.current_resource(conn)

    deUser =
      UserContext.get_user(params["user_id"])
      |> UserContext.load_programs()
      |> UserContext.load_api_keys()

    if deUser.api_key == nil do
      conn
      |> put_flash(:error, "You cant delete a key because you dont have one.")
      |> redirect(to: Routes.user_path(conn, :show, deUser))
    else
      param_id = Integer.parse(params["user_id"]) |> elem(0)

      if ingelodgeUser.id !== param_id and ingelodgeUser.role !== "Admin" do
        conn
        |> put_flash(:error, "You can only interact with your api keys.")
        |> redirect(to: Routes.user_path(conn, :show, deUser))
      else
        if ingelodgeUser == nil do
          conn
        else
          case ApiKeyContext.delete_api_key(params, deUser.api_key) do
            {:ok, _apikey} ->
              conn
              |> put_flash(:info, "Api key deleted.")
              # fix dit nog
              |> redirect(to: Routes.user_path(conn, :show, deUser))

            {:error, %Ecto.Changeset{} = changeset} ->
              # fix dit nog
              render(conn, "show.html", user: deUser, changeset: changeset)
          end
        end
      end
    end
  end

  def create(conn, %{"user" => user_params}) do
    require IEx
    IEx.pry()
    deRol = user_params["role"]
    deNaam = user_params["name"]
    users = UserContext.list_users()

    if deRol == "Admin" || deRol == "Manager" || deRol == "Business Analyst" do
      ingelogdeUser = Guardian.Plug.current_resource(conn)

      if ingelogdeUser.role != "Admin" do
        conn
        |> put_flash(:error, "You are not allowed to create users with that role")
        |> redirect(to: Routes.user_path(conn, :index, users: users))
      end
    end

    if Enum.any?(users, &(&1.name == deNaam)) do
      conn
      |> put_flash(:error, "That user name already exists")
      |> redirect(to: Routes.user_path(conn, :create))
    else
      case UserContext.create_user(user_params) do

        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: Routes.user_path(conn, :show,user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    require IEx
    IEx.pry()

    case UserContext.get_user(id) do
      nil ->
        conn
        |> put_flash(:error, "That user does not exist")
        |> redirect(to: Routes.user_path(conn, :index))

      user ->
        user = UserContext.load_api_keys(user)
        |> UserContext.load_programs()

        ingelogdeUser =
          Guardian.Plug.current_resource(conn)
          |> UserContext.load_api_keys()
          |> UserContext.load_programs()

        changeset = ApiKeyContext.change_api(%ApiKeys{})
          IEx.pry()
        if ingelogdeUser.role == "Admin" do
          IEx.pry()
          render(conn, "show.html", user: user, changeset: changeset)
        else
          IEx.pry()
          render(conn, "show.html", user: ingelogdeUser, changeset: changeset)
        end
    end
  end

  def show_metrics(conn, _params) do
    require IEx
    IEx.pry()

    user =
      Guardian.Plug.current_resource(conn)
      |> UserContext.load_metrics()

    IEx.pry()
    render(conn, "metrics.html", user: user)
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    ingelogdeUser = Guardian.Plug.current_resource(conn)
    user = UserContext.get_user!(id)

    changeset = UserContext.change_user(user)
    genders = UserContext.get_acceptable_genders()
    roles = UserContext.get_acceptable_roles()

    render(conn, "edit.html",
      user: user,
      ingelogdeUser: ingelogdeUser,
      changeset: changeset,
      acceptable_genders: genders,
      acceptable_roles: roles
    )
  end

  # dit is met rest
  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = UserContext.get_user!(id)

  #   case UserContext.update_user(user, user_params) do
  #     {:ok, user = %User{} } ->
  #       render(conn, "show.json",user: user)

  #     {:error, _cs} ->
  #       conn
  #       |> send_resp(400, "Something went wrong, sorry. Adjust your parameters or give up.")
  #   end
  # end
  # niet rest update
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = UserContext.get_user!(id)
    genders = UserContext.get_acceptable_genders()
    roles = UserContext.get_acceptable_roles()
    ingelogdeUser = Guardian.Plug.current_resource(conn)

    case UserContext.update_user(user, user_params) do
      {:ok, user = %User{}} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          user: user,
          ingelogdeUser: ingelogdeUser,
          changeset: changeset,
          acceptable_genders: genders,
          acceptable_roles: roles
        )
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   user = UserContext.get_user!(id)

  #   case UserContext.delete_user(user) do
  #     {:ok, %User{}} ->  #If delete sucessfull, send a 200 message
  #         send_resp(conn, :no_content, "")
  # {:error, _cs} ->   # If delete failed, notify the end user about the failure
  #     conn
  #     |> send_resp(400, "Something went wrong, sorry.")
  #   end

  # end

  # niet rest delete
  def delete(conn, %{"id" => id}) do
    user = UserContext.get_user!(id)
    {:ok, _user} = UserContext.delete_user(user)

    conn
    |> Guardian.Plug.sign_out()
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
