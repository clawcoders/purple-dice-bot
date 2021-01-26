defmodule Dice.Reply do
  @phrases [
    "Mas o que esse deus tem com cozinha francesa?\n  -Kaulo Pogos",
    "FALTOU UM!!!\n  -Bambi",
    "I'll step on your face!\n  -Luna Shiry"
  ]

  def answer(%{"message" => %{"chat" => %{"id" => chat_id}, "text" => text}}) do
    cond do
      text == "/test" ->
        Dice.Connection.send_message(chat_id, "success I guess")

      text == "/random" ->
        Dice.Connection.send_message(chat_id, Enum.random(@phrases))

      Regex.match?(~r|/r*|, text) ->
        number =
          text
          |> String.split(" ", trim: true)
          |> List.last()
          |> String.to_integer()

        Dice.Connection.send_message(chat_id, "#{Enum.random(1..number)}")

      true ->
        Dice.Connection.send_message(chat_id, "lul wat")
    end
  end

  def answer(_) do
    :ok
  end
end
