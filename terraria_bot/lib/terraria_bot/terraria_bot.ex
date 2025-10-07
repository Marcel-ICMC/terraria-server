defmodule TerrariaBot.TerrariaBot do
  alias TerrariaBot.DiscordWebhook
  use GenServer

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_state) do
    port =
      Port.open({:spawn, "tail -F #{Application.get_env(:terraria_bot, :log_file)}"}, [:binary]) |> dbg() 
    {:ok, %{port: port}}
  end

  @impl true
  def handle_info({port, {:data, data}} = incoming_event, %{port: port} = state) do
    dbg(incoming_event)
    for line <- String.split(data, ["\n", "\r\n"], trim: true) do
      process_line(line) |> dbg()
    end

    {:noreply, state}
  end

  defp process_line(line) do
    if should_send_message(line) do
      [timestamp_str | [player_name | [_has | [action]]]] = String.split(line)

      {:ok, dt, _offset} = DateTime.from_iso8601(timestamp_str)
      log_datetime = DateTime.truncate(dt, :second)
      now = DateTime.utc_now() |> DateTime.truncate(:second)
      if DateTime.before?(log_datetime, now) do
        :ok
      else 
      player_action =
        if action == "joined." do
          "entrou no"
        else
          "saiu do"
        end

      [player_name, player_action, "servidor"]
      |> Enum.join(" ")
      |> DiscordWebhook.send_message()
end
    end
  end

  defp should_send_message(line) do
    String.ends_with?(line, "has joined.") or String.ends_with?(line, "has left.")
  end
end
