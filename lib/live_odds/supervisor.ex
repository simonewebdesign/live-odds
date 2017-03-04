defmodule LiveOdds.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(LiveOdds.Account, [1], [id: 1]),
      worker(LiveOdds.Account, [2], [id: 2]),
      worker(LiveOdds.Account, [3], [id: 3]),
      worker(PubSub, []),
    ]

    supervise(children, strategy: :one_for_one)
  end
end
