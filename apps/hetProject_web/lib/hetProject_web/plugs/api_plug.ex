
#Gekregen van Marlene Braem

defmodule HetProjectWeb.Plugs.ApiPlug do

  #import HetProject.UserContext
  import Plug.Conn

  def init(options), do: options

  def call(conn, _param) do
    #api uit header
    [api_key] = get_req_header(conn, "api_key")


    apis = HetProject.ApiKeyContext.list_apis()

    access = contains([api_key], apis)


  conn
   |> grant_access(access)
end

def contains([api], apis) do
   Enum.any?(apis, fn a -> a.api_key == api end)
end

def grant_access(conn, true), do: conn

def grant_access(conn, false) do

  conn
  |> send_resp(400, "Not allowed")
  |> halt
end
end
