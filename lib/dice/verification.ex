defmodule Dice.Verification do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, 0)
  end

  def init(state) do
    schedule_work()

    {:ok, state}
  end

  def handle_info(:work, state) do
    update = Dice.Connection.get_updates(state + 1)
    Task.start(fn -> Enum.each(update, &Dice.Reply.answer/1) end)

    schedule_work()

    {:noreply, Map.get(List.last(update) || %{}, "update_id", state)}
  end

  def schedule_work do
    Process.send_after(self(), :work, 1000)
  end
end
