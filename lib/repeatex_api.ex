defmodule RepeatexApi do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(RepeatexApi.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: RepeatexApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    RepeatexApi.Endpoint.config_change(changed, removed)
    :ok
  end
end
