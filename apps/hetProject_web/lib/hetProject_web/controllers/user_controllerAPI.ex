defmodule HetProjectWeb.API.UserController do
  use HetProjectWeb, :controller

  alias HetProject.UserContext
  alias HetProject.UserContext.User


  def index(conn, _params) do
    users = UserContext.list_users()
    render(conn, "index.json", users: users)
  end


end
