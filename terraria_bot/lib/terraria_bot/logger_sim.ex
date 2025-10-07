defmodule TerrariaBot.LoggerSim do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(_state) do
    {:ok, log} = File.read("log.log")
    logs = String.split(log, "\n") |> dbg()

    {:ok, up} = File.open("updating.log", [:write])

    schedule_work()

    {:ok, %{logs: logs, up: up}}
  end

  @impl true
  def handle_info(:work, %{logs: [log | rest], up: up}) do
    IO.write(up, log <> "\n") |> dbg()

    schedule_work()
    {:noreply, %{logs: rest, up: up}}
  end

  def handle_info(:work, %{logs: [], up: _} = state) do
    dbg("Jobs done")

    File.rm("updating.log")
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, :timer.seconds(1))
  end
end
