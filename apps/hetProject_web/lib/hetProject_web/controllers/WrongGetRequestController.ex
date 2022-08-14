#implementatie van Mattias Waem
defmodule HetProjectWeb.WrongGetRequestController do
  use HetProjectWeb, :controller

  def index(conn, _params) do
    path = conn.path_info
    conn
    |> put_flash(:error, "The page localhost:4000/#{path} you were looking for doens't exist")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
