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

  def fixture(:query, _), do: from(t in TestSchema)


  defp query(params), do: {:ok, query: fixture(:query, params)}

  setup [:query]

  describe "for `Ecto.Query` |" do
    test "test for `NoFindNoRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: NoFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Data.create(data_provider, query)
      end
    end
    test "test for `NoFindValidRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: NoFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, query)

      assert result === %Data{items: Enum.to_list(1..100), total_count: 1000}
    end
    test "test for `NoFindInvalidRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: NoFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoCallError, fn ->
        Data.create(data_provider, query)
      end
    end

    test "test for `QueryFindNoRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: QueryFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Data.create(data_provider, query)
      end
    end
    test "test for `QueryFindValidRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: QueryFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, query)

      assert result === %Data{items: Enum.to_list(1..100), total_count: 1000}
    end
    test "test for `QueryFindInvalidRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: QueryFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoCallError, fn ->
        Data.create(data_provider, query)
      end
    end

    test "test for `ListFindNoRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: ListFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Data.create(data_provider, query)
      end
    end
    test "test for `ListFindValidRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: ListFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, query)

      assert result === %Data{items: Enum.to_list(1..100), total_count: 1000}
    end
    test "test for `ListFindInvalidRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: ListFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoCallError, fn ->
        Data.create(data_provider, query)
      end
    end

    test "test for `InvalidFindNoRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: InvalidFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Data.create(data_provider, query)
      end
    end
    test "test for `InvalidFindValidRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: InvalidFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, query)

      assert result === %Data{items: Enum.to_list(1..100), total_count: 1000}
    end
    test "test for `InvalidFindInvalidRepo`", %{query: query} do
      data_provider = %DataProvider{
        module: InvalidFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoCallError, fn ->
        Data.create(data_provider, query)
      end
    end
  end

  describe "for list |" do
    test "test for `NoFindNoRepo`" do
      data_provider = %DataProvider{
        module: NoFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
    test "test for `NoFindValidRepo`" do
      data_provider = %DataProvider{
        module: NoFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = %DataProvider{
        module: NoFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end

    test "test for `QueryFindNoRepo`" do
      data_provider = %DataProvider{
        module: QueryFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = %DataProvider{
        module: QueryFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
    test "test for `QueryFindInvalidRepo`" do
      data_provider = %DataProvider{
        module: QueryFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end

    test "test for `ListFindNoRepo`" do
      data_provider = %DataProvider{
        module: ListFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
    test "test for `ListFindValidRepo`" do
      data_provider = %DataProvider{
        module: ListFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = %DataProvider{
        module: ListFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end

    test "test for `InvalidFindNoRepo`" do
      data_provider = %DataProvider{
        module: InvalidFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
    test "test for `InvalidFindValidRepo`" do
      data_provider = %DataProvider{
        module: InvalidFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
    test "test for `InvalidFindInvalidRepo`" do
      data_provider = %DataProvider{
        module: InvalidFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Data.create(data_provider, Enum.to_list(1..10))

      assert result === %Data{items: Enum.to_list(1..10), total_count: 10}
    end
  end

  describe "for invalid data" do
    test "test for invalid first argument" do
      assert_raise FunctionClauseError, fn ->
        Data.create(:wrong_data, [])
      end
    end

    test "test for invalid second argument" do
      data_provider = %DataProvider{
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      assert_raise FunctionClauseError, fn ->
        Data.create(data_provider, :wrong_data)
      end
    end
  end
end