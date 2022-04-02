defmodule Bainistigh.LayoutView do
  use Bainistigh, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def tab_link(socket, view, {path_func, action}, do: block) do
    if view == socket.view do
      live_patch(block, "aria-current": "page", to: path_func.(socket, action))
    else
      live_patch(block, to: path_func.(socket, action))
    end
  end

  def tab_link(socket, view, do: block) do
    if view == socket.view do
      live_patch(block, "aria-current": "page", to: Routes.live_path(socket, view))
    else
      live_patch(block, to: Routes.live_path(socket, view))
    end
  end
end
