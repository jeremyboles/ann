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
      <button>Save</button>
      <input form="none" type="checkbox" />
      <div class="options">
        <button>Save Over Current Revision</button>
      </div>
    </div>
    """
  end

  def sidebar(assigns) do
    ~H"""
    <.sidebar_toggle />
    <aside class="sidebar">
      <.sidebar_tabs />

      <.metadata_panel form={@form} />
      <.glossary_panel />
      <.links_panel />
      <.history_panel />
    </aside>
    """
  end

  defp glossary_panel(assigns) do
    ~H"""
    <section class="glossary_panel" id="glossary-panel" role="tabpanel">
      Glossary
    </section>
    """
  end

  defp history_panel(assigns) do
    ~H"""
    <section class="history_panel" id="history-panel" role="tabpanel">
      History
    </section>
    """
  end

  defp json(nil), do: ""
  defp json(map), do: Jason.encode!(map)

  defp links_panel(assigns) do
    ~H"""
    <section class="links_panel" id="links-panel" role="tabpanel">
      Links
    </section>
    """
  end

  def location_input(assigns) do
    ~H"""
    <details class="location_input" open>
      <summary>
        <span>Location</span>
        <button class="location-off" type="button">Location Off</button>
      </summary>

      <div class="map" id="location-map" phx-update="ignore">
        <div
          data-coords-input={input_id(:revision, :coords)}
          data-mapkit-response-input={input_id(:revision, :mapkit_response)}
          id="wiki-map"
          phx-hook="LocationPicker"
          phx-update="ignore"
        >
        </div>

        <%= hidden_input(:revision, :coords) %>
        <%= hidden_input(:revision, :mapkit_response) %>
      </div>
    </details>
    """
  end

  defp metadata_panel(assigns) do
    ~H"""
    <section class="metadata_panel" id="metadata-panel" role="tabpanel">
      <.topic_attributes form={@form} />
      <.location_input form={@form} />
      <.tags_input form={@form} />
    </section>
    """
  end

  defp sidebar_tabs(assigns) do
    ~H"""
    <ul class="sidebar_tabs" id="sidebar-tabs" phx-update="ignore" role="tablist">
      <li aria-controls="metadata-panel" role="tab">
        <input form="none" id="metadata-tab" name="wiki-tabs" type="radio" />
        <label for="metadata-tab" title="Article Metadata">Metadata</label>
      </li>
      <li aria-controls="glossary-panel" role="tab">
        <input id="glossary-tab" form="none" name="wiki-tabs" type="radio" />
        <label for="glossary-tab" title="Glossary of Terms">Glossary</label>
      </li>
      <li aria-controls="links-panel" role="tab">
        <input id="links-tab" form="none" name="wiki-tabs" type="radio" />
        <label for="links-tab" title="Attached Links">Links</label>
      </li>
      <li aria-controls="history-panel" role="tab">
        <input id="history-tab" form="none" name="wiki-tabs" type="radio" />
        <label for="history-tab" title="Update History">History</label>
      </li>

      <script>
        const tabs = document.getElementById('sidebar-tabs')
        for (const tab of tabs.querySelectorAll('label')) {
          tab.addEventListener('pointerdown', (event) => {
            const radio = document.getElementById(event.currentTarget.getAttribute('for'))
            if (radio) radio.dataset.wasChecked = radio.checked
          })

          tab.addEventListener('click', (event) => {
            const radio = document.getElementById(event.currentTarget.getAttribute('for'))
            if (!radio) return

            if (radio.dataset.wasChecked === 'true') {
              window.setTimeout(() => {
                const query = window.matchMedia('(max-width: 767px)');
                if (query.matches) radio.checked = false
              }, 5)
            }
            delete radio.dataset.wasChecked
          })
        }
      </script>
    </ul>
    """
  end

  defp sidebar_toggle(assigns) do
    ~H"""
    <input checked class="sidebar_toggle" form="none" title="Toggle Sidebar" type="checkbox" />
    """
  end

  defp tags_input(assigns) do
    ~H"""
    <details class="tags_input" open>
      <summary>
        <span>Tags</span>
        <button class="add-tag" phx-click="add-tag" type="button">Add Tag</button>
      </summary>

      <ul id="wiki-tags" phx-hook="TagList">
        <%= for {tag, index} <- Enum.with_index(input_value(@form, :tags)) do %>
          <li>
            <input
              autocomplete="off"
              name={"#{input_name(@form, :tags)}[]"}
              id={input_id(@form, :tags, index)}
              phx-keydown="modify-tags"
              phx-value-index={index}
              type="text"
              value={tag}
            />
          </li>
        <% end %>
      </ul>
    </details>
    """
  end

  defp topic_attributes(assigns) do
    ~H"""
    <details class="topic_attributes" open>
      <summary>Topic Attributes</summary>

      <fieldset>
        <%= text_input(@form, :url_slug, placeholder: "custom-slug") %>
        <%= label @form, :url_slug do %>
          <abbr title="Uniform Resource Locator">URL</abbr> Slug
        <% end %>

        <%= text_input(@form, :short_title, placeholder: " ") %>
        <%= label(@form, :short_title, "Shortened Title") %>

        <.live_component
          module={Bainistigh.WikiLive.ParentTopicComponent}
          form={@form}
          id="parent-topic"
        />
      </fieldset>
    </details>
    """
  end
end
