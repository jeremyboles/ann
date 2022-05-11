defmodule Bainistigh.WikiLive.ParentTopicComponent do
  use Bainistigh, :live_component

  alias Taifead.Wiki

  def mount(socket) do
    {:ok, assign(socket, articles: Wiki.ordered_articles())}
  end

  def render(assigns) do
    articles = Enum.reject(assigns.articles, &(&1.id == input_value(assigns.form, :id)))
    assigns = assign(assigns, articles: articles)

    ~H"""
      <div>
        <%= select @form, :path, values(@articles), disabled: disabled?(@articles), prompt: [key: ""] %>
        <%= label @form, :path, "Parent Topic" %>
      </div>
    """
  end

  defp disabled?(articles) do
    Enum.count(articles) == 0
  end

  defp values(articles) do
    Enum.map(articles, fn article ->
      path = Hierarch.LTree.concat(article.path, article.id)
      {article.title_text, path}
    end)
  end
end
