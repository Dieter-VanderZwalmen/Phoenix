defmodule HetProjectWeb.MetricController do
  use HetProjectWeb, :controller

  alias HetProject.MetricContext
  alias HetProject.MetricContext.Metric
  alias HetProject.UserContext
  alias HetProject.UserContext.User

  def index(conn, _params) do
    metrics = MetricContext.metrics_overview()
    render(conn, "index.html", metrics: metrics)
  end

  @spec details(Plug.Conn.t(), nil | maybe_improper_list | map) :: Plug.Conn.t()
  def details(conn, params)do
    require IEx
    IEx.pry()
    metrics = MetricContext.details(params)
    render(conn, "details.html", metrics: metrics, pad: params["pad"])
  end

  # def new(conn, _params) do
  #   changeset = MetricContext.change_metric(%Metric{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"metric" => metric_params}) do
  #   case MetricContext.create_metric(metric_params) do
  #     {:ok, metric} ->
  #       conn
  #       |> put_flash(:info, "Metric created successfully.")
  #       |> redirect(to: Routes.metric_path(conn, :show, metric))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end



  # def edit(conn, %{"id" => id}) do
  #   metric = MetricContext.get_metric!(id)
  #   changeset = MetricContext.change_metric(metric)
  #   render(conn, "edit.html", metric: metric, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "metric" => metric_params}) do
  #   metric = MetricContext.get_metric!(id)

  #   case MetricContext.update_metric(metric, metric_params) do
  #     {:ok, metric} ->
  #       conn
  #       |> put_flash(:info, "Metric updated successfully.")
  #       |> redirect(to: Routes.metric_path(conn, :show, metric))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", metric: metric, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   metric = MetricContext.get_metric!(id)
  #   {:ok, _metric} = MetricContext.delete_metric(metric)

  #   conn
  #   |> put_flash(:info, "Metric deleted successfully.")
  #   |> redirect(to: Routes.metric_path(conn, :index))
  # end
end
