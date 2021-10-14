defmodule DataProvider.LoaderTest do
  use ExUnit.Case
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
  alias DataProvider.Loader
  doctest DataProvider.Loader

  describe "`load/1` |" do
    test "test `NoFindNoRepo` loading" do
      data_provider = %DataProvider{
        module: NoFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Loader.load(data_provider)

      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test `NoFindValidRepo` loading" do
      data_provider = %DataProvider{
        module: NoFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Loader.load(data_provider)

      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test `NoFindInvalidRepo` loading" do
      data_provider = %DataProvider{
        module: NoFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Loader.load(data_provider)

      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end

    test "test `QueryFindNoRepo` loading" do
      data_provider = %DataProvider{
        module: QueryFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Loader.load(data_provider)
      end
    end
    test "test `QueryFindValidRepo` loading" do
      data_provider = %DataProvider{
        module: QueryFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Loader.load(data_provider)

      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test `QueryFindInvalidRepo` loading" do
      data_provider = %DataProvider{
        module: QueryFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.RepoCallError, fn ->
        Loader.load(data_provider)
      end
    end

    test "test `ListFindNoRepo` loading" do
      data_provider = %DataProvider{
        module: ListFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Loader.load(data_provider)

      assert result === %DataProvider{
        module: ListFindNoRepo,
        data: %DataProvider.Data{items: Enum.to_list(1..15), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
    end
    test "test `ListFindValidRepo` loading" do
      data_provider = %DataProvider{
        module: ListFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Loader.load(data_provider)

      assert result === %DataProvider{
        module: ListFindValidRepo,
        data: %DataProvider.Data{items: Enum.to_list(1..15), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
    end
    test "test `ListFindInvalidRepo` loading" do
      data_provider = %DataProvider{
        module: ListFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = Loader.load(data_provider)

      assert result === %DataProvider{
        module: ListFindInvalidRepo,
        data: %DataProvider.Data{items: Enum.to_list(1..15), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
    end

    test "test `InvalidFindNoRepo` loading" do
      data_provider = %DataProvider{
        module: InvalidFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.UndefinedFindResultError, fn ->
        Loader.load(data_provider)
      end
    end
    test "test `InvalidFindValidRepo` loading" do
      data_provider = %DataProvider{
        module: InvalidFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.UndefinedFindResultError, fn ->
        Loader.load(data_provider)
      end
    end
    test "test `InvalidFindInvalidRepo` loading" do
      data_provider = %DataProvider{
        module: InvalidFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"some_filter" => :some_filter_value}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }

      assert_raise DataProvider.UndefinedFindResultError, fn ->
        Loader.load(data_provider)
      end
    end
  end
end
