defmodule Bainistigh.JournalLive.DateComponent do
  use Bainistigh, :live_component

  def handle_event("clear", _param, socket) do
    {:noreply, push_event(socket, "update-datetime", %{datetime: nil})}
  end

  def handle_event("next", _params, socket) do
    {:noreply, assign_next_month(socket)}
  end

  def handle_event("previous", _params, socket) do
    {:noreply, assign_prev_month(socket)}
  end

  def handle_event("set-to-now", _params, socket) do
    socket =
      socket
      |> assign(selected_date: Date.utc_today(), selected_time: Time.utc_now())
      |> update_date()

    {:noreply, socket}
  end

  def handle_event("update", %{"date" => date}, socket) do
    date = Date.from_iso8601!(date)
    {:noreply, socket |> assign(:selected_date, date) |> update_date()}
  end

  def handle_event("update", %{"time" => time}, socket) do
    time =
      case String.split(time, ":") do
        [_h, _m] -> Time.from_iso8601!(time <> ":00")
        [_h, _m, _s] -> Time.from_iso8601!(time)
        _ -> nil
      end

    {:noreply, socket |> assign(:selected_time, time) |> update_date()}
  end

  def mount(socket) do
    today = Date.utc_today()
    {:ok, assign(socket, :month, {today.year, today.month})}
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign_selected()
    {:ok, socket}
  end

  defp assign_next_month(%{assigns: %{month: {year, 12}}} = socket) do
    assign(socket, :month, {year + 1, 1})
  end

  defp assign_next_month(%{assigns: %{month: {year, month}}} = socket) do
    assign(socket, :month, {year, month + 1})
  end

  defp assign_prev_month(%{assigns: %{month: {year, 1}}} = socket) do
    assign(socket, :month, {year - 1, 12})
  end

  defp assign_prev_month(%{assigns: %{month: {year, month}}} = socket) do
    assign(socket, :month, {year, month - 1})
  end

  defp assign_selected(%{assigns: %{form: form}} = socket) do
    socket |> assign_selected(input_value(form, :published_at))
  end

  defp assign_selected(socket, nil) do
    socket |> assign(selected_date: nil, selected_time: nil)
  end

  defp assign_selected(socket, datetime) when datetime != "" do
    socket
    |> assign(
      selected_date: DateTime.to_date(datetime),
      selected_time: DateTime.to_time(datetime)
    )
  end

  defp assign_selected(socket, _), do: socket

  defp calendar(assigns) do
    ~H"""
      <tbody>
        <%= for week <- week_rows(@month) do %>
          <tr>
            <%= for day <- week do %>
              <%= render_slot(@inner_block, day) %>
            <% end %>
          </tr>
        <% end %>
      </tbody>
    """
  end

  defp display_month({year, month}) do
    Date.new!(year, month, 1) |> Calendar.strftime("%B %Y")
  end

  defp is_today?(date), do: Date.utc_today() == date

  defp first_week_start({year, month}) do
    Date.new!(year, month, 1) |> Date.beginning_of_week(:sunday)
  end

  defp last_week_end({year, month}) do
    Date.new!(year, month, 1) |> Date.end_of_month() |> Date.end_of_week(:sunday)
  end

  defp time_value(nil), do: nil

  defp time_value(time) do
    time |> Time.truncate(:second) |> Time.to_iso8601() |> String.slice(0..4)
  end

  defp update_date(%{assigns: %{selected_date: nil, selected_time: _}} = socket) do
    socket
  end

  defp update_date(%{assigns: %{selected_date: _, selected_time: nil}} = socket) do
    socket
  end

  defp update_date(%{assigns: %{selected_date: date, selected_time: time}} = socket) do
    push_event(socket, "update-datetime", %{datetime: DateTime.new!(date, time)})
  end

  defp update_date(socket), do: socket

  defp week_rows({_year, _month} = month) do
    Date.range(first_week_start(month), last_week_end(month)) |> Enum.chunk_every(7)
  end
end
