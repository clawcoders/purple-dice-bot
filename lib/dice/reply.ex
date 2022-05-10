defmodule Dice.Reply do
  @moduledoc """
  This module checks what message was sent and sends a reply back
  """

  #  alias Dice.Lists
  #  I'll be translating these lists to english in the future

  def answer(%{"message" => %{"chat" => %{"id" => chat_id}, "text" => text}}) do
    cond do
      #      text == "/char" ->
      #        Dice.Connection.send_message(
      #          chat_id,
      #          "Você é um #{Enum.random(Lists.races())} #{Enum.random(Lists.classes())}, que #{
      #            Enum.random(Lists.lore())
      #          } e #{Enum.random(Lists.objective())}."
      #        )

      text == "/beep" ->
        Dice.Connection.send_message(chat_id, "boop")

      #      text == "/quote" ->
      #        Dice.Connection.send_message(chat_id, Enum.random(Lists.quotes()))

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

      Regex.match?(~r'^(/r|/roll) ([1-9][0-9]*d[1-9][0-9]*|[0-9]*|\+|\-|/|\*| )+$', text) ->
        {result, _} =
          text
          |> String.split(~r'(/r |/roll |\+|\-|/|\*)', include_captures: true, trim: true)
          |> Enum.map(&String.trim/1)
          |> List.delete_at(0)
          |> Enum.map(&multiply_dice/1)
          |> Enum.reduce(fn x, acc -> acc <> x end)
          |> String.replace(~r'(\+|\-|/|\*)+$', "")
          |> Code.eval_string()

        text =
          text
          |> String.replace(~r'(/r|/roll) ', "")

        Dice.Connection.send_message(
          chat_id,
          "Calculando #{text}! Resultado: #{result}"
        )

      Regex.match?(~r'paw', text) ->
        random_paw(chat_id)

      true ->
        :ok
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

  defp multiply_dice(text) do
    cond do
      Regex.match?(~r'^[0-9]+d[0-9]+$', text) ->
        [ammount, dice] =
          text
          |> String.split("d")
          |> Enum.map(&String.to_integer/1)

        Enum.map(1..ammount, fn _ -> Enum.random(1..dice) end)
        |> Enum.reduce(fn x, acc -> x + acc end)
        |> Integer.to_string()

      Regex.match?(~r'^[0-9]+$', text) ->
        text

      Regex.match?(~r'(\+|\-|\/|\*)', text) ->
        text

      true ->
        0
    end
  end

  defp random_paw(chat_id) do
    random_num = Enum.random(1..10)

    if random_num == 1 do
      Dice.Connection.send_sticker(
        chat_id,
        "CAACAgEAAxkBAANeYBCKLIhaKQwOobteRP3a5quwUsIAAh8AAxeZ2Q7IeDvomNaN1B4E"
      )
    end
  end
end
