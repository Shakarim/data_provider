defmodule DataProvider do
  @moduledoc ~S"""
  Library for simple and comfortable working with table data.

  This library implements API for generate and manipulate data

  ## Getting started

  Add this tuple into `deps()` of your `mix.exs`

      def deps() do
        [
          ...
          {:data_provider, "~> 1.1"}
          ...
        ]
      end

  To install these dependencies, we will run this command:

      mix deps.get

  ## Using example
  Firstly, You have to make a `DataProvider` implementation module, like:

      defmodule MyDataLoadModule do
        # Change current module declaration with `DataProvider`
        use DataProvider

        # Function which required to return Repo implementation if you
        # plan to return `Ecto.Query` in `find/1`.
        # If your `find/1` gonna return not a `Ecto.Query` then defining
        # `repo/0` have no make sense.
        def repo(), do: MyRepo

        # Searching logic, receives `DataProvider` and have to return `Ecto.Query` or `list()`
        # This function have to implement only searching, with no orders, offsets and limits.
        def find(%DataProvider{search_options: %_{options: %{"title" => title}}),
          do: Ecto.Query.from(p in Posts, where: p.title == ^title)
        def find(%DataProvider{}), do: Ecto.Query.from(p in Posts)
      end

  When you declared your `DataProvider` implementation, you can use it as adapter for
  manipulate data.

      defmodule MyController do
        use MyAppWeb, :controller
        import DataProvider

        def index(%Plug.Conn{query_params: query_params, path_params: path_params} = conn, _params) do
          # Getting a custom user filtering params (it have to be map). By default,
          # `DataProvider` already contain initial state of searching
          # options (they are empty, no filter, no sorting, nothing).
          received_filter_params = Map.get(query_params, "filter", %{})

          # Trying to get `page` value from user request. By default `DataProvider` already
          # stay in first page position and configurated for 15 items per page.
          page = Map.get(path_params, "page", 1)

          # * `filter(received_filter_params)` - set new filtering params for current `DataProvider`
          # and return updated `DataProvider`.
          # * `change_page(page)` - set new value of page number
          # * `init()` - accept all of your changes and calculate data in the provider.
          data_provider = MyDataLoadModule.data_provider()
                          |> filter(received_filter_params)
                          |> change_page(page)
                          |> init()

          # Usual rendering function
          render(conn, "index.html", data_provider: data_provider)
        end
      end

  This is example of using the `DataProvider` in `Phoenix` application, what we have done:

  As you see, definition of `MyController.index/2` is typical, we will not stop on it, you can find
  more information [here](https://hexdocs.pm/phoenix/Phoenix.Controller.html). I'd only add, that we
  have declared `query_params` and `path_params` variables, they are useful for this example, but it
  isn't required to.

  Finally you will got a struct `DataProvider`, looks like:

      %DataProvider{
        module: MyDataLoadModule,
        data: %DataProvider.Data{
          total_count: 42,
          items: [
            ...
            %Posts{},
            %Posts{},
            %Posts{},
            ...
          ]
        },
        search_options: %DataProvider.SearchOptions{
          options: %{
            "description" => "some find string"
          },
        },
        sort: %DataProvider.Sort{
          options: []
        },
        pagination: %DataProvider.Pagination{
          page: 2,
          params: %DataProvider.Pagination.Params{
            page_size: 15,
            pages_ahead: 3,
            pages_behind: 3,
            load_first_page?: true,
            load_last_page?: true,
            load_opening_separator?: true,
            load_closing_separator?: true
          },
          pages: [
            %DataProvider.Pagination.Page{active: false, number: 1, title: "1", type: :regular},
            %DataProvider.Pagination.Page{active: true, number: 2, title: "2", type: :regular},
            %DataProvider.Pagination.Page{active: false, number: 3, title: "3", type: :regular}
          ]
        }
      }

  This structure contain all required data for using it in another cases, like an rendering the data table,
  returning it by REST-full API, live-reload functionality and etc.
  """

  alias Ecto.Query
  alias __MODULE__.Data
  alias __MODULE__.SearchOptions
  alias __MODULE__.Pagination
  alias __MODULE__.Sort
  alias __MODULE__.Loader

  defstruct module: :not_implemented,
            data: %Data{},
            search_options: %SearchOptions{},
            pagination: %Pagination{},
            sort: %Sort{}

  @typedoc ~S"""
  Type of `DataProvider`

  Contains:

    * `module` - Module atom which implements `DataProvider`. By default
    equal `:not_implemented`.

    * `data` - `DataProvider.Data` struct with result of data selection
    and processing.

    * `search_options` - struct `DataProvider.SearchOptions` contains all
    searching params for exactly this data provider.

    * `sort` - struct `DataProvider.Sort` contains all sorting params for
    exactly this data provider.

    * `pagination` - `DataProvider.Pagination` contains state of current
    of `DataProvider` and implements all business logic of calculating
    page sizes, page counts, offsets, limits and etc.

  """
  @type t() :: %__MODULE__{
                 module: :not_implemented | any(),
                 data: Data.t,
                 search_options: SearchOptions.t,
                 pagination: Pagination.t,
                 sort: Sort.t
               }

  defmodule RepoNotDefinedError do
    @moduledoc ~S"""
    Default raise for `repo/0` function of users `DataProvider` implementation
    """
    defexception message: "repo for this data provider are not implemented"
  end

  defmodule RepoCallError do
    @moduledoc ~S"""
    Raise for `Repo.all/2` function calling
    """
    defexception message: "error of calling `Repo.all/2`, make sure that your `DataProvider` implementation is correct"
  end

  defmodule UndefinedFindResultError do
    @moduledoc ~S"""
    Raise for `find/1` function calling
    """
    defexception message: "find function for this data provider returned unknown data"
  end

  @doc ~S"""
  Using function of this module macro
  """
  defmacro __using__(_args) do
    quote do
      @doc ~S"""
      Defines a repository for making a `DataProvider`

      Function required for getting a data from data store and have to be implemented.

      By default returns `DataProvider.RepoNotDefined`
      """
      @spec repo() :: any()
      def repo(), do: raise(DataProvider.RepoNotDefinedError)

      @doc ~S"""
      Implements business logic for getting finding result.

      This function MUST return `List` or `Ecto.Query`
      """
      @spec find(DataProvider.t) :: Query.t | list()
      def find(%DataProvider{} = _data_provider), do: []

      @doc ~S"""
      Returns value for `module` field of `DataProvider`. It is not overridable function,
      and needs for inner logic only
      """
      @spec module() :: __MODULE__
      def module(), do: __MODULE__

      @doc ~S"""
      Basic function for making `DataProvider`, receives initial searching params and data
      provider options.

      Remember, most of you passed params and options will be modified in runtime. Like an
      `searching params` (you can set new values after initialization), `current page` (the
      same, you can change it later), `total items count` (changes automatically) and etc.

      Arguments:

        * `search_options` - map with searching params, this map will affect total selection.

        * `opts` - keyword with options of `DataProvider`. This options are not affect selection
        globally (you will always get the data you are looking for with `search_oprions`), but
        affect on values in `data`.

      NOTE. `data` field are NOT contain ALL the records from selection. In `data` located only
      processed items. What does it mean?
      When we searching data, we find all the records in data storage (in database, as example)
      which satisfies our searching conditions. And only after that we can set another selection
      options, sorting, paging and etc. This is the "processed data", data, which satisfies our
      searching conditions and which been sorted, paged and etc.

      Thus, in `data` you always can see actual data in right order.

      ## Accept values of `opts`

        * `:init` - boolean value. If `:init` is `true` then current data provider will be
        initiated instantly, otherwise data provider will be created with no initiatialization
        (for actualizing data provider you will be have to call `init/1`).

      """
      @spec data_provider(map(), Keyword.t) :: DataProvider.t
      def data_provider(search_options \\ %{}, data_provider_options \\ [], opts \\ [])
      def data_provider(search_options, data_provider_options, opts) do
        data_provider = %{DataProvider.create(search_options, data_provider_options) | module: __MODULE__}
        if Keyword.get(opts, :init, false), do: DataProvider.init(data_provider), else: data_provider
      end

      defoverridable [find: 1, repo: 0]
    end
  end

  @doc ~S"""
  Function for creating new data provider by search options and module
  configurations.
  """
  @spec create(map(), Keyword.t) :: DataProvider.t
  def create(search_options \\ %{}, opts \\ [])
  def create(search_options, opts) do
    %DataProvider{
      search_options: SearchOptions.create(search_options),
      pagination: Pagination.create(Keyword.get(opts, :pagination, %{})),
      sort: Sort.create(Keyword.get(opts, :sort, []))
    }
  end

  @doc ~S"""
  Initialization function, needs for reload actual state of dataprovider.

  Calling this function will reload inner data and actualize all inner indexes.

  This function was separated to independent mechanism for sparingly using
  a resources.
  """
  @spec init(DataProvider.t) :: DataProvider.t
  def init(%DataProvider{} = data_provider) do
    data_provider
    |> load_data()
    |> load_pages()
  end

  @doc ~S"""
  Reloads dataprovider. Required for stateful data providers.
  """
  @spec reload(DataProvider.t) :: DataProvider.t
  def reload(%DataProvider{} = data_provider), do: DataProvider.init(data_provider)

  @doc ~S"""
  Return current page number of `DataProvider`
  """
  @spec page_number(DataProvider.t) :: integer()
  def page_number(%DataProvider{pagination: %Pagination{} = pagination}), do: Pagination.page(pagination)

  @doc ~S"""
  Returns `DataProvider` with loaded new page.

  This function works similar `change_page/2` with one difference.

  This function are not wait calling `init/1`. Calling the `go_to_page/2`
  reloads data provider right away.
  """
  @spec go_to_page(DataProvider.t, integer()) :: DataProvider.t
  def go_to_page(%DataProvider{} = data_provider, page), do: change_page(data_provider, page, instant: true)

  @doc ~S"""
  Returns `DataProvider` with changed page.

  ## Args

    * `data_provider` - `DataProvider` instance.

    * `page` - integer value with new page for setting.

    * `opts` - keyword with function options.

  ## Accept values of `opts`

    * `:instant` - boolean value. If `:instant` is `true` then current data provider will be
    reloaded instantly, otherwise search params will be loaded with no reloading (for actualizing
    data provider you will be have to call `init/1`). By default is `false`.
  """
  @spec change_page(DataProvider.t, integer(), Keyword.t) :: DataProvider.t
  def change_page(data_provider, page, opts \\ [])
  def change_page(%DataProvider{pagination: %Pagination{} = pagination} = data_provider, page, opts) when is_integer(page) do
    data_provider = %{data_provider | pagination: Pagination.put_page(pagination, page)}
    if Keyword.get(opts, :instant, false), do: init(data_provider), else: data_provider
  end

  @doc ~S"""
  Add new filter params for data provider

  ## Args

    * `data_provider` - `DataProvider` instance

    * `params` - map with new searching params. Value of this argument will be passed
    into `DataProvider.SearchOptions`

    * `opts` - keyword with filtering options.

  ## Accept values of `opts`

    * `:merge` - boolean value, which affect on new searching options. By default - false,
    if `merge` is `false` - passed searching options will replace search options in exist
    data provider. If `true` - will merge.

    * `:instant` - boolean value. If `:instant` is `true` then current data provider will be
    reloaded instantly, otherwise search params will be loaded with no reloading (for actualizing
    data provider you will be have to call `init/1`). By default is `false`.

  """
  @spec filter(DataProvider.t, map(), Keyword.t) :: DataProvider.t
  def filter(data_provider, params \\ %{}, opts \\ [])
  def filter(%DataProvider{} = data_provider, params, opts) when is_map(params) do
    serach_options = if Keyword.get(opts, :merge) === true,
                        do: SearchOptions.merge_options(data_provider.search_options, params),
                        else: SearchOptions.put_options(data_provider.search_options, params)
    data_provider = %{data_provider | search_options: serach_options}
    if Keyword.get(opts, :instant, false), do: init(data_provider), else: data_provider
  end

  @doc ~S"""
  Add new sorting params for data provider

  ## Args

    * `data_provider` - `DataProvider` instance

    * `params` - map with new sorting params. Value of this argument will be passed
    into `DataProvider.Sort`

    * `opts` - keyword with filtering options.

  ## Accept values of `opts`

    * `:merge` - boolean value, which affect on new searching options. By default - false,
    if `merge` is `false` - passed searching options will replace search options in exist
    data provider. If `true` - will merge.

    * `:instant` - boolean value. If `:instant` is `true` then current data provider will be
    reloaded instantly, otherwise search params will be loaded with no reloading (for actualizing
    data provider you will be have to call `init/1`). By default is `false`.

  """
  @spec sort(DataProvider.t, Keyword.t, Keyword.t) :: DataProvider.t
  def sort(data_provider, params \\ [], opts \\ [])
  def sort(%DataProvider{} = data_provider, params, opts) do
    sort = if Keyword.get(opts, :merge),
              do: Sort.merge_options(data_provider.sort, params),
              else: Sort.put_options(data_provider.sort, params)
    data_provider = %{data_provider | sort: sort}
    if Keyword.get(opts, :instant, false), do: init(data_provider), else: data_provider
  end


  # Load data and define it in `DataProvider` by user implementation of dataprovider
  @spec load_data(DataProvider.t) :: DataProvider.t
  defp load_data(%DataProvider{} = data_provider), do: Loader.load(data_provider)

  # Reloads pages in `:pagination` of `DataProvider` and calculate visible
  @spec load_pages(DataProvider.t) :: DataProvider.t
  defp load_pages(%DataProvider{data: %Data{total_count: count}, pagination: %Pagination{} = pagination} = data_provider)
      when is_integer(count) do
    pagination = Pagination.create_page_list(pagination, count)
    %{data_provider | pagination: pagination}
  end
end
