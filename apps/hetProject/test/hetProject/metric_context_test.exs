defmodule HetProject.MetricContextTest do
  use HetProject.DataCase

  alias HetProject.MetricContext

  describe "metrics" do
    alias HetProject.MetricContext.Metric

    import HetProject.MetricContextFixtures

    @invalid_attrs %{aantal: nil, pad: nil}

    test "list_metrics/0 returns all metrics" do
      metric = metric_fixture()
      assert MetricContext.list_metrics() == [metric]
    end

    test "get_metric!/1 returns the metric with given id" do
      metric = metric_fixture()
      assert MetricContext.get_metric!(metric.id) == metric
    end

    test "create_metric/1 with valid data creates a metric" do
      valid_attrs = %{aantal: 42, pad: "some pad"}

      assert {:ok, %Metric{} = metric} = MetricContext.create_metric(valid_attrs)
      assert metric.aantal == 42
      assert metric.pad == "some pad"
    end

    test "create_metric/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MetricContext.create_metric(@invalid_attrs)
    end

    test "update_metric/2 with valid data updates the metric" do
      metric = metric_fixture()
      update_attrs = %{aantal: 43, pad: "some updated pad"}

      assert {:ok, %Metric{} = metric} = MetricContext.update_metric(metric, update_attrs)
      assert metric.aantal == 43
      assert metric.pad == "some updated pad"
    end

    test "update_metric/2 with invalid data returns error changeset" do
      metric = metric_fixture()
      assert {:error, %Ecto.Changeset{}} = MetricContext.update_metric(metric, @invalid_attrs)
      assert metric == MetricContext.get_metric!(metric.id)
    end

    test "delete_metric/1 deletes the metric" do
      metric = metric_fixture()
      assert {:ok, %Metric{}} = MetricContext.delete_metric(metric)
      assert_raise Ecto.NoResultsError, fn -> MetricContext.get_metric!(metric.id) end
    end

    test "change_metric/1 returns a metric changeset" do
      metric = metric_fixture()
      assert %Ecto.Changeset{} = MetricContext.change_metric(metric)
    end
  end
end
