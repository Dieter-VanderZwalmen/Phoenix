 defmodule HetProjectWeb.API.UserView do
   use HetProjectWeb, :view
   alias HetProjectWeb.API.UserView

   def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{users: users}) do
    %{data: render_one(users, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id}
  end
 end
