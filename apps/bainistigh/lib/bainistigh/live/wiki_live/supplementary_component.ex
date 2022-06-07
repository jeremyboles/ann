defmodule Bainistigh.WikiLive.SupplementaryComponent do
  use Bainistigh, :live_component

  defp placeholder(:glossary), do: "e.g. Glossary of Terms"
  defp placeholder(:links), do: "e.g. External Links"
  defp placeholder(%Phoenix.HTML.Form{} = form), do: form |> input_value(:kind) |> placeholder()
  defp placeholder(_), do: nil
end
