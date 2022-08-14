defmodule HetProject.MetricContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HetProject.MetricContext` context.
  """

  @doc """
  Generate a metric.
  """
  def metric_fixture(attrs \\ %{}) do
    {:ok, metric} =
      attrs
      |> Enum.into(%{
        aantal: 42,
        pad: "some pad"
      })
      |> HetProject.MetricContext.create_metric()

    metric
  end
end
