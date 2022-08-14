defmodule HetProjectWeb.MetricControllerTest do
  use HetProjectWeb.ConnCase

  import HetProject.MetricContextFixtures

  @create_attrs %{aantal: 42, pad: "some pad"}
  @update_attrs %{aantal: 43, pad: "some updated pad"}
  @invalid_attrs %{aantal: nil, pad: nil}

  describe "index" do
    test "lists all metrics", %{conn: conn} do
      conn = get(conn, Routes.metric_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Metrics"
    end
  end

  describe "new metric" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.metric_path(conn, :new))
      assert html_response(conn, 200) =~ "New Metric"
    end
  end

  describe "create metric" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.metric_path(conn, :create), metric: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.metric_path(conn, :show, id)

      conn = get(conn, Routes.metric_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Metric"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.metric_path(conn, :create), metric: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Metric"
    end
  end

  describe "edit metric" do
    setup [:create_metric]

    test "renders form for editing chosen metric", %{conn: conn, metric: metric} do
      conn = get(conn, Routes.metric_path(conn, :edit, metric))
      assert html_response(conn, 200) =~ "Edit Metric"
    end
  end

  describe "update metric" do
    setup [:create_metric]

    test "redirects when data is valid", %{conn: conn, metric: metric} do
      conn = put(conn, Routes.metric_path(conn, :update, metric), metric: @update_attrs)
      assert redirected_to(conn) == Routes.metric_path(conn, :show, metric)

      conn = get(conn, Routes.metric_path(conn, :show, metric))
      assert html_response(conn, 200) =~ "some updated pad"
    end

    test "renders errors when data is invalid", %{conn: conn, metric: metric} do
      conn = put(conn, Routes.metric_path(conn, :update, metric), metric: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Metric"
    end
  end

  describe "delete metric" do
    setup [:create_metric]

    test "deletes chosen metric", %{conn: conn, metric: metric} do
      conn = delete(conn, Routes.metric_path(conn, :delete, metric))
      assert redirected_to(conn) == Routes.metric_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.metric_path(conn, :show, metric))
      end
    end
  end

  defp create_metric(_) do
    metric = metric_fixture()
    %{metric: metric}
  end
end
