defmodule CatInDaCar.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: CatInDaCar.Finch},
      {CatInDaCar.Video, %{stream: 0}},
      CatInDaCar.Watcher
    ]

    opts = [strategy: :one_for_one, name: CatInDaCar.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
