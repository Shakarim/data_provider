defmodule DataProvider.Data do
  @moduledoc ~S"""
  The data module of `DataProvider` which result of `DataProvider` processing

  In this struct:

    * `items` - it is a list of result user request
  """

  alias __MODULE__.QueryModifier
  alias __MODULE__.ListModifier
  alias Ecto.Query

  defstruct items: [],
            total_count: 0

  @typedoc ~S"""
  DataProvider data value, contains:

    * `items` - List of found data for exactly this `DataProvider`

    * `total_count` - integer value with count of items in `items`

  """
  @type t() :: %__MODULE__{items: list(), total_count: integer()}

  @doc ~S"""
  Creates `DataProvider.Data` struct by received `find_result` and `DataProvider`.

  Args:

    * `data_provider` - data provider, which been use by user for getting
    `find_result`

    * `find_result` - value, which been returned by `find/1` function of
    user's `DataProvider` implementation

  Function will execute behaviour depending on what value was in `find_result`

    1. If received `find_result` is a `Ecto.Query` then it will be processed
    by `DataProvider.QueryModifier`. The reveived query will be executed and
    result of execution gonna be put into `items` of new `DataProvider.Data`
    struct.

    2. If received `find_result` is a `list()`, then it will be processed by
    `DataProvider.ListModifier`. The received data will be put into `items`
    of new `DataProvider.Data` struct.

  """
  @spec create(DataProvider.t, Query.t | list()) :: __MODULE__.t
  def create(%DataProvider{module: module} = data_provider, %Query{} = find_result) do
    query = QueryModifier.modify(find_result, data_provider)
    query_all(module, query)
  end
  def create(%DataProvider{} = data_provider, find_result) when is_list(find_result) do
    ListModifier.modify(find_result, data_provider)
    |> new()
    |> total_count()
  end


  # Init getting data from `Repo` implementation
  defp query_all(module, query) do
    module
    |> apply(:repo, [])
    |> init_query(query)
  end

  # Initiate query executing by received repo and query
  @spec init_query(any(), Query.t) :: __MODULE__.t
  defp init_query(repo, query) do
    try do
      repo.__info__(:functions)
    rescue
      _ -> []
    end
    |> Keyword.has_key?(:all)
    |> query_by_exist(repo, query)
  end

  # Calls `Repo.all/2` if first argument is true, otherwise raise `DataProvider.RepoCallError`
  @spec query_by_exist(Boolean.t, any(), Query.t) :: __MODULE__.t
  defp query_by_exist(true, repo, query) do
    apply(repo, :all, [query])
    |> new()
    |> total_count()
  end
  defp query_by_exist(false, repo, _) do
    message = "error of calling `Repo.all/2`, make sure that your `#{repo}` module is correct `Ecto.Repo` implementation"
    raise(DataProvider.RepoCallError, message: message)
  end

  # Generates `DataProvider.Data` with received `items` list
  @spec new(list()) :: DataProvider.Data.t
  defp new(items) when is_list(items), do: %__MODULE__{items: items}

  # Calculate and set `total_count` for received `DataProvider.Data`
  @spec total_count(__MODULE__.t) :: __MODULE__.t
  defp total_count(%__MODULE__{items: items} = data), do: %{data | total_count: Enum.count(items)}
end
