defmodule DataProviderTest do
  use ExUnit.Case
  use DataProvider.DataCase
  alias DataProvider.FakeModules.QueryModule
  alias DataProvider.FakeModules.ListModule
  alias DataProvider.FakeModules.ImplementNothing
  alias DataProvider.FakeModules.ImplementAll
  doctest DataProvider

  @data_provider_search_params %{"filter_param_1" => :filter_value_1}
  @data_provider_options [
    sort: [asc: :filter_param_1],
    pagination: %{page: 3, page_size: 4}
  ]

  def fixture(:data_provider, _),
      do: DataProvider.create @data_provider_search_params, @data_provider_options


  defp data_provider(params), do: {:ok, data_provider: fixture(:data_provider, params)}

  setup [:data_provider]

  describe "`__using__/1` macro |" do
    test "test default `repo/0`" do
      assert_raise DataProvider.RepoNotDefinedError, fn ->
        ImplementNothing.repo()
      end
    end

    test "test overrided `repo/0`" do
      assert ImplementAll.repo() === :repo
    end

    test "test default `find/1`" do
      assert ImplementNothing.find(%DataProvider{}) === []
    end

    test "test overrided `find/1`" do
      assert ImplementAll.find(:data_provider) === :find_result
    end

    test "test default `module/0`" do
      assert ImplementNothing.module() === ImplementNothing
    end

    test "test overrided `module/0`" do
      assert ImplementAll.module() === ImplementAll
    end

    test "test default `data_provider/0`" do
      result = ImplementNothing.data_provider()

      assert match?(%DataProvider{}, result)
      assert result.module === ImplementNothing
      assert result.search_options === DataProvider.SearchOptions.create()
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
      assert result.data === %DataProvider.Data{}
    end

    test "test default `data_provider/1`" do
      result = ImplementNothing.data_provider(@data_provider_search_params)

      assert match?(%DataProvider{}, result)
      assert result.module === ImplementNothing
      assert result.search_options === DataProvider.SearchOptions.create(@data_provider_search_params)
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
      assert result.data === %DataProvider.Data{}
    end

    test "test default `data_provider/2`" do
      result = ImplementNothing.data_provider(@data_provider_search_params, @data_provider_options)

      assert match?(%DataProvider{}, result)
      assert result.module === ImplementNothing
      assert result.search_options === DataProvider.SearchOptions.create(@data_provider_search_params)
      assert result.sort === DataProvider.Sort.create(@data_provider_options[:sort])
      assert result.pagination === DataProvider.Pagination.create(@data_provider_options[:pagination])
      assert result.data === %DataProvider.Data{}
    end

    test "test `data_provider/3`, init: true" do
      result = QueryModule.data_provider(@data_provider_search_params, @data_provider_options, init: true)

      assert match?(%DataProvider{}, result)
      assert result.module === QueryModule
      assert result.search_options === DataProvider.SearchOptions.create(@data_provider_search_params)
      assert result.sort === DataProvider.Sort.create(@data_provider_options[:sort])
      assert result.pagination === DataProvider.Pagination.create(@data_provider_options[:pagination])
    end
  end

  describe "`create` |" do
    test "test `create/0`" do
      result = DataProvider.create()

      assert match?(%DataProvider{}, result)
      assert result.module === :not_implemented
      assert result.search_options === DataProvider.SearchOptions.create()
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
      assert result.data === %DataProvider.Data{}
    end

    test "test `create/1`" do
      result = DataProvider.create(@data_provider_search_params)

      assert match?(%DataProvider{}, result)
      assert result.module === :not_implemented
      assert result.search_options === DataProvider.SearchOptions.create(@data_provider_search_params)
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
      assert result.data === %DataProvider.Data{}
    end

    test "test `create/2`" do
      result = DataProvider.create(@data_provider_search_params, @data_provider_options)

      assert match?(%DataProvider{}, result)
      assert result.module === :not_implemented
      assert result.search_options === DataProvider.SearchOptions.create(@data_provider_search_params)
      assert result.sort === DataProvider.Sort.create(@data_provider_options[:sort])
      assert result.pagination === DataProvider.Pagination.create(@data_provider_options[:pagination])
      assert result.data === %DataProvider.Data{}
    end
  end

  describe "`init/1` |" do
    test "call for `QueryModule`" do
      result = QueryModule.data_provider() |> DataProvider.init()

      assert match?(%DataProvider{}, result)
      assert result.module === QueryModule
      assert result.search_options === DataProvider.SearchOptions.create()
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
    end

    test "call for `ListModule`" do
      result = ListModule.data_provider()
               |> DataProvider.init()

      assert match?(%DataProvider{}, result)
      assert result.module === ListModule
      assert result.search_options === DataProvider.SearchOptions.create()
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
    end

    test "call for `ImplementNothing`" do
      result = ImplementNothing.data_provider()
               |> DataProvider.init()

      assert match?(%DataProvider{}, result)
      assert result.module === ImplementNothing
      assert result.search_options === DataProvider.SearchOptions.create()
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
    end
  end

  describe "`reload/1` |" do
    test "call for `QueryModule`" do
      result = QueryModule.data_provider()
               |> DataProvider.init()
               |> DataProvider.reload()

      assert match?(%DataProvider{}, result)
      assert result.module === QueryModule
      assert result.search_options === DataProvider.SearchOptions.create()
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
    end

    test "call for `ListModule`" do
      result = ListModule.data_provider()
               |> DataProvider.init()
               |> DataProvider.reload()

      assert match?(%DataProvider{}, result)
      assert result.module === ListModule
      assert result.search_options === DataProvider.SearchOptions.create()
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
    end

    test "call for `ImplementNothing`" do
      result = ImplementNothing.data_provider()
               |> DataProvider.init()
               |> DataProvider.reload()

      assert match?(%DataProvider{}, result)
      assert result.module === ImplementNothing
      assert result.search_options === DataProvider.SearchOptions.create()
      assert result.sort === DataProvider.Sort.create()
      assert result.pagination === DataProvider.Pagination.create()
    end
  end

  describe "`page_number/1`" do
    test "test default value" do
      result = DataProvider.create()

      assert DataProvider.page_number(result) === 1
    end

    test "test value" do
      result = DataProvider.create(@data_provider_search_params, @data_provider_options)

      assert DataProvider.page_number(result) === (@data_provider_options)[:pagination].page
    end
  end

  describe "`go_to_page/2` |" do
    test "call for `QueryModule`" do
      result = QueryModule.data_provider()
               |> DataProvider.init()
      reloaded = DataProvider.go_to_page(result, 10)

      assert DataProvider.page_number(reloaded) === 10
    end

    test "call for `ListModule`" do
      result = ListModule.data_provider()
               |> DataProvider.init()
      reloaded = DataProvider.go_to_page(result, 10)

      assert DataProvider.page_number(reloaded) === 10
    end

    test "call for `ImplementNothing`" do
      result = ImplementNothing.data_provider()
               |> DataProvider.init()
      reloaded = DataProvider.go_to_page(result, 10)

      assert DataProvider.page_number(reloaded) === 10
    end
  end

  describe "`change_page/2` |" do
    test "default call for `QueryModule`" do
      data_provider = QueryModule.data_provider() |> DataProvider.init()
      result = DataProvider.change_page(data_provider, 10)

      assert DataProvider.page_number(result) === 10
    end

    test "default call for `ListModule`" do
      data_provider = ListModule.data_provider() |> DataProvider.init()
      result = DataProvider.change_page(data_provider, 10)

      assert DataProvider.page_number(result) === 10
    end

    test "default call for `ImplementNothing`" do
      data_provider = ImplementNothing.data_provider() |> DataProvider.init()
      result =  DataProvider.change_page(data_provider, 10)

      assert DataProvider.page_number(result) === 10
    end

    test "instant call for `QueryModule`" do
      data_provider = QueryModule.data_provider() |> DataProvider.init()
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert DataProvider.page_number(result) === 10
    end

    test "instant call for `ListModule`" do
      data_provider = ListModule.data_provider() |> DataProvider.init()
      result = DataProvider.change_page(data_provider, 10, instant: true)

      assert DataProvider.page_number(result) === 10
    end

    test "instant call for `ImplementNothing`" do
      data_provider = ImplementNothing.data_provider() |> DataProvider.init()
      result =  DataProvider.change_page(data_provider, 10, instant: true)

      assert DataProvider.page_number(result) === 10
    end
  end

  describe "`filter/2` |" do
    test "default call for `QueryModule`" do
      data_provider = QueryModule.data_provider() |> DataProvider.init()
      result = DataProvider.filter(data_provider, %{new_filter: "new filter"})

      assert result.search_options !== data_provider.search_options
    end

    test "default call for `ListModule`" do
      data_provider = ListModule.data_provider() |> DataProvider.init()
      result = DataProvider.filter(data_provider, %{new_filter: "new filter"})

      assert result.search_options !== data_provider.search_options
    end

    test "default call for `ImplementNothing`" do
      data_provider = ImplementNothing.data_provider() |> DataProvider.init()
      result =  DataProvider.filter(data_provider, %{new_filter: "new filter"})

      assert result.search_options !== data_provider.search_options
    end

    test "instant call for `QueryModule`" do
      data_provider = QueryModule.data_provider() |> DataProvider.init()
      result = DataProvider.filter(data_provider, %{new_filter: "new filter"}, instant: true)

      assert result.search_options !== data_provider.search_options
    end

    test "instant call for `ListModule`" do
      data_provider = ListModule.data_provider() |> DataProvider.init()
      result = DataProvider.filter(data_provider, %{new_filter: "new filter"}, instant: true)

      assert result.search_options !== data_provider.search_options
    end

    test "instant call for `ImplementNothing`" do
      data_provider = ImplementNothing.data_provider() |> DataProvider.init()
      result =  DataProvider.filter(data_provider, %{new_filter: "new filter"}, instant: true)

      assert result.search_options !== data_provider.search_options
    end
  end

  describe "`sort/2` |" do
    test "default call for `QueryModule`" do
      data_provider = QueryModule.data_provider() |> DataProvider.init()
      result = DataProvider.sort(data_provider, [asc: "my_field"])

      assert result.sort !== data_provider.sort
    end

    test "default call for `ListModule`" do
      data_provider = ListModule.data_provider() |> DataProvider.init()
      result = DataProvider.sort(data_provider, [asc: "my_field"])

      assert result.sort !== data_provider.sort
    end

    test "default call for `ImplementNothing`" do
      data_provider = ImplementNothing.data_provider() |> DataProvider.init()
      result =  DataProvider.sort(data_provider, [asc: "my_field"])

      assert result.sort !== data_provider.sort
    end

    test "instant call for `QueryModule`" do
      data_provider = QueryModule.data_provider() |> DataProvider.init()
      result = DataProvider.sort(data_provider, [asc: :my_field], instant: true)

      assert result.sort !== data_provider.sort
    end

    test "instant call for `ListModule`" do
      data_provider = ListModule.data_provider() |> DataProvider.init()
      result = DataProvider.sort(data_provider, [asc: "my_field"], instant: true)

      assert result.sort !== data_provider.sort
    end

    test "instant call for `ImplementNothing`" do
      data_provider = ImplementNothing.data_provider() |> DataProvider.init()
      result =  DataProvider.sort(data_provider, [asc: "my_field"], instant: true)

      assert result.sort !== data_provider.sort
    end
  end
end
