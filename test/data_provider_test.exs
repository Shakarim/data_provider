defmodule DataProviderTest do
  use ExUnit.Case
  use DataProvider.DataCase
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
  alias DataProvider.TestRepo
  alias Ecto.Query
  doctest DataProvider

  @default_page_size 15

  @search_params %{"rem" => 4}
  @options [
    sort: [asc: :filter_param_1],
    pagination: %{page: 5, page_size: 20}
  ]

  @query_default_total 100
  @query_default_items [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100]
  @query_filtered_total 100
  @query_filtered_items [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100]

  @list_default_total 1000
  @list_default_items [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
  @list_filtered_items [324, 328, 332, 336, 340, 344, 348, 352, 356, 360, 364, 368, 372, 376, 380, 384, 388, 392, 396, 400]
  @list_filtered_total 250

  describe "`repo/0` of implementation |" do
    test "test for `NoFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        NoFindNoRepo.repo()
      end
    end
    test "test for `NoFindValidRepo`" do
      result = NoFindValidRepo.repo()

      assert match?(TestRepo, result)
    end
    test "test for `NoFindInvalidRepo`" do
      result = NoFindInvalidRepo.repo()

      assert not match?(TestRepo, result)
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.repo()
      end
    end
    test "test for `QueryFindValidRepo`" do
      result = QueryFindValidRepo.repo()

      assert match?(TestRepo, result)
    end
    test "test for `QueryFindInvalidRepo`" do
      result = QueryFindInvalidRepo.repo()

      assert not match?(TestRepo, result)
    end

    test "test for `ListFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        ListFindNoRepo.repo()
      end
    end
    test "test for `ListFindValidRepo`" do
      result = ListFindValidRepo.repo()

      assert match?(TestRepo, result)
    end
    test "test for `ListFindInvalidRepo`" do
      result = ListFindInvalidRepo.repo()

      assert not match?(TestRepo, result)
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        InvalidFindNoRepo.repo()
      end
    end
    test "test for `InvalidFindValidRepo`" do
      result = InvalidFindValidRepo.repo()

      assert match?(TestRepo, result)
    end
    test "test for `InvalidFindInvalidRepo`" do
      result = InvalidFindInvalidRepo.repo()

      assert not match?(TestRepo, result)
    end
  end

  describe "`find/1` of implementation |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider()
      result = NoFindNoRepo.find(data_provider)

      assert match?(%Query{}, result) or is_list(result)
      assert result === []
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider()
      result = NoFindValidRepo.find(data_provider)

      assert match?(%Query{}, result) or is_list(result)
      assert result === []
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider()
      result = NoFindInvalidRepo.find(data_provider)

      assert match?(%Query{}, result) or is_list(result)
      assert result === []
    end

    test "test for `QueryFindNoRepo`" do
      data_provider = QueryFindNoRepo.data_provider()
      result = QueryFindNoRepo.find(data_provider)

      assert match?(%Query{}, result)
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider()
      result = QueryFindValidRepo.find(data_provider)

      assert match?(%Query{}, result)
    end
    test "test for `QueryFindInvalidRepo`" do
      data_provider = QueryFindInvalidRepo.data_provider()
      result = QueryFindInvalidRepo.find(data_provider)

      assert match?(%Query{}, result)
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider()
      result = ListFindNoRepo.find(data_provider)

      assert is_list(result)
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider()
      result = ListFindValidRepo.find(data_provider)

      assert is_list(result)
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider()
      result = ListFindInvalidRepo.find(data_provider)

      assert is_list(result)
    end

    test "test for `InvalidFindNoRepo`" do
      data_provider = InvalidFindNoRepo.data_provider()
      result = InvalidFindNoRepo.find(data_provider)

      assert not match?(%Query{}, result) and not is_list(result)
    end
    test "test for `InvalidFindValidRepo`" do
      data_provider = InvalidFindValidRepo.data_provider()
      result = InvalidFindValidRepo.find(data_provider)

      assert not match?(%Query{}, result) and not is_list(result)
    end
    test "test for `InvalidFindInvalidRepo`" do
      data_provider = InvalidFindInvalidRepo.data_provider()
      result = InvalidFindInvalidRepo.find(data_provider)

      assert not match?(%Query{}, result) and not is_list(result)
    end
  end

  describe "`module/0` of implementation |" do
    test "test for `NoFindNoRepo`" do
      assert NoFindNoRepo.module() === NoFindNoRepo
    end
    test "test for `NoFindValidRepo`" do
      assert NoFindValidRepo.module() === NoFindValidRepo
    end
    test "test for `NoFindInvalidRepo`" do
      assert NoFindInvalidRepo.module() === NoFindInvalidRepo
    end

    test "test for `QueryFindNoRepo`" do
      assert QueryFindNoRepo.module() === QueryFindNoRepo
    end
    test "test for `QueryFindValidRepo`" do
      assert QueryFindValidRepo.module() === QueryFindValidRepo
    end
    test "test for `QueryFindInvalidRepo`" do
      assert QueryFindInvalidRepo.module() === QueryFindInvalidRepo
    end

    test "test for `ListFindNoRepo`" do
      assert ListFindNoRepo.module() === ListFindNoRepo
    end
    test "test for `ListFindValidRepo`" do
      assert ListFindValidRepo.module() === ListFindValidRepo
    end
    test "test for `ListFindInvalidRepo`" do
      assert ListFindInvalidRepo.module() === ListFindInvalidRepo
    end

    test "test for `InvalidFindNoRepo`" do
      assert InvalidFindNoRepo.module() === InvalidFindNoRepo
    end
    test "test for `InvalidFindValidRepo`" do
      assert InvalidFindValidRepo.module() === InvalidFindValidRepo
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert InvalidFindInvalidRepo.module() === InvalidFindInvalidRepo
    end
  end

  describe "`data_provider` of implementation with default arguments |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindNoRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindValidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindInvalidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      data_provider = QueryFindNoRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindNoRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindValidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `QueryFindInvalidRepo`" do
      data_provider = QueryFindInvalidRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindInvalidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindNoRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindValidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindInvalidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `InvalidFindNoRepo`" do
      data_provider = InvalidFindNoRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === InvalidFindNoRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `InvalidFindValidRepo`" do
      data_provider = InvalidFindValidRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === InvalidFindValidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `InvalidFindInvalidRepo`" do
      data_provider = InvalidFindInvalidRepo.data_provider()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === InvalidFindInvalidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
  end

  describe "`data_provider` of implementation with no default arguments |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindNoRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindInvalidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      data_provider = QueryFindNoRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindNoRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `QueryFindInvalidRepo`" do
      data_provider = QueryFindInvalidRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindInvalidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindNoRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindInvalidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `InvalidFindNoRepo`" do
      data_provider = InvalidFindNoRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === InvalidFindNoRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `InvalidFindValidRepo`" do
      data_provider = InvalidFindValidRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === InvalidFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `InvalidFindInvalidRepo`" do
      data_provider = InvalidFindInvalidRepo.data_provider(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === InvalidFindInvalidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
  end

  describe "`data_provider` of implementation with no default arguments (auto init) |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(@search_params, @options, init: true)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindNoRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(@search_params, @options, init: true)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(@search_params, @options, init: true)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindInvalidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(@search_params, @options, init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(@search_params, @options, init: true)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === @query_filtered_items
      assert data_provider.data.total_count === @query_filtered_total
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(@search_params, @options, init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(@search_params, @options, init: true)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindNoRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === @list_filtered_items
      assert data_provider.data.total_count === @list_filtered_total
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(@search_params, @options, init: true)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === @list_filtered_items
      assert data_provider.data.total_count === @list_filtered_total
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(@search_params, @options, init: true)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindInvalidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === @list_filtered_items
      assert data_provider.data.total_count === @list_filtered_total
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(@search_params, @options, init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(@search_params, @options, init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(@search_params, @options, init: true)
      end
    end
  end

  describe "`create/2` |" do
    test "test default arguments" do
      data_provider = DataProvider.create()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === :not_implemented
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test with no default arguments" do
      data_provider = DataProvider.create(@search_params, @options)

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === :not_implemented
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
  end

  describe "`init/1` dataprovider with default arguments |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider()
                      |>  DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindNoRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider()
                      |>  DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindValidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider()
                      |>  DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindInvalidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider()
        |>  DataProvider.init()
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider()
                      |>  DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindValidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === @query_default_items
      assert data_provider.data.total_count === @query_default_total
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider()
        |>  DataProvider.init()
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider()
                      |>  DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindNoRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === @list_default_items
      assert data_provider.data.total_count === @list_default_total
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider()
                      |>  DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindValidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === @list_default_items
      assert data_provider.data.total_count === @list_default_total
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider()
                      |>  DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindInvalidRepo
      assert data_provider.search_options === DataProvider.SearchOptions.create()
      assert data_provider.pagination === DataProvider.Pagination.create()
      assert data_provider.sort === DataProvider.Sort.create()
      assert data_provider.data.items === @list_default_items
      assert data_provider.data.total_count === @list_default_total
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider() |>  DataProvider.init()
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider() |>  DataProvider.init()
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider() |>  DataProvider.init()
      end
    end
  end

  describe "`init/1` with no default arguments |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(@search_params, @options)
                      |> DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindNoRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(@search_params, @options)
                      |> DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(@search_params, @options)
                      |> DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === NoFindInvalidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === []
      assert data_provider.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(@search_params, @options) |> DataProvider.init()
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(@search_params, @options)
                      |> DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === QueryFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === @query_filtered_items
      assert data_provider.data.total_count === @query_filtered_total
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(@search_params, @options) |> DataProvider.init()
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(@search_params, @options)
                      |> DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindNoRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === @list_filtered_items
      assert data_provider.data.total_count === @list_filtered_total
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(@search_params, @options)
                      |> DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindValidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === @list_filtered_items
      assert data_provider.data.total_count === @list_filtered_total
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(@search_params, @options)
                      |> DataProvider.init()

      assert match?(%DataProvider{}, data_provider)
      assert data_provider.module === ListFindInvalidRepo
      assert data_provider.search_options.options === @search_params
      assert data_provider.pagination.page === (@options)[:pagination].page
      assert data_provider.pagination.page_size === (@options)[:pagination].page_size
      assert data_provider.sort.options === (@options)[:sort]
      assert data_provider.data.items === @list_filtered_items
      assert data_provider.data.total_count === @list_filtered_total
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(@search_params, @options) |> DataProvider.init()
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(@search_params, @options) |> DataProvider.init()
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(@search_params, @options) |> DataProvider.init()
      end
    end
  end

  describe "`reload/1` |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(%{}, [], init: true)
      new_data_provider = %{
        data_provider |
        search_options: %{data_provider.search_options | options: @search_params},
        pagination: %{
          data_provider.pagination |
          page: (@options)[:pagination].page,
          page_size: (@options)[:pagination].page_size
        }
      }
      result = DataProvider.reload(new_data_provider)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === 5
      assert result.pagination.page_size === 20
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(%{}, [], init: true)
      new_data_provider = %{
        data_provider |
        search_options: %{data_provider.search_options | options: @search_params},
        pagination: %{
          data_provider.pagination |
          page: (@options)[:pagination].page,
          page_size: (@options)[:pagination].page_size
        }
      }
      result = DataProvider.reload(new_data_provider)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === 5
      assert result.pagination.page_size === 20
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(%{}, [], init: true)
      new_data_provider = %{
        data_provider |
        search_options: %{data_provider.search_options | options: @search_params},
        pagination: %{
          data_provider.pagination |
          page: (@options)[:pagination].page,
          page_size: (@options)[:pagination].page_size
        }
      }
      result = DataProvider.reload(new_data_provider)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === 5
      assert result.pagination.page_size === 20
      assert result.data.items === []
      assert result.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(%{}, [], init: true)
      new_data_provider = %{
        data_provider |
        search_options: %{data_provider.search_options | options: @search_params},
        pagination: %{
          data_provider.pagination |
          page: (@options)[:pagination].page,
          page_size: (@options)[:pagination].page_size
        }
      }
      result = DataProvider.reload(new_data_provider)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === (@options)[:pagination].page_size
      assert result.data.items === @query_filtered_items
      assert result.data.total_count === @query_filtered_total
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(%{}, [], init: true)
      new_data_provider = %{
        data_provider |
        search_options: %{data_provider.search_options | options: @search_params},
        pagination: %{
          data_provider.pagination |
          page: (@options)[:pagination].page,
          page_size: (@options)[:pagination].page_size
        }
      }
      result = DataProvider.reload(new_data_provider)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === (@options)[:pagination].page_size
      assert result.data.items === @list_filtered_items
      assert result.data.total_count === @list_filtered_total
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(%{}, [], init: true)
      new_data_provider = %{
        data_provider |
        search_options: %{data_provider.search_options | options: @search_params},
        pagination: %{
          data_provider.pagination |
          page: (@options)[:pagination].page,
          page_size: (@options)[:pagination].page_size
        }
      }
      result = DataProvider.reload(new_data_provider)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === (@options)[:pagination].page_size
      assert result.data.items === @list_filtered_items
      assert result.data.total_count === @list_filtered_total
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(%{}, [], init: true)
      new_data_provider = %{
        data_provider |
        search_options: %{data_provider.search_options | options: @search_params},
        pagination: %{
          data_provider.pagination |
          page: (@options)[:pagination].page,
          page_size: (@options)[:pagination].page_size
        }
      }
      result = DataProvider.reload(new_data_provider)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === (@options)[:pagination].page_size
      assert result.data.items === @list_filtered_items
      assert result.data.total_count === @list_filtered_total
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end
  end

  describe "`page_number/1`" do
    test "test default value" do
      result = DataProvider.create()

      assert DataProvider.page_number(result) === 1
    end

    test "test value" do
      result = DataProvider.create(@search_params, @options)

      assert DataProvider.page_number(result) === (@options)[:pagination].page
    end
  end

  describe "`go_to_page/2` |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(%{}, [], init: true)
      result = DataProvider.go_to_page(data_provider, (@options)[:pagination].page)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(%{}, [], init: true)
      result = DataProvider.go_to_page(data_provider, (@options)[:pagination].page)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(%{}, [], init: true)
      result = DataProvider.go_to_page(data_provider, (@options)[:pagination].page)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(%{}, [], init: true)
      result = DataProvider.go_to_page(data_provider, (@options)[:pagination].page)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === @query_filtered_items
      assert result.data.total_count === @query_filtered_total
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(%{}, [], init: true)
      result = DataProvider.go_to_page(data_provider, (@options)[:pagination].page)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === Enum.to_list(61..75)
      assert result.data.total_count === @list_default_total
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(%{}, [], init: true)
      result = DataProvider.go_to_page(data_provider, (@options)[:pagination].page)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === Enum.to_list(61..75)
      assert result.data.total_count === @list_default_total
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(%{}, [], init: true)
      result = DataProvider.go_to_page(data_provider, (@options)[:pagination].page)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === Enum.to_list(61..75)
      assert result.data.total_count === @list_default_total
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end
  end

  describe "`change_page/2` instant call |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(%{}, [])
      result = DataProvider.change_page(data_provider, (@options)[:pagination].page, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(%{}, [])
      result = DataProvider.change_page(data_provider, (@options)[:pagination].page, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(%{}, [])
      result = DataProvider.change_page(data_provider, (@options)[:pagination].page, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(%{}, [])
      result = DataProvider.change_page(data_provider, (@options)[:pagination].page, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === @query_filtered_items
      assert result.data.total_count === @query_filtered_total
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(%{}, [])
      result = DataProvider.change_page(data_provider, (@options)[:pagination].page, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === Enum.to_list(61..75)
      assert result.data.total_count === @list_default_total
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(%{}, [])
      result = DataProvider.change_page(data_provider, (@options)[:pagination].page, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === Enum.to_list(61..75)
      assert result.data.total_count === @list_default_total
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(%{}, [])
      result = DataProvider.change_page(data_provider, (@options)[:pagination].page, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === []
      assert result.pagination.page === (@options)[:pagination].page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === Enum.to_list(61..75)
      assert result.data.total_count === @list_default_total
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end
  end

  describe "`filter/2` instant call |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(%{}, [])
      result = DataProvider.filter(data_provider, @search_params, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(%{}, [])
      result = DataProvider.filter(data_provider, @search_params, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(%{}, [])
      result = DataProvider.filter(data_provider, @search_params, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(%{}, [])
      result = DataProvider.filter(data_provider, @search_params, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === @query_filtered_items
      assert result.data.total_count === @query_filtered_total
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(%{}, [])
      result = DataProvider.filter(data_provider, @search_params, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === [4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60]
      assert result.data.total_count === @list_filtered_total
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(%{}, [])
      result = DataProvider.filter(data_provider, @search_params, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === [4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60]
      assert result.data.total_count === @list_filtered_total
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(%{}, [])
      result = DataProvider.filter(data_provider, @search_params, instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === @search_params
      assert result.sort.options === []
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === [4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60]
      assert result.data.total_count === @list_filtered_total
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end
  end

  describe "`sort/2` instant call |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(%{}, [])
      result = DataProvider.sort(data_provider, (@options)[:sort], instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === (@options)[:sort]
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(%{}, [])
      result = DataProvider.sort(data_provider, (@options)[:sort], instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === (@options)[:sort]
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(%{}, [])
      result = DataProvider.sort(data_provider, (@options)[:sort], instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === (@options)[:sort]
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === []
      assert result.data.total_count === 0
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(%{}, [])
      result = DataProvider.sort(data_provider, (@options)[:sort], instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === (@options)[:sort]
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === @query_filtered_items
      assert result.data.total_count === @query_filtered_total
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(%{}, [])
      result = DataProvider.sort(data_provider, (@options)[:sort], instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === (@options)[:sort]
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === @list_default_items
      assert result.data.total_count === @list_default_total
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(%{}, [])
      result = DataProvider.sort(data_provider, (@options)[:sort], instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === (@options)[:sort]
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === @list_default_items
      assert result.data.total_count === @list_default_total
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(%{}, [])
      result = DataProvider.sort(data_provider, (@options)[:sort], instant: true)

      assert match?(%DataProvider{}, result)
      assert result.search_options.options === %{}
      assert result.sort.options === (@options)[:sort]
      assert result.pagination.page === data_provider.pagination.page
      assert result.pagination.page_size === @default_page_size
      assert result.data.items === @list_default_items
      assert result.data.total_count === @list_default_total
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{}, [], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{}, [], init: true)
      end
    end
  end
end
