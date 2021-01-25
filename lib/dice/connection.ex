defmodule Dice.Connection do
  use Tesla

  require Logger

  plug Tesla.Middleware.BaseUrl,
       "https://api.telegram.org/bot#{Application.get_env(:dice, :bot_token)}"

  plug Tesla.Middleware.JSON

  def set_webhook do
    get("/setWebhook?url=189.32.180.174:8443")
  end

  @doc """
  [
    %{
      "message" => %{
        "chat" => %{
          "first_name" => "Shiryel",
          "id" => 890042772,
          "type" => "private",
          "username" => "shiryel"
        },
        "date" => 1611546181,
        "entities" => [%{"length" => 6, "offset" => 0, "type" => "bot_command"}],
        "from" => %{
          "first_name" => "Shiryel",
          "id" => 890042772,
          "is_bot" => false,
          "language_code" => "en",
          "username" => "shiryel"
        },
        "message_id" => 3,
        "text" => "/start"
      },
      "update_id" => 779238891
    }
  ]
  """
  def get_updates(offset) do
    case get("/getUpdates?offset=#{offset}") do
      {:ok, result} ->
        Logger.debug(inspect(result))
        result.body["result"]

      error ->
        error
    end
  end

  def send_message(chat_id, message) do
    get("/sendMessage?chat_id=#{chat_id}&text=#{message}")
  end
end
