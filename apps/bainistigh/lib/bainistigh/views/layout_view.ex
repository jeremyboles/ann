defmodule Bainistigh.LayoutView do
  use Bainistigh, :view

  import Bainistigh.Endpoint, only: [static_url: 0, url: 0]
  import Bainistigh.LayoutComponent
  import Phoenix.HTML.Tag

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def favicon_path(conn) do
    host() <> Routes.static_path(conn, "/images/favicon.png")
  end

  def javascript_path(conn) do
    host() <> Routes.static_path(conn, "/assets/app.js")
  end

  def manifest_path(conn) do
    manifest = Application.fetch_env!(:bainistigh, Bainistigh.Endpoint)[:webapp][:manifest]
    host() <> Routes.static_path(conn, manifest)
  end

  def startup_image_path(conn) do
    host() <> Routes.static_path(conn, "/images/startup.png")
  end

  def stylesheet_path(conn) do
    host() <> Routes.static_path(conn, "/assets/all.css")
  end

  defp host do
    if static_url() == url(), do: "", else: static_url()
  end
end
