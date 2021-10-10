defmodule DataProvider.DataTest do
  use ExUnit.Case
  alias DataProvider.Data
  alias DataProvider.FakeModules.FakeSchema
  alias DataProvider.FakeModules.QueryModule
  import Ecto.Query
  doctest DataProvider.Data

  @data_provider_search_params %{"filter_param_1" => :filter_value_1}
  @data_provider_options [
    sort: [asc: :filter_param_1],
    pagination: %{page: 3, page_size: 4}
  ]

  describe "`create/2` |" do
    test "test `ListModule`" do
      data_provider = QueryModule.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, from(t in FakeSchema))

      assert match?(%Data{}, result)
    end

    test "test `QueryModule`" do
      data_provider = DataProvider.create(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, [])

      assert match?(%Data{}, result)
    end
  end
end