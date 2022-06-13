defmodule Bainistigh.WikiLive.Component do
  use Bainistigh, :component

  def header(assigns) do
    ~H"""
      <div class="Component__header">
        <h1><%= render_slot(@inner_block) %></h1>
        <p><%= @type %></p>
      </div>
    """
  end

  def publish_button(assigns) do
    ~H"""
      <div class="Component__publish_button">
        <button disabled={@current.status == :live} phx-click="publish" type="submit">
          Publish <span>Changes</span>
        </button>
        <input form="none" type="checkbox" />
        <div class="options">
          <button disabled={@current.status == :live} phx-click="save-over" type="button">
            Save Over Last Publication
          </button>
          <button data-confirm="Are you sure you want to delete this article?" phx-click="delete"  type="button">
            Delete Topic
          </button>
        </div>
      </div>
    """
  end
end
