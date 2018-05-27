defmodule PodloveSubscribeButton.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(PodloveSubscribeButtonWeb.Endpoint, []),
      # Start your own worker by calling: PodloveSubscribeButton.Worker.start_link(arg1, arg2, arg3)
      # worker(PodloveSubscribeButton.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PodloveSubscribeButton.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PodloveSubscribeButtonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
