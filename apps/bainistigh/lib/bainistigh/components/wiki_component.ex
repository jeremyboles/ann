defmodule Bainistigh.WikiComponent do
  use Bainistigh, :component

  def article_header(assigns) do
    ~H"""
    <div class="article_header">
      <h1><%= render_slot(@inner_block) %></h1>
      <p>Wiki-Style Topic</p>
    </div>
    """
  end

  def editor(assigns) do
    ~H"""
    <div class="editor">
      <div data-input={input_id(@form, :doc)} id="wiki-editor" phx-hook="WikiEditor"></div>
      <%= hidden_input(@form, :doc, value: json(input_value(@form, :doc))) %>
    </div>
    """
  end

  def public_toggle(assigns) do
    ~H"""
    <label class="public_toggle">
      <%= checkbox @form, :visibility, checked_value: :published, unchecked_value: :private %>
      <span><%= render_slot(@inner_block) %></span>
    </label>
    """
  end

  def save_button(assigns) do
    ~H"""
    <div class="save_button">
      <%= if @article != nil and @article.visibility == :published do %>
        <button type="submit">
          <%= if input_value(assigns.form, :visibility) === "private" do %>
            Unpublish
          <% else %>
            Update
          <% end %>
        </button>
        <input disabled={input_value(assigns.form, :visibility) === "private"} form="none" type="checkbox" />
        <div class="options">
          <button name={input_name(:revision, :overwrite)} type="submit">Update Over Current Revision</button>
          <%= if @article != nil do %>
            <button data-confirm="Are you sure you want to delete this article?" name="_delete" type="submit" value={@article.id}>Delete Published Article</button>
          <% end %>
        </div>
      <% else %>
        <button name={input_name(:revision, :overwrite)} type="submit">
          <%= if input_value(assigns.form, :visibility) === :published do %>
            Publish
          <% else %>
            Save
          <% end %>
        </button>
        <input disabled={input_value(assigns.form, :visibility) === :published} form="none" type="checkbox" />
        <div class="options">
          <button type="submit">Save With a New Revision</button>
          <%= if @article != nil do %>
            <button data-confirm="Are you sure you want to delete this article?" name="_delete" type="submit" value={@article.id}>Delete Unpublished Article</button>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  defp json(nil), do: ""
  defp json(map), do: Jason.encode!(map)
end
