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
    repo = apply(module, :repo, [])
    query = QueryModifier.modify(find_result, data_provider)

    %__MODULE__{}
    |> load_items(repo, query)
    |> load_total_count(repo, find_result)
  end
  def create(%DataProvider{} = data_provider, find_result) when is_list(find_result) do
    %__MODULE__{
      items: ListModifier.modify(find_result, data_provider),
      total_count: Enum.count(find_result)
    }
  end

  # load `:items` into received `DataProvider.Data`
  @spec load_items(__MODULE__.t, any(), Query.t) :: __MODULE__.t
  defp load_items(%__MODULE__{} = data, repo, %Query{} = query) do
    try do
      repo.__info__(:functions)
    rescue
      _ -> []
    end
    |> Keyword.has_key?(:all)
    |> case do
         true -> %{data | items: apply(repo, :all, [query])}
         false ->
           message = "error of calling `Repo.all/2`, make sure that your `#{repo}` module is correct `Ecto.Repo` implementation"
           raise(DataProvider.RepoCallError, message: message)
       end
  end

  # load `:total_count` into received `DataProvider.Data`
  @spec load_total_count(__MODULE__.t, any(), Query.t) :: __MODULE__.t
  defp load_total_count(%__MODULE__{} = data, repo, %Query{} = query) do
    try do
      repo.__info__(:functions)
    rescue
      _ -> []
    end
    |> Keyword.has_key?(:aggregate)
    |> case do
         true -> %{data | total_count: apply(repo, :aggregate, [query, :count])}
         false ->
           message = "error of calling `Repo.aggregate/2`, make sure that your `#{repo}` module is correct `Ecto.Repo` implementation"
           raise(DataProvider.RepoCallError, message: message)
       end
  end
end
