defmodule Dice.Reply do
  alias Dice.Lists

  def answer(%{"message" => %{"chat" => %{"id" => chat_id}, "text" => text}}) do
    cond do
      text == "/char" ->
        Dice.Connection.send_message(
          chat_id,
          "Você é um #{Enum.random(Lists.races())} #{Enum.random(Lists.classes())}, que #{
            Enum.random(Lists.lore())
          } e #{Enum.random(Lists.objective())}."
        )

      text == "/test" ->
        Dice.Connection.send_message(chat_id, "success I guess")

      text == "/quote" ->
        Dice.Connection.send_message(chat_id, Enum.random(Lists.quotes()))

      text == "/paw" ->
        Dice.Connection.send_sticker(
          chat_id,
          "CAACAgEAAxkBAANeYBCKLIhaKQwOobteRP3a5quwUsIAAh8AAxeZ2Q7IeDvomNaN1B4E"
        )

      text == "/cutie" ->
        Dice.Connection.send_sticker(
          chat_id,
          "CAACAgEAAxkBAANyYBDao0rvEg4hd3aH-JM7qRAVXQQAAgUAA5T5DDXKWqGUl7FB1R4E"
        )

      Regex.match?(~r'^(/r|/roll) [[:digit:]]+$', text) ->
        number =
          text
          |> String.split(" ", trim: true)
          |> List.last()
          |> String.to_integer()

        Dice.Connection.send_message(
          chat_id,
          "Rodando um d#{number}! Resultado: #{Enum.random(1..number)}"
        )

      Regex.match?(~r'paw', text) ->
        random_paw(chat_id)

      true ->
        Dice.Connection.send_message(chat_id, "lul wat")
    end
  end

  def answer(%{"message" => %{"chat" => %{"id" => chat_id}, "sticker" => %{"emoji" => emoji}}}) do
    cond do
      emoji == "🐾" ->
        random_paw(chat_id)
    end
  end

  def answer(_) do
    :ok
  end

  defp random_paw(chat_id) do
    random_num = Enum.random(1..5)

    if random_num == 1 do
      Dice.Connection.send_sticker(
        chat_id,
        "CAACAgEAAxkBAANeYBCKLIhaKQwOobteRP3a5quwUsIAAh8AAxeZ2Q7IeDvomNaN1B4E"
      )
    end
  end
end
