defmodule Bainistigh.WikiLive.SidebarComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
      <aside class="SidebarComponent">
        <.toggle />
        
        <.tabs />
        <.live_component form={@form} id="metadata-panel" module={Bainistigh.WikiLive.MetadataComponent} />
        <.live_component form={@form} id="glossary-panel" module={Bainistigh.WikiLive.GlossaryComponent} />
        <.live_component form={@form} id="links-panel" module={Bainistigh.WikiLive.LinksComponent} />
        <.live_component article={@article} form={@form} id="history-panel" module={Bainistigh.WikiLive.HistoryComponent} />
      </aside>
    """
  end

  defp tabs(assigns) do
    ~H"""
    <ul class="tabs" id="sidebar-tabs" phx-update="ignore" role="tablist">
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

  @doc """
  Toggles the visibility of the sidebar
  """
  defp toggle(assigns) do
    ~H"""
      <input checked class="toggle" form="none" title="Toggle Sidebar" type="checkbox" />
    """
  end
end
