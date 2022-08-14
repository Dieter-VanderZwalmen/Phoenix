defmodule HetProject.Repo do
  use Ecto.Repo,
    otp_app: :hetProject,
    adapter: Ecto.Adapters.MyXQL
end
