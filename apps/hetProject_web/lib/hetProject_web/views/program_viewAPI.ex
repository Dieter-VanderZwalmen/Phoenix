defmodule HetProjectWeb.API.ProgramView do
  use HetProjectWeb, :view
  alias HetProjectWeb.API.ProgramView


  def render("index.json", %{programs: programs}) do
    %{data: render_many(programs, ProgramView, "program.json")}
  end

  def render("show.json", %{programs: programs}) do
    %{data: render_one(programs, ProgramView, "program.json")}
  end

  def render("program.json", %{program: program}) do
    %{id: program.id}
  end
end
