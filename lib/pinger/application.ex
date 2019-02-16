defmodule Pinger.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: Pinger.Router, options: [port: 4001, dispatch: dispatch()])
    ]

    opts = [strategy: :one_for_one, name: Pinger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp dispatch() do
    [
      {:_,
       [
         {"/ws", Pinger.Ws, %{}}
       ]}
    ]
  end
end
