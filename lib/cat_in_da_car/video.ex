defmodule CatInDaCar.Video do
  use GenServer

  require Logger
  alias Evision.VideoCapture

  @fps 60

  # Client

  def start_link(args \\ %{}, opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def frame(server \\ __MODULE__) do
    GenServer.call(server, :frame, :infinity)
  end

  # Server

  @impl true
  def init(_args) do
    Process.flag(:trap_exit, true)

    {:ok, :ignore, {:continue, :start}}
  end

  @impl true
  def handle_continue(:start, _state) do
    video = VideoCapture.videoCapture(0)

    send(self(), :grab)

    {:noreply, video}
  end

  @impl true
  def terminate(_reason, video) do
    VideoCapture.release(video)
  end

  @impl true
  def handle_call(:frame, _from, video) do
    {:reply, VideoCapture.retrieve(video), video}
  end

  @impl true
  def handle_info(:grab, %{isOpened: false} = video) do
    # waits before exiting the process to start a new one
    Process.sleep(:timer.minutes(1))

    {:stop, "Video stream isn't opened", video}
  end

  def handle_info(:grab, video) do
    Process.send_after(self(), :grab, floor(:timer.seconds(1) / @fps))

    VideoCapture.grab(video)

    {:noreply, video}
  end
end
