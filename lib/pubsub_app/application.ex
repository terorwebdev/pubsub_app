defmodule PubsubApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: PubsubApp.Worker.start_link(arg)
      # {PubsubApp.Worker, arg}
	{Phoenix.PubSub, [name: PubsubApp.PubSub, adapter: Phoenix.PubSub.PG2]},
	PubsubApp.ShoppingList
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PubsubApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
