defmodule HetProject.MetricContext.Metric do
  use Ecto.Schema
  import Ecto.Changeset
  alias HetProject.UserContext.User

  schema "metrics" do
    field :aantal_bezoek, :integer
    field :pad, :string
    field :type, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(metric, attrs) do
    metric
    |> cast(attrs, [:pad, :type, :aantal_bezoek])
    |> validate_required([:pad, :type, :aantal_bezoek])
  end

  # create changeset for metric
  def create_changeset(metric, attrs, user) do
    metric
    |> cast(attrs, [:user_id, :pad, :type, :aantal_bezoek])
    |> validate_required([:pad, :type, :aantal_bezoek])
    |> put_assoc(:user, user)
  end

  # update metric incrrement aantal bezoek by 1
  def update_metric(metric) do
    
    metric
    |> Ecto.Changeset.change(%{aantal_bezoek: metric.aantal_bezoek+1})

  end
end
