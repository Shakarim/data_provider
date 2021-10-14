defmodule DataProvider.Pagination do
  @moduledoc ~S"""
  Module, which implements business logic of separation data by
  pages in `DataProvider`.
  """

  alias DataProvider.Pagination.Page
  alias DataProvider.Pagination.Params

  @default_page 1

  defstruct page: @default_page,
            params: %Params{}

  @typedoc ~S"""
  Schema of `DataProvider.Pagination`.

  Contains:

    * `page` - Current page of dataprovider.

    * `page_size` - count of items in one page of data provider.

  """
  @type t() :: %__MODULE__{
                 page: integer(),
                 params: Params.t
               }

  @doc ~S"""
  Creates new `DataProvider.Pagination` struct with received params.
  """
  @spec create(map()) :: __MODULE__.t
  def create(params \\ %{})
  def create(params) when is_map(params) do
    %__MODULE__{}
    |> put_page(Map.get(params, :page, @default_page))
    |> put_params(Map.get(params, :params, %{}))
  end

  @doc ~S"""
  Returns current page value of `DataProvider` by `DataProvider.Pagination`
  """
  @spec page(__MODULE__.t) :: integer()
  def page(%__MODULE__{page: page}) when is_integer(page), do: page

  @doc ~S"""
  Changes the value of field `page`
  """
  @spec put_page(__MODULE__.t, integer()) :: __MODULE__.t
  def put_page(%__MODULE__{} = pagination, page) when is_integer(page), do: %{pagination | page: page}

  @doc ~S"""
  Changes the value of field `page_size`
  """
  @spec put_params(__MODULE__.t, map()) :: __MODULE__.t
  def put_params(%__MODULE__{} = schema, params) when is_map(params), do: %{schema | params: Params.create(params)}

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
  def selection_limit(%__MODULE__{params: %Params{} = params}), do: Params.page_size(params)

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

  @doc ~S"""
  Creates list of `DataProvider.Pagination.Page` by received total count and current page.

  ## Arguments

    1. Total count of items

    2. Current page number

    3. Options keyword

  ## Returns

      [
        ...
        %DataProvider.Pagination.Page{},
        %DataProvider.Pagination.Page{},
        %DataProvider.Pagination.Page{},
        ...
      ]

  ## Options

    `:pages_ahead` - The maximum count of pages, which will be loaded ahead of current position.

    `:pages_behind` - The maximum count of pages, which will be loaded behind of current position.

    `:load_first_page?` - Boolean value which indicates requirement of loading the first page in list.

    `:load_last_page?` - Boolean value which indicates requirement of loading the last page in list.

  """
  def create_page_list(total_count, current_page, opts \\ []) when is_integer(total_count) and is_integer(current_page) do

  end
end
