defmodule Foilsigh.ContactComponent do
  use Foilsigh, :component

  def appeal(assigns) do
    ~H"""
      <article class="appeal">
        <h1><%= @title %></h1>
        <p><%= render_slot(@inner_block) %></p>
        
        <dl>
          <dt>Electronic Mail</dt>
          <dd><a href="mailto:me@jeremyboles.com">me@jeremyboles.com</a></dd>
          
          <dt>Handwritten Notes</dt>
          <dd><address>PO Box 5861<br>Springfield, MO 65801<br>United States of America</address></dd>
          
          <dt>Mastodon</dt>
          <dd><a href="https://boles.social/">jeremy@boles.social</a></dd>
          
          <dt>Twitter</dt>
          <dd><a href="https://twitter.com/jeremyboles">@jeremyboles</a></dd>
        </dl>
      </article>
    """
  end

  def contact_form(assigns) do
    ~H"""
      <form class="contact_form">
        <label>First Name <input type="text"></label>
        <label>Last Name <input type="text"></label>
        
        <label>Your Email <input placeholder="you@example.com" required type="email"></label>
        <label>Your Website <input placeholder="https://example.com/" type="url"></label>
        
        <label>Message <textarea required></textarea></label>
        
        <button type="submit">Send Your Message</button>
      </form>
    """
  end
end
