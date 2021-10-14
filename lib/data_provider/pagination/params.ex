defmodule DataProvider.Pagination.Params do
  @moduledoc ~S"""
  Params module for `DataProvider.Pagination`
  """

  @default_page_size 15

  defstruct page_size: @default_page_size

  @type t() :: %__MODULE__{
                 page_size: integer()
               }

  def create(params \\ %{})
  def create(params) when is_map(params) do
    %__MODULE__{}
    |> put_page_size(Map.get(params, :page_size, @default_page_size))
  end

  @spec page_size(__MODULE__.t) :: integer()
  def page_size(%__MODULE__{page_size: result}) when is_integer(result), do: result


  @spec put_page_size(__MODULE__.t, integer()) :: __MODULE__.t
  defp put_page_size(%__MODULE__{} = schema, size) when is_integer(size), do: %{schema | page_size: size}
end
