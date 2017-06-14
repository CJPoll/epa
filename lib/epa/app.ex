defmodule EPA.App do
  use Application

  def start(_, _) do
    import Supervisor.Spec

    children = [
      worker(EPA.Worker, [])
    ]

    IO.inspect("HI")

    opts = [strategy: :one_for_one]

    Supervisor.start_link(children, opts)
  end
end

defmodule EPA.Worker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    5
    |> :timer.seconds
    |> :timer.send_interval(:now)
  end

  def handle_info(:now, state) do
    "VAR_NAME"
    |> System.get_env
    |> IO.inspect

    {:noreply, state}
  end
end
