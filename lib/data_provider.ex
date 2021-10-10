defmodule DataProvider do
  @moduledoc ~S"""
  Library for simple and comfortable working with table data.

  This library implements API for generate and manipulate data.
  As example:

  1. You have to make a `DataProvider` implementation module, like:

      defmodule MyDataLoadModule do
        # Change current module declaration with `DataProvider`
        use DataProvider

        # Required function, have to return Repo implementation.
        # By default provoke `DataProvider.RepoNotDefinedError` exception
        def repo(), do: MyRepo

        # Searching logic, receives `DataProvider` and have to return `Ecto.Query` or `List.t`
        # This function have to implement only searching, with no orders, offsets and limits.
        def find(%DataProvider{search_options: %_{options: %{"title" => title}}),
          do: Ecto.Query.from(p in Posts, where: p.title == ^title)
        def find(%DataProvider{}), do: Ecto.Query.from(p in Posts)
      end

  2. When you declared your `DataProvider` implementation, you can use it as adapter for
  manupulating data.

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

          data_provider = MyDataLoadModule.data_provider()
                          # set new filtering params for current `DataProvider` and return
                          # updated `DataProvider`
                          |> filter(received_filter_params)
                          # set new value of page number
                          |> change_page(page)
                          # accept all of your changes and calculate data in the provider.
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
        }
        pagination: %DataProvider.Pagination{
          page: 2,
          page_size: 15
        }
      }

  which contain all required data for using it in another cases, like an rendering the data table,
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

  defmodule UndefinedFindError do
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
      @spec find(DataProvider.t) :: Query.t | List.t
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
      @spec data_provider(Map.t, Keyword.t) :: DataProvider.t
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
  @spec create(Map.t, Keyword.t) :: DataProvider.t
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
  def init(%DataProvider{} = data_provider), do: load_data(data_provider)

  @doc ~S"""
  Reloads dataprovider. Required for stateful data providers.
  """
  @spec reload(DataProvider.t) :: DataProvider.t
  def reload(%DataProvider{} = data_provider), do: DataProvider.init(data_provider)

  @doc ~S"""
  Return current page number of `DataProvider`
  """
  @spec page_number(DataProvider.t) :: Integer.t
  def page_number(%DataProvider{pagination: %Pagination{} = pagination}), do: Pagination.page(pagination)

  @doc ~S"""
  Returns `DataProvider` with loaded new page.

  This function works similar `page/2` with one difference.

  This function are not wait calling `init/1`. Calling the `go_to_page/2`
  reloads data provider right away.
  """
  @spec go_to_page(DataProvider.t, Integer.t) :: DataProvider.t
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
  @spec change_page(DataProvider.t, Integer.t, Keyword.t) :: DataProvider.t
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
  @spec filter(DataProvider.t, Map.t, Keyword.t) :: DataProvider.t
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
end
