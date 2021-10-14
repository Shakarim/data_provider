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
      result = NoFindNoRepo.data_provider()

      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `NoFindValidRepo`" do
      result = NoFindValidRepo.data_provider()

      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      result = NoFindInvalidRepo.data_provider()

      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end

    test "test for `QueryFindNoRepo`" do
      result = QueryFindNoRepo.data_provider()

      assert result === %DataProvider{
               module: QueryFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `QueryFindValidRepo`" do
      result = QueryFindValidRepo.data_provider()

      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      result = QueryFindInvalidRepo.data_provider()

      assert result === %DataProvider{
               module: QueryFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end

    test "test for `ListFindNoRepo`" do
      result = ListFindNoRepo.data_provider()

      assert result === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `ListFindValidRepo`" do
      result = ListFindValidRepo.data_provider()

      assert result === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `ListFindInvalidRepo`" do
      result = ListFindInvalidRepo.data_provider()

      assert result === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end

    test "test for `InvalidFindNoRepo`" do
      result = InvalidFindNoRepo.data_provider()

      assert result === %DataProvider{
               module: InvalidFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `InvalidFindValidRepo`" do
      result = InvalidFindValidRepo.data_provider()

      assert result === %DataProvider{
               module: InvalidFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `InvalidFindInvalidRepo`" do
      result = InvalidFindInvalidRepo.data_provider()

      assert result === %DataProvider{
               module: InvalidFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
  end

  describe "`data_provider` of implementation with no default arguments |" do
    test "test for `NoFindNoRepo`" do
      result = NoFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `NoFindValidRepo`" do
      result = NoFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      result = NoFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end

    test "test for `QueryFindNoRepo`" do
      result = QueryFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: QueryFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `QueryFindValidRepo`" do
      result = QueryFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      result = QueryFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: QueryFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end

    test "test for `ListFindNoRepo`" do
      result = ListFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `ListFindValidRepo`" do
      result = ListFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `ListFindInvalidRepo`" do
      result = ListFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end

    test "test for `InvalidFindNoRepo`" do
      result = InvalidFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: InvalidFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `InvalidFindValidRepo`" do
      result = InvalidFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: InvalidFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `InvalidFindInvalidRepo`" do
      result = InvalidFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert result === %DataProvider{
               module: InvalidFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
  end

  describe "`data_provider` of implementation with no default arguments (auto init) |" do
    test "test for `NoFindNoRepo`" do
      data_provider = %DataProvider{
        module: NoFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
      result = NoFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)

      assert data_provider === result
    end
    test "test for `NoFindValidRepo`" do
      data_provider = %DataProvider{
        module: NoFindValidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
      result = NoFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)

      assert data_provider === result
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = %DataProvider{
        module: NoFindInvalidRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
      result = NoFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)

      assert data_provider === result
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = %DataProvider{
        module: QueryFindValidRepo,
        data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
      result = QueryFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)

      assert data_provider === result
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = %DataProvider{
        module: ListFindNoRepo,
        data: %DataProvider.Data{items: Enum.to_list(1181..1200), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
      result = ListFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)

      assert data_provider === result
    end
    test "test for `ListFindValidRepo`" do
      data_provider = %DataProvider{
        module: ListFindValidRepo,
        data: %DataProvider.Data{items: Enum.to_list(1181..1200), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
      result = ListFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)

      assert data_provider === result
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = %DataProvider{
        module: ListFindInvalidRepo,
        data: %DataProvider.Data{items: Enum.to_list(1181..1200), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
      result = ListFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)

      assert data_provider === result
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
  end

  describe "`create/2` |" do
    test "test default arguments" do
      data_provider = %DataProvider{
        module: :not_implemented,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{options: []}
      }
      result = DataProvider.create()

      assert data_provider === result
    end

    test "test with no default arguments" do
      data_provider = %DataProvider{
        module: :not_implemented,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
      result = DataProvider.create(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])

      assert data_provider === result
    end
  end

  describe "`init/1` dataprovider with default arguments |" do
    test "test for `NoFindNoRepo`" do
      result = NoFindNoRepo.data_provider()
               |>  DataProvider.init()

      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `NoFindValidRepo`" do
      result = NoFindValidRepo.data_provider()
               |>  DataProvider.init()

      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      result = NoFindInvalidRepo.data_provider()
               |>  DataProvider.init()

      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider() |>  DataProvider.init()
      end
    end
    test "test for `QueryFindValidRepo`" do
      result = QueryFindValidRepo.data_provider()
               |>  DataProvider.init()

      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider()
        |>  DataProvider.init()
      end
    end

    test "test for `ListFindNoRepo`" do
      result = ListFindNoRepo.data_provider()
                      |>  DataProvider.init()

      assert result === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `ListFindValidRepo`" do
      result = ListFindValidRepo.data_provider()
                      |>  DataProvider.init()

      assert result === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `ListFindInvalidRepo`" do
      result = ListFindInvalidRepo.data_provider()
                      |>  DataProvider.init()

      assert result === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
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
      result = NoFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])
               |> DataProvider.init()

      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `NoFindValidRepo`" do
      result = NoFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])
                      |> DataProvider.init()

      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      result = NoFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])
                      |> DataProvider.init()

      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}]) |> DataProvider.init()
      end
    end
    test "test for `QueryFindValidRepo`" do
      result = QueryFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])
               |> DataProvider.init()

      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
               sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}]) |> DataProvider.init()
      end
    end

    test "test for `ListFindNoRepo`" do
      result = ListFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])
               |> DataProvider.init()

      assert result === %DataProvider{
        module: ListFindNoRepo,
        data: %DataProvider.Data{items: Enum.to_list(1181..1200), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
    end
    test "test for `ListFindValidRepo`" do
      result = ListFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])
               |> DataProvider.init()

      assert result === %DataProvider{
        module: ListFindValidRepo,
        data: %DataProvider.Data{items: Enum.to_list(1181..1200), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
    end
    test "test for `ListFindInvalidRepo`" do
      result = ListFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}])
               |> DataProvider.init()

      assert result === %DataProvider{
        module: ListFindInvalidRepo,
        data: %DataProvider.Data{items: Enum.to_list(1181..1200), total_count: 1000},
        search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
        pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 20}},
        sort: %DataProvider.Sort{options: [asc: :filter_param_1]}
      }
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}]) |> DataProvider.init()
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}]) |> DataProvider.init()
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}]) |> DataProvider.init()
      end
    end
  end

  describe "`reload/1` |" do
    test "test for `NoFindNoRepo`" do
      result = NoFindNoRepo.data_provider()
               |>  DataProvider.reload()

      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `NoFindValidRepo`" do
      result = NoFindValidRepo.data_provider()
               |>  DataProvider.reload()

      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      result = NoFindInvalidRepo.data_provider()
               |>  DataProvider.reload()

      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider()
        |>  DataProvider.init()
      end
    end
    test "test for `QueryFindValidRepo`" do
      result = QueryFindValidRepo.data_provider()
               |>  DataProvider.reload()

      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider()
        |>  DataProvider.init()
      end
    end

    test "test for `ListFindNoRepo`" do
      result = ListFindNoRepo.data_provider()
               |>  DataProvider.reload()

      assert result === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `ListFindValidRepo`" do
      result = ListFindValidRepo.data_provider()
               |>  DataProvider.reload()

      assert result === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
    end
    test "test for `ListFindInvalidRepo`" do
      result = ListFindInvalidRepo.data_provider()
               |>  DataProvider.reload()

      assert result === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: []}
             }
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

  describe "`page_number/1`" do
    test "test default value" do
      data_provider = %DataProvider{
        module: NoFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{}},
        pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{}
      }
      result = DataProvider.page_number(data_provider)

      assert result === 1
    end

    test "test value" do
      data_provider = %DataProvider{
        module: NoFindNoRepo,
        data: %DataProvider.Data{items: [], total_count: 0},
        search_options: %DataProvider.SearchOptions{options: %{}},
        pagination: %DataProvider.Pagination{page: 234, params: %DataProvider.Pagination.Params{page_size: 15}},
        sort: %DataProvider.Sort{}
      }
      result = DataProvider.page_number(data_provider)

      assert result === 234
    end
  end

  describe "`go_to_page/2` |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(%{"rem" => 4}, init: true)
      result = DataProvider.go_to_page(data_provider, 10)

      assert data_provider === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.go_to_page(data_provider, 10)

      assert data_provider === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.go_to_page(data_provider, 10)

      assert data_provider === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.go_to_page(data_provider, 10)

      assert data_provider === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.go_to_page(data_provider, 10)

      assert data_provider === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: Enum.to_list(1136..1150), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.go_to_page(data_provider, 10)

      assert data_provider === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1136..1150), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.go_to_page(data_provider, 10)

      assert data_provider === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1136..1150), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
  end

  test "`change_page/2` default call |" do
    data_provider = %DataProvider{
      module: NoFindNoRepo,
      data: %DataProvider.Data{items: [], total_count: 0},
      search_options: %DataProvider.SearchOptions{options: %{}},
      pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
      sort: %DataProvider.Sort{}
    }
    result = DataProvider.change_page(data_provider, 123)

    assert result === %DataProvider{
             module: NoFindNoRepo,
             data: %DataProvider.Data{items: [], total_count: 0},
             search_options: %DataProvider.SearchOptions{options: %{}},
             pagination: %DataProvider.Pagination{page: 123, params: %DataProvider.Pagination.Params{page_size: 15}},
             sort: %DataProvider.Sort{}
           }
  end

  describe "`change_page/2` instant call |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider(%{"rem" => 4})
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert data_provider === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert data_provider === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert data_provider === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert data_provider === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert data_provider === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: Enum.to_list(1136..1150), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert data_provider === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1136..1150), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider(%{"rem" => 4}, [], init: true)
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert data_provider === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1136..1150), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 10, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
  end

  test "`filter/2` default call |" do
    data_provider = %DataProvider{
      module: NoFindNoRepo,
      data: %DataProvider.Data{items: [], total_count: 0},
      search_options: %DataProvider.SearchOptions{options: %{}},
      pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
      sort: %DataProvider.Sort{}
    }
    result = DataProvider.filter(data_provider, %{my_custom: "filter"})

    assert result === %DataProvider{
             module: NoFindNoRepo,
             data: %DataProvider.Data{items: [], total_count: 0},
             search_options: %DataProvider.SearchOptions{options: %{my_custom: "filter"}},
             pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
             sort: %DataProvider.Sort{}
           }
  end

  describe "`filter/2` instant call |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider()
      result = DataProvider.filter(data_provider, %{"rem" => 4}, instant: true)

      assert data_provider === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider()
      result = DataProvider.filter(data_provider, %{"rem" => 4}, instant: true)

      assert data_provider === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider()
      result = DataProvider.filter(data_provider, %{"rem" => 4}, instant: true)

      assert data_provider === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider()
      result = DataProvider.filter(data_provider, %{"rem" => 4}, instant: true)

      assert data_provider === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider()
      result = DataProvider.filter(data_provider, %{"rem" => 4}, instant: true)

      assert data_provider === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider()
      result = DataProvider.filter(data_provider, %{"rem" => 4}, instant: true)

      assert data_provider === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider()
      result = DataProvider.filter(data_provider, %{"rem" => 4}, instant: true)

      assert data_provider === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1001..1015), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{"rem" => 4}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider(%{"rem" => 4}, [sort: [asc: :filter_param_1], pagination: %{page: 10, params: %{page_size: 20}}], init: true)
      end
    end
  end

  describe "`sort/2` instant call |" do
    test "test for `NoFindNoRepo`" do
      data_provider = NoFindNoRepo.data_provider()
      result = DataProvider.sort(data_provider, [desc: :inserted_at], instant: true)

      assert data_provider === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: [desc: :inserted_at]}
             }
    end
    test "test for `NoFindValidRepo`" do
      data_provider = NoFindValidRepo.data_provider()
      result = DataProvider.sort(data_provider, [desc: :inserted_at], instant: true)

      assert data_provider === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: [desc: :inserted_at]}
             }
    end
    test "test for `NoFindInvalidRepo`" do
      data_provider = NoFindInvalidRepo.data_provider()
      result = DataProvider.sort(data_provider, [desc: :inserted_at], instant: true)

      assert data_provider === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: NoFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: [desc: :inserted_at]}
             }
    end

    test "test for `QueryFindNoRepo`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        QueryFindNoRepo.data_provider()
        |> DataProvider.sort([desc: :inserted_at], instant: true)
      end
    end
    test "test for `QueryFindValidRepo`" do
      data_provider = QueryFindValidRepo.data_provider()
      result = DataProvider.sort(data_provider, [desc: :inserted_at], instant: true)

      assert data_provider === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: QueryFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..100), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: [desc: :inserted_at]}
             }
    end
    test "test for `QueryFindInvalidRepo`" do
      assert_raise DataProvider.RepoCallError, fn ->
        QueryFindInvalidRepo.data_provider()
        |> DataProvider.sort([desc: :inserted_at], instant: true)
      end
    end

    test "test for `ListFindNoRepo`" do
      data_provider = ListFindNoRepo.data_provider()
      result = DataProvider.sort(data_provider, [desc: :inserted_at], instant: true)

      assert data_provider === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindNoRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..15), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: [desc: :inserted_at]}
             }
    end
    test "test for `ListFindValidRepo`" do
      data_provider = ListFindValidRepo.data_provider()
      result = DataProvider.sort(data_provider, [desc: :inserted_at], instant: true)

      assert data_provider === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindValidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..15), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: [desc: :inserted_at]}
             }
    end
    test "test for `ListFindInvalidRepo`" do
      data_provider = ListFindInvalidRepo.data_provider()
      result = DataProvider.sort(data_provider, [desc: :inserted_at], instant: true)

      assert data_provider === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: [], total_count: 0},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{}
             }
      assert result === %DataProvider{
               module: ListFindInvalidRepo,
               data: %DataProvider.Data{items: Enum.to_list(1..15), total_count: 1000},
               search_options: %DataProvider.SearchOptions{options: %{}},
               pagination: %DataProvider.Pagination{page: 1, params: %DataProvider.Pagination.Params{page_size: 15}},
               sort: %DataProvider.Sort{options: [desc: :inserted_at]}
             }
    end

    test "test for `InvalidFindNoRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindNoRepo.data_provider()
        |> DataProvider.sort([desc: :inserted_at], instant: true)
      end
    end
    test "test for `InvalidFindValidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindValidRepo.data_provider()
        |> DataProvider.sort([desc: :inserted_at], instant: true)
      end
    end
    test "test for `InvalidFindInvalidRepo`" do
      assert_raise DataProvider.UndefinedFindResultError, fn ->
        InvalidFindInvalidRepo.data_provider()
        |> DataProvider.sort([desc: :inserted_at], instant: true)
      end
    end
  end
end
