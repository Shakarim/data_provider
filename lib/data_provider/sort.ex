defmodule DataProvider.Sort do
  @moduledoc ~S"""
  Module with sorting params for `DataProvider`
  """

  defstruct options: []

  @typedoc ~S"""
  Sort options

  ## Fields

    * `options` - Keyword with data searching options for `DataProvider`

  """
  @type t() :: %__MODULE__{options: Map.t()}

  @doc ~S"""
  Creates new `DataProvider.Sort` with received params
  """
  @spec create(Keyword.t) :: __MODULE__.t
  def create(options \\ [])
  def create(options), do: %__MODULE__{options: options}

  @doc ~S"""
  Merges `options` value of received `DataProvider.Sort` with `params` in
  second argument.

  ## Args

    * `sort` - `DataProvider.Sort` which need to merge

    * `param` - Keyword with new for merging

  """
  @spec merge_options(__MODULE__.t, Keyword.t) :: __MODULE__.t
  def merge_options(%__MODULE__{options: options} = sort, params), do: %{sort | options: options ++ params}

  @doc ~S"""
  Replaces `options` in `DataProvider.Sort` by received `params` map.

  ## Args

    * `sort` - `DataProvider.Sort` which need to replace

    * `param` - Keyword with new options for replacing

  """
  @spec put_options(__MODULE__.t, Keyword.t) :: __MODULE__.t
  def put_options(%__MODULE__{} = sort, params), do: %{sort | options: params}
end
