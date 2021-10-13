defmodule DataProvider.Pagination do
  @moduledoc ~S"""
  Module, which implements business logic of separation data by
  pages in `DataProvider`.
  """

  @default_page 1
  @default_page_size 15

  defstruct page: @default_page,
            page_size: @default_page_size

  @typedoc ~S"""
  Schema of `DataProvider.Pagination`.

  Contains:

    * `page` - Current page of dataprovider.

    * `page_size` - count of items in one page of data provider.

  """
  @type t() :: %__MODULE__{
                 page: integer(),
                 page_size: integer()
               }

  @doc ~S"""
  Creates new `DataProvider.Pagination` struct with received params.

  By default, fields will be:

    * `page` - @default_page

    * `page_size` - @default_page_size

  """
  @spec create(map()) :: __MODULE__.t
  def create(params \\ %{})
  def create(params) when is_map(params) do
    %__MODULE__{}
    |> put_page(Map.get(params, :page, @default_page))
    |> put_page_size(Map.get(params, :page_size, @default_page_size))
  end

  @doc ~S"""
  Returns current page value of `DataProvider` by `DataProvider.Pagination`
  """
  @spec page(__MODULE__.t) :: integer()
  def page(%__MODULE__{page: page}) when is_integer(page), do: page

  @doc ~S"""
  Returns size of page in current `DataProvider.Pagination` of `DataProvider`
  """
  @spec page_size(__MODULE__.t) :: integer()
  def page_size(%__MODULE__{page_size: page_size}) when is_integer(page_size), do: page_size

  @doc ~S"""
  Changes the value of field `page`
  """
  @spec put_page(__MODULE__.t, integer()) :: __MODULE__.t
  def put_page(%__MODULE__{} = pagination, page) when is_integer(page),
      do: %{pagination | page: page}

  @doc ~S"""
  Changes the value of field `page_size`
  """
  @spec put_page_size(__MODULE__.t, integer()) :: __MODULE__.t
  def put_page_size(%__MODULE__{} = pagination, page_size) when is_integer(page_size),
      do: %{pagination | page_size: page_size}

  @doc ~S"""
  Calculates starting position for received pagination.

  Requires for calculating start position in list of data or offset in query condition
  """
  @spec start_position(__MODULE__.t) :: integer()
  def start_position(%__MODULE__{} = pagination) do
    with current_page when current_page >= 1 <- page(pagination),
         page_size when page_size >= 1 <- selection_limit(pagination)
      do
      (current_page - 1) * page_size
    else
      _ -> 0
    end
  end

  @doc """
  Returns count of items, which gonna be put load into `DataProvider.Data`
  """
  @spec selection_limit(__MODULE__.t) :: integer()
  def selection_limit(%__MODULE__{} = pagination), do: page_size(pagination)

  @doc ~S"""
  Calculates end position for received pagination.

  Requires for calculating selection limit in list of data.
  """
  @spec end_position(__MODULE__.t) :: integer()
  def end_position(%__MODULE__{} = pagination) do
    with current_page when current_page >= 1 <- page(pagination),
         page_size when page_size >= 1 <- selection_limit(pagination)
      do
      (current_page * page_size) - 1
    else
      _ -> 0
    end
  end
end
