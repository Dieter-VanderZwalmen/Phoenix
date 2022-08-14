defmodule HetProjectWeb.API.ProgramController do
  use HetProjectWeb, :controller

  alias HetProject.ProgramContext



  def index(conn, _params) do
    programs = ProgramContext.list_programs()
    render(conn, "index.json", programs: programs)
  end


end
