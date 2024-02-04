defmodule CatInDaCar.Watcher do
  @moduledoc false

  use GenServer

  alias CatInDaCar.{Image, Telegram, Video}

  def start_link(args \\ %{}, opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  @impl true
  def init(_args) do
    Process.send_after(self(), :predict, :timer.seconds(5))
    {:ok, :ignore}
  end

  @impl true
  def handle_info(:predict, state) do
    frame = Video.frame()
    tensor = Nx.backend_transfer(Evision.Mat.to_nx(frame))
    %{predictions: predictions} = Image.predict(tensor)

    send(self(), :predict)

    if Enum.find(predictions, fn %{label: label} -> String.contains?(label, "cat") end) do
      Telegram.notify(frame)
    end

    {:noreply, state}
  end
end
