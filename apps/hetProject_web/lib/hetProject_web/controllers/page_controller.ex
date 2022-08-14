defmodule HetProjectWeb.PageController do
  use HetProjectWeb, :controller

  def index(conn, _params) do
    ingelogdeUser = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", role: "everyone", ingelogdeUser: ingelogdeUser)
  end

  def user_index(conn, _params) do
    render(conn, "index.html", role: "users")
  end

  def manager_index(conn, _params) do
    render(conn, "index.html", role: "managers")
  end

  def admin_index(conn, _params) do
    render(conn, "index.html", role: "admins")
  end
end
