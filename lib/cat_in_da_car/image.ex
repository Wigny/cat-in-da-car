defmodule CatInDaCar.Image do
  use GenServer

  # Client

  def start_link(args \\ %{}, opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  def predict(server \\ __MODULE__, image) do
    GenServer.call(server, {:predict, image}, :infinity)
  end

  # Server

  @impl true
  def init(_args) do
    {:ok, :ignore, {:continue, :start}}
  end

  @impl true
  def handle_continue(:start, _state) do
    {:ok, resnet} = Bumblebee.load_model({:hf, "microsoft/resnet-50"})
    {:ok, featurizer} = Bumblebee.load_featurizer({:hf, "microsoft/resnet-50"})

    {:noreply, Bumblebee.Vision.image_classification(resnet, featurizer)}
  end

  @impl true
  def handle_call({:predict, image}, _from, serving) do
    {:reply, Nx.Serving.run(serving, image), serving}
  end
end
