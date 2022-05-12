defmodule Bainistigh.LayoutComponent do
  use Bainistigh, :component

  def tabbar(assigns) do
    ~H"""
      <header class="tabbar" role="banner">
        <nav>
          <ul>
            <.tab id="dashboard" socket={@socket} to={Bainistigh.DashboardLive}>Dashboard</.tab>
            <.tab id="essays" socket={@socket} to={Bainistigh.EssaysLive}>Essays</.tab>
            <.tab id="journal" socket={@socket} to={Bainistigh.JournalLive}>Journal</.tab>
            <.tab action={{&Routes.wiki_path/2, :new}} id="wiki" socket={@socket} to={Bainistigh.WikiLive}>Wiki</.tab>
            
            <.more_tabs />
            <.tab id="media" socket={@socket} to={Bainistigh.MediaLive}>Media</.tab>
            <.tab id="people" socket={@socket} to={Bainistigh.PeopleLive}>People</.tab>
            <.tab id="messages" socket={@socket} to={Bainistigh.MessagesLive}>Messages</.tab>
            <.tab id="search" socket={@socket} to={Bainistigh.SearchLive}>Search</.tab>
          </ul>
        </nav>
      </header>
    """
  end

  defp more_tabs(assigns) do
    ~H"""
      <li class="more_tabs">
        <label>
          <input type="checkbox" />
          <span>More</span>
        </label>
      </li>
    """
  end

  defp tab(%{action: _action} = assigns) do
    ~H"""
      <li class="tab">
        <%= tab_link @socket, @to, @action do %>
          <span aria-labelledby={"#{@id}-media-name"} role="img"/>
          <span id={"#{@id}-media-name"}><%= render_slot(@inner_block) %></span>
        <% end %>
      </li>
    """
  end

  defp tab(assigns) do
    ~H"""
      <li class="tab">
        <%= tab_link @socket, @to do %>
          <span aria-labelledby={"#{@id}-media-name"} role="img"/>
          <span id={"#{@id}-media-name"}><%= render_slot(@inner_block) %></span>
        <% end %>
      </li>
    """
  end

  defp tab_link(socket, view, {path_func, action}, do: block) do
    if view == socket.view do
      live_patch(block, "aria-current": "page", to: path_func.(socket, action))
    else
      live_patch(block, to: path_func.(socket, action))
    end
  end

  defp tab_link(socket, view, do: block) do
    if view == socket.view do
      live_patch(block, "aria-current": "page", to: Routes.live_path(socket, view))
    else
      live_patch(block, to: Routes.live_path(socket, view))
    end
  end
end
