defmodule DataProvider.SearchOptions do
  @moduledoc ~S"""
  Module with searching params in `DataProvider`
  """

  defstruct options: %{}

  @typedoc ~S"""
  Search options

  ## Fields

    * `options` - Map with data searching options for
    `DataProvider`

  """
  @type t() :: %__MODULE__{options: map()}

  @doc ~S"""
  Creates new `DataProvider.SearchOptions` with received params
  """
  @spec create(map()) :: __MODULE__.t()
  def create(params \\ %{})
  def create(params), do: put_options(%__MODULE__{}, params)

  @doc ~S"""
  Merges `options` value of received `DataProvider.SearchOptions` with `params`
  in second argument.

  ## Args

    * `search_options` - `DataProvider.SearchOptions` which options need to merge

    * `param` - Map with new for merging

  """
  @spec merge_options(__MODULE__.t, map()) :: __MODULE__.t
  def merge_options(%__MODULE__{options: options} = current_options, params) when is_map(options) and is_map(params),
      do: %{current_options | options: Map.merge(options, params)}

  @doc ~S"""
  Replaces `options` in `DataProvider.SearchOptions` by received `params` map.

  ## Args

    * `search_options` - `DataProvider.SearchOptions` which options need to replace

    * `param` - Map with new for replacing

  """
  @spec put_options(__MODULE__.t, map()) :: __MODULE__.t
  def put_options(%__MODULE__{} = current_options, params) when is_map(params), do: %{current_options | options: params}
end
