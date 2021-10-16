defmodule DataProvider.Pagination do
  @moduledoc ~S"""
  Pagination module provides struct with actual pagination data
  for current `DataProvider`

  ## Fields

    * `page` - Current page of this data provider, by default equal 1. This value is dynamic,
    and can be changed in runtime.

    * `params` - Pagination params. This field contain `DataProvider.Pagination.Params` struct
    and uses for configuring inner logic of `DataProvider.Pagination` and/or `DataProvider`

    * `pages` - List of values for fast move between pages. Every single page it is
    `DataProvider.Pagination.Page` struct and this list sensitive for specific params, which
    used in his creation. This field most useful when you need to render list of pages under
    data table. More details you can find in `DataProvider.Pagination.Params` and `DataProvider.Pagination.Params`.
  """


  alias DataProvider.Pagination.Page
  alias DataProvider.Pagination.Params

  @default_page 1

  defstruct page: @default_page,
            pages: [],
            params: %Params{}

  @typedoc ~S"""
  Schema of `DataProvider.Pagination`.

  Contains:

    * `page` - Current page of dataprovider.

    * `pages` - Pages which loaded for current pagination

    * `page_size` - count of items in one page of data provider.

  """
  @type t() :: %__MODULE__{
                 page: integer(),
                 pages: list(Page.t),
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

    1. `DataProvider.Pagination` struct

    2. Total count of items

  ## Returns

  Function returns `DataProvider.Pagination` which `:pages` field is fill

      %DataProvider.Pagination{
        ...
        pages: [
          ...
          %DataProvider.Pagination.Page{},
          %DataProvider.Pagination.Page{},
          %DataProvider.Pagination.Page{},
          ...
        ]
        ...
      }

  ## Options

  Options, that can affect result of this function

    `:pages_ahead` - The maximum count of pages, which will be loaded ahead of current position.

    `:pages_behind` - The maximum count of pages, which will be loaded behind of current position.

    `:load_first_page?` - Boolean value which indicates requirement of loading the first page in list.

    `:load_last_page?` - Boolean value which indicates requirement of loading the last page in list.

    `:load_opening_separator?` - Boolean value which indicates requirement of loading the separator page in list.

    `:load_closing_separator?` - Boolean value which indicates requirement of loading the separator page in list.

  """
  @spec create_page_list(DataProvider.Pagination.t, integer()) :: DataProvider.Pagination.t
  def create_page_list(pagination, total_count \\ 0)
  def create_page_list(%__MODULE__{params: %Params{page_size: page_size}, page: current_page} = pagination, 0)
      when is_integer(current_page) and current_page > 0 and page_size > 0, do: %{pagination | pages: []}
  def create_page_list(%__MODULE__{params: %Params{page_size: page_size}, page: current_page} = pagination, total_count)
      when is_integer(total_count) and is_integer(current_page) and current_page > 0 and page_size > 0 do
    page_count = total_count/page_size |> Float.ceil() |> trunc()
    pages = []
            |> put_first_page(pagination, page_count)
            |> put_opening_separator_page(pagination, page_count)
            |> put_regular_pages(pagination, page_count)
            |> put_closing_separator_page(pagination, page_count)
            |> put_last_page(pagination, page_count)

    %{pagination | pages: pages}
  end

  # ====================
  #  FIRST PAGE
  # ====================
  # Puts first page of page list
  defp put_first_page(page_list, %__MODULE__{page: page, params: %Params{load_first_page?: true} = params}, _)
       when is_list(page_list) and is_integer(page) do
    pages = if (page - params.pages_behind - 1 > 1),
               do: [%Page{type: :first, active: false, title: "1", number: 1}],
               else: []
    page_list ++ pages
  end
  defp put_first_page(page_list, %__MODULE__{params: %Params{load_first_page?: false}}, _)
       when is_list(page_list), do: page_list

  # ====================
  #  OPENING SEPARATOR
  # ====================
  # Puts first page of page list
  defp put_opening_separator_page(page_list, %__MODULE__{page: page, params: %Params{load_opening_separator?: true} = params}, _)
       when is_list(page_list) and is_integer(page) do
    pages = if (page - params.pages_behind > 1),
               do: [%Page{type: :separator, active: false, title: "...", number: 0}],
               else: []
    page_list ++ pages
  end
  defp put_opening_separator_page(page_list, %__MODULE__{params: %Params{load_opening_separator?: false}}, _)
       when is_list(page_list), do: page_list

  # ====================
  #  REGULAR PAGE
  # ====================
  # Puts first page of page list
  defp put_regular_pages(page_list, %__MODULE__{page: page, params: %Params{} = params}, page_count)
       when is_list(page_list) and is_integer(page_count) and is_integer(page) do
    pages = (page - params.pages_behind)..(page + params.pages_ahead)
            |> Enum.to_list()
            |> Enum.filter(&(&1 > 0 and &1 <= page_count))
            |> Enum.map(&(%Page{type: :regular, active: &1 === page, title: Integer.to_string(&1), number: &1}))

    page_list ++ pages
  end
  defp put_regular_pages(page_list, %__MODULE__{params: %Params{load_first_page?: false}}, _)
       when is_list(page_list), do: page_list

  # ====================
  #  CLOSING SEPARATOR
  # ====================
  # Puts first page of page list
  defp put_closing_separator_page(page_list, %__MODULE__{page: page, params: %Params{load_closing_separator?: true} = params}, page_count)
       when is_list(page_list) and is_integer(page_count) and is_integer(page) do
    pages = if (page + params.pages_ahead < page_count),
               do: [%Page{type: :separator, active: false, title: "...", number: 0}],
               else: []
    page_list ++ pages
  end
  defp put_closing_separator_page(page_list, %__MODULE__{params: %Params{load_closing_separator?: false}}, _)
       when is_list(page_list), do: page_list

  # ====================
  #  LAST PAGE
  # ====================
  # Puts first page of page list
  defp put_last_page(page_list, %__MODULE__{page: page, params: %Params{load_last_page?: true} = params}, page_count)
       when is_list(page_list) and is_integer(page_count) and is_integer(page) do
    pages = if (page + params.pages_ahead + 1 < page_count),
               do: [%Page{type: :last, active: false, title: Integer.to_string(page_count), number: page_count}],
               else: []
    page_list ++ pages
  end
  defp put_last_page(page_list, %__MODULE__{params: %Params{load_last_page?: false}}, _)
       when is_list(page_list), do: page_list
end
