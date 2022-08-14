defmodule HetProjectWeb.Plugs.MetricsPlug do
  import Guardian.Plug
  alias HetProject.MetricContext
  import Plug.Conn # Let this module know it is a plug

  def init(default), do: default

  def call(conn, _options) do
    # 1. get user
    # 2. Get url path
    # 3. get or create metric
    # 4. increment metric

 

    user = Guardian.Plug.current_resource(conn)
    path = conn.request_path
    type = conn.method




    case MetricContext.get_metric_for_user_and_path_and_type(user, path,type) do
      nil ->
        metric = MetricContext.create_metric(user, path, type)
        # MetricContext.update_metric(metric)
     #metric = MetricContext.create_metric(user, path)

      metric -> MetricContext.update_metric(metric)
    end
   conn

  end
end
