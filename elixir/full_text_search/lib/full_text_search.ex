defmodule FullTextSearch do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervise(FullTextSearch.Index, [])
    ]

    opts = [strategy: :one_for_one, name: FullTextSearch.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
