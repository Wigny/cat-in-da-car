defmodule CatInDaCar.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Nx.Serving,
       serving: CatInDaCar.Image.server(),
       name: :image_classification,
       batch_size: 10,
       batch_timeout: 100},
      {CatInDaCar.Video, %{stream: 1}},
      CatInDaCar.Watcher
    ]

    opts = [strategy: :one_for_one, name: CatInDaCar.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
