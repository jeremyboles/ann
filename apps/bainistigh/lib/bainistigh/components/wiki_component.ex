defmodule Bainistigh.WikiComponent do
  use Bainistigh, :component

  def article_header(assigns) do
    ~H"""
    <div class="article_header">
      <h1><%= render_slot(@inner_block) %></h1>
      <p>Recipe-Style Topic</p>
    </div>
    """
  end

  def breadcrumbs(assigns) do
    ~H"""
    <header class="breadcrumbs">
      <nav>
        <ol>
          <li>Test</li>
          <li><i>No Title</i></li>
        </ol>
      </nav>
    </header>
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
      <input type="checkbox" />
      <span><%= render_slot(@inner_block) %></span>
    </label>
    """
  end

  def save_button(assigns) do
    ~H"""
    <div class="save_button">
      <button type="submit">Save</button>
      <input form="none" type="checkbox" />
      <div class="options">
        <button name={input_name(:revision, :overwrite)} type="submit" value="true">Save Over Current Revision</button>
      </div>
    </div>
    """
  end

  defp json(nil), do: ""
  defp json(map), do: Jason.encode!(map)
end
