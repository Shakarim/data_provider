defmodule DataProvider.FakeModules do
  # FakeModules.FakeRepo
  defmodule FakeRepo do
    @moduledoc false
    @fake_result ["fake result data #1"]

    @doc false
    def all(_), do: @fake_result
  end

  # FakeModules.FakeSchema
  defmodule FakeSchema do
    use Ecto.Schema

    embedded_schema do
      field :identity, :string
    end
  end

  # FakeModules.FakeRepo.ValidListModule
  defmodule ListModule do
    use DataProvider
    alias DataProvider.FakeModules.FakeRepo
    @fake_result ["fake result data #1"]

    def find(%DataProvider{}), do: @fake_result
  end

  # FakeModules.FakeRepo.ValidQueryModule
  defmodule QueryModule do
    import Ecto.Query
    use DataProvider
    alias DataProvider.FakeModules.FakeRepo
    alias DataProvider.FakeModules.FakeSchema

    def repo(), do: FakeRepo

    def find(%DataProvider{}), do: from(t in FakeSchema)
  end

  # FakeModules.FakeRepo.ImplementAll
  defmodule ImplementAll do
    use DataProvider

    def repo(), do: :repo

    def find(_), do: :find_result
  end

  # FakeModules.FakeRepo.ImplementNothing
  defmodule ImplementNothing do
    use DataProvider
  end
end
