defmodule Dice.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Dice.Repo,
      # Start the Telemetry supervisor
      DiceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dice.PubSub},
      # Start the Endpoint (http/https)
      DiceWeb.Endpoint,
      # Start a worker by calling: Dice.Worker.start_link(arg)
      # {Dice.Worker, arg}
      Dice.Verification
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dice.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
