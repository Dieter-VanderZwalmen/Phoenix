defmodule HetProjectWeb.ErrorHandler do
  import Plug.Conn
  alias Phoenix.Controller


  @behaviour Guardian.Plug.ErrorHandler
  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> Controller.put_flash(:error, "Unauthorized acces")
    |> Controller.redirect(to: "/")
    |> halt
  end
end
