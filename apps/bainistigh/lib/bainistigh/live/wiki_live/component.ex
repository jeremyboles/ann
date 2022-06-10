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
        <button type="submit">Publish Changes</button>
        <input form="none" type="checkbox" />
        <div class="options">
          <button data-confirm="Are you sure you want to delete this article?" name="_delete" type="submit">Delete Topic</button>
        </div>
      </div>
    """
  end
end
