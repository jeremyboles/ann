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

  def catalog(assigns) do
    ~H"""
      <aside class="catalog">
        <.search />
        <.catalog_tabs />
        <.article_list />
      </aside>
    """
  end

  def editor(assigns) do
    ~H"""
      <div class="editor">
        <div data-input={input_id(@form, :doc)} id="wiki-editor" phx-hook="WikiEditor"></div>
        <%= hidden_input @form, :doc, value: json(input_value(@form, :doc)) %>
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
        <input form="none" type="checkbox"/>
        <div class="options">
          <button>Save Over Current Revision</button>
        </div>
      </div>
    """
  end

  def sidebar(assigns) do
    ~H"""
      <aside class="sidebar">
        <.sidebar_tabs />
        
        <.metadata_panel />
        <.glossary_panel />
        <.links_panel />
        <.history_panel />
      </aside>
    """
  end

  defp article_list(assigns) do
    ~H"""
      <div class="article_list">
        <.new_article_button />
        <ul>
          <li>Article List</li>
        </ul>
      </div>
    """
  end

  defp catalog_tabs(assigns) do
    ~H"""
      <ul class="catalog_tabs">
        <li class="selected">All</li>
        <li>New</li>
        <li>Recent</li>
      </ul>
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
        Glossary
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

  defp metadata_panel(assigns) do
    ~H"""
      <section class="metadata_panel" id="metadata-panel" role="tabpanel">
        Metadata
      </section>
    """
  end

  defp new_article_button(assigns) do
    ~H"""
      <div class="new_article_button">
        <label>
          <span>New Article</span>
          <input form="none" type="checkbox"/>
        </label>
        <div class="options">
          <button accesskey="q">Quick Topic</button>
          <button accesskey="l">Long-Form Topic</button>
          <button accesskey="r">Recipe-Type Topic</button>
        </div>
      </div>
    """
  end

  defp search(assigns) do
    ~H"""
      <form class="search">
       <input placeholder="Search Wiki Articles" type="search">
      </form>
    """
  end

  defp sidebar_tabs(assigns) do
    ~H"""
      <ul class="sidebar_tabs" id="sidebar-tabs" phx-update="ignore" role="tablist">
        <li aria-controls="metadata-panel" role="tab">
          <input form="none" id="metadata-tab" name="wiki-tabs" type="radio">
          <label for="metadata-tab" title="Article Metadata">Metadata</label>
        </li>
        <li aria-controls="glossary-panel" role="tab">
          <input id="glossary-tab" form="none" name="wiki-tabs" type="radio">
          <label for="glossary-tab" title="Glossary of Terms">Glossary</label>
        </li>
        <li aria-controls="links-panel" role="tab">
          <input id="links-tab" form="none" name="wiki-tabs" type="radio">
          <label for="links-tab" title="Attached Links">Links</label>
        </li>
        <li aria-controls="history-panel" role="tab">
          <input id="history-tab" form="none" name="wiki-tabs" type="radio">
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
end
