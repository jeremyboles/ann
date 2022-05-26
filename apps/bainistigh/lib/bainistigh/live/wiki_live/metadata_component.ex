defmodule Bainistigh.WikiLive.MetadataComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
    <section class="MetadataComponent" role="tabpanel">
      <.topic_attributes form={@form} />
      <.location_input form={@form} />
      
      <.live_component form={@form} id="wiki-tags" module={Bainistigh.WikiLive.TagsComponent} />
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
