defmodule TerrariaBot.DiscordWebhook do
  def send_message(content) do
    url = Application.get_env(:terraria_bot, :webhook_url)

    body =
      %{"content" => content}
      |> Jason.encode!()

    headers = [{"content-type", "application/json"}]

    request = Finch.build(:post, url, headers, body)

    case Finch.request(request, MyFinch) do
      {:ok, %Finch.Response{status: 204}} ->
        :ok

      {:ok, %Finch.Response{status: status, body: body}} ->
        {:error, {status, body}}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
