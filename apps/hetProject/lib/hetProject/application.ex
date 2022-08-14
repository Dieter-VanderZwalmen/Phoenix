defmodule HetProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      HetProject.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: HetProject.PubSub}
      # Start a worker by calling: HetProject.Worker.start_link(arg)
      # {HetProject.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: HetProject.Supervisor)
  end
end
