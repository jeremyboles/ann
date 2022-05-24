defmodule Bainistigh.WikiLive.MetadataComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
    <section class="MetadataComponent" role="tabpanel">
      <.topic_attributes form={@form} />
      <.location_input form={@form} />
      <.tags_input form={@form} />
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
