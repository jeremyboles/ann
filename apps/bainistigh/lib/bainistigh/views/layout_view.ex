defmodule Bainistigh.LayoutView do
  use Bainistigh, :view

  import Bainistigh.LayoutComponent
  import Phoenix.HTML.Tag

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def manifest, do: config(:manifest)

  defp config(key) do
    Application.fetch_env!(:bainistigh, Bainistigh.Endpoint)[:webapp][key]
  end
end
