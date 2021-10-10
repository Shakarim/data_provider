defmodule DataProvider.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @doc false
  def start(_type, _args) do
    children = []

    opts = [strategy: :one_for_one, name: DataProvider.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
