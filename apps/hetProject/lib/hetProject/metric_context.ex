defmodule HetProject.MetricContext do
  @moduledoc """
  The ApiContext context.
  """

  import Ecto.Query, warn: false
  alias HetProject.Repo

  alias HetProject.MetricContext.Metric

  # get metric for user and path

  def get_metric_for_user_and_path_and_type(user, path,type) do
    # als user null is return nil


    if user == nil do
      from(r in Metric, where: r.pad == ^path and r.type == ^type and is_nil(r.user_id))
      |> Repo.one()
    else
      Repo.get_by(Metric, pad: path, type: type, user_id: user.id)
    end
  end

  # create metric for user and path
  def create_metric(user, pad, type) do
    # |> cast(attrs,[:user_id,:pad,:type,:aantal_bezoek])

    # initialize an empty variable called parameters
    parameters = %{"user_id" => nil, "pad" => pad, "type" => type, "aantal_bezoek" => 1}

    if user != nil do
      parameters = %{"user_id" => user.id, "pad" => pad, "type" => type, "aantal_bezoek" => 1}
    end

    %Metric{}
    |> Metric.create_changeset(parameters, user)
    |> Repo.insert()
  end

  # update metric
  def update_metric(metric) do
    metric
    |> Metric.update_metric()
    |> Repo.update()
  end





  # originele query in sql
  # select pad,type, count(aantal_bezoek)
  #         from metrics
  #         group by pad,type
  def metrics_overview() do
  query  = from u in "metrics",
              group_by: [u.pad, u.type],
              select: %{pad: u.pad, type: u.type, aantal: sum(u.aantal_bezoek)}

  Repo.all(query)

  end


  #originele query in sql
  # select pad,aantal_bezoek,type,name,email
  # from metrics as m left join users u on m.user_id = u.id
  # where pad like '/'
  def details(params) do
require IEx
      query = from m in "metrics",
              left_join: u in "users",
              on: m.user_id == u.id,
              where: m.pad == ^params["pad"] and m.type == ^params["type"],
              select: %{pad: m.pad, aantal: m.aantal_bezoek, type: m.type, name: u.name, email: u.email}


    resul = Repo.all(query)
IEx.pry()
    resul
  end

end
