defmodule DataProvider.DataTest do
  use ExUnit.Case
  alias Ecto.Query
  alias DataProvider.TestSchema
  alias DataProvider.TestModules.NoFindNoRepo
  alias DataProvider.TestModules.NoFindValidRepo
  alias DataProvider.TestModules.NoFindInvalidRepo
  alias DataProvider.TestModules.QueryFindNoRepo
  alias DataProvider.TestModules.QueryFindValidRepo
  alias DataProvider.TestModules.QueryFindInvalidRepo
  alias DataProvider.TestModules.ListFindNoRepo
  alias DataProvider.TestModules.ListFindValidRepo
  alias DataProvider.TestModules.ListFindInvalidRepo
  alias DataProvider.TestModules.InvalidFindNoRepo
  alias DataProvider.TestModules.InvalidFindValidRepo
  alias DataProvider.TestModules.InvalidFindInvalidRepo
  alias DataProvider.Data
  import Query
  doctest DataProvider.Data

  @data_provider_search_params %{"filter_param_1" => :filter_value_1}
  @data_provider_options [
    sort: [asc: :filter_param_1],
    pagination: %{page: 3, page_size: 4}
  ]

  def fixture(:query, _), do: from(t in TestSchema)


  defp query(params), do: {:ok, query: fixture(:query, params)}

  setup [:query]

  describe "for `Ecto.Query` |" do
    test "test for `NoFindNoRepo`", %{query: query} do
      data_provider = NoFindNoRepo.data_provider(@data_provider_search_params, @data_provider_options)

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Data.create(data_provider, query)
      end
    end
    test "test for `NoFindValidRepo`", %{query: query} do
      data_provider = NoFindValidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, query)

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `NoFindInvalidRepo`", %{query: query} do
      data_provider = NoFindInvalidRepo.data_provider(@data_provider_search_params, @data_provider_options)

      assert_raise DataProvider.RepoCallError, fn ->
        Data.create(data_provider, query)
      end
    end

    test "test for `QueryFindNoRepo`", %{query: query} do
      data_provider = QueryFindNoRepo.data_provider(@data_provider_search_params, @data_provider_options)

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Data.create(data_provider, query)
      end
    end
    test "test for `QueryFindValidRepo`", %{query: query} do
      data_provider = QueryFindValidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, query)

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `QueryFindInvalidRepo`", %{query: query} do
      data_provider = QueryFindInvalidRepo.data_provider(@data_provider_search_params, @data_provider_options)

      assert_raise DataProvider.RepoCallError, fn ->
        Data.create(data_provider, query)
      end
    end

    test "test for `ListFindNoRepo`", %{query: query} do
      data_provider = ListFindNoRepo.data_provider(@data_provider_search_params, @data_provider_options)

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Data.create(data_provider, query)
      end
    end
    test "test for `ListFindValidRepo`", %{query: query} do
      data_provider = ListFindValidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, query)

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `ListFindInvalidRepo`", %{query: query} do
      data_provider = ListFindInvalidRepo.data_provider(@data_provider_search_params, @data_provider_options)

      assert_raise DataProvider.RepoCallError, fn ->
        Data.create(data_provider, query)
      end
    end

    test "test for `InvalidFindNoRepo`", %{query: query} do
      data_provider = InvalidFindNoRepo.data_provider(@data_provider_search_params, @data_provider_options)

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Data.create(data_provider, query)
      end
    end
    test "test for `InvalidFindValidRepo`", %{query: query} do
      data_provider = InvalidFindValidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, query)

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `InvalidFindInvalidRepo`", %{query: query} do
      data_provider = InvalidFindInvalidRepo.data_provider(@data_provider_search_params, @data_provider_options)

      assert_raise DataProvider.RepoCallError, fn ->
        Data.create(data_provider, query)
      end
    end
  end

  describe "for list |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end

    test "test for `QueryFindNoRepo`" do
      data_provider = QueryFindNoRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `QueryFindInvalidRepo`" do
      data_provider = QueryFindInvalidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end

    test "test for `InvalidFindNoRepo`" do
      data_provider = InvalidFindNoRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `InvalidFindValidRepo`" do
      data_provider = InvalidFindValidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
    test "test for `InvalidFindInvalidRepo`" do
      data_provider = InvalidFindInvalidRepo.data_provider(@data_provider_search_params, @data_provider_options)
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert match?(%Data{}, result)
      assert result
             |> Map.get(:items, [])
             |> Enum.count() > 0
    end
  end

  describe "for invalid data" do
    test "test for invalid first argument" do
      assert_raise FunctionClauseError, fn ->
        Data.create(:wrong_data, [])
      end
    end

    test "test for invalid second argument" do
      assert_raise FunctionClauseError, fn ->
        Data.create(DataProvider.create(@data_provider_search_params, @data_provider_options), :wrong_data)
      end
    end
  end
end