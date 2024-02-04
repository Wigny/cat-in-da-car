defmodule CatInDaCar.Telegram do
  def notify(frame) do
    config = Application.fetch_env!(:cat_in_da_car, :telegram)

    Telegram.Api.request(config[:token], "sendPhoto", %{
      chat_id: config[:chat_id],
      photo: {:file_content, Evision.imencode(".jpg", frame), "photo.jpg"},
      caption: "Cat on da car!"
    })
  end
end
