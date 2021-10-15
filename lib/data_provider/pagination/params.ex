defmodule DataProvider.Pagination.Params do
  @moduledoc ~S"""
  Params module for `DataProvider.Pagination`
  """

  @default_page_size 15
  @default_pages_ahead 3
  @default_pages_behind 3
  @default_load_first_page? true
  @default_load_last_page? true
  @default_load_opening_separator? true
  @default_load_closing_separator? true

  defstruct page_size: @default_page_size,
            pages_ahead: @default_pages_ahead,
            pages_behind: @default_pages_behind,
            load_first_page?: @default_load_first_page?,
            load_last_page?: @default_load_last_page?,
            load_opening_separator?: @default_load_opening_separator?,
            load_closing_separator?: @default_load_closing_separator?

  @type t() :: %__MODULE__{
                 page_size: integer(),
                 pages_ahead: integer(),
                 pages_behind: integer(),
                 load_first_page?: boolean(),
                 load_last_page?: boolean(),
                 load_opening_separator?: boolean(),
                 load_closing_separator?: boolean(),
               }

  @doc ~S"""
  Creates new `DataProvider.Paginations.Params` struct by received map

  ## Arguments

    1. Map with creation params

  ## Returns

      %DataProvider.Paginations.Params{
        page_size: 15,
        pages_ahead: 3,
        pages_behind: 3,
        load_first_page?: true,
        load_last_page?: true,
        load_opening_separator?: true,
        load_closing_separator?: true
      }

  """
  @spec create(map()) :: __MODULE__.t()
  def create(params \\ %{})
  def create(params) when is_map(params) do
    %__MODULE__{}
    |> put_page_size(Map.get(params, :page_size, @default_page_size))
    |> put_pages_ahead(Map.get(params, :pages_ahead, @default_pages_ahead))
    |> put_pages_behind(Map.get(params, :pages_behind, @default_pages_behind))
    |> put_load_first_page?(Map.get(params, :load_first_page?, @default_load_first_page?))
    |> put_load_last_page?(Map.get(params, :load_last_page?, @default_load_last_page?))
    |> put_load_opening_separator?(Map.get(params, :load_opening_separator?, @default_load_opening_separator?))
    |> put_load_closing_separator?(Map.get(params, :load_closing_separator?, @default_load_closing_separator?))
  end

  @doc ~S"""
  Returns `page_size` value, if it's integer

  ## Arguments

    1. `DataProvider.Paginations.Params` struct

  """
  @spec page_size(__MODULE__.t) :: integer()
  def page_size(%__MODULE__{page_size: result}) when is_integer(result), do: result


  # Puts new page size value for received `DataProvider.Paginations.Params`
  @spec put_page_size(__MODULE__.t, integer()) :: __MODULE__.t
  defp put_page_size(%__MODULE__{} = schema, size) when is_integer(size), do: %{schema | page_size: size}

  # Puts new value for `:pages_ahead` field
  @spec put_pages_ahead(__MODULE__.t(), integer()) :: __MODULE__.t()
  def put_pages_ahead(%__MODULE__{} = schema, q) when is_integer(q), do: %{schema | pages_ahead: q}

  # Puts new value for `:pages_behind` field
  @spec put_pages_behind(__MODULE__.t(), integer()) :: __MODULE__.t()
  def put_pages_behind(%__MODULE__{} = schema, q) when is_integer(q), do: %{schema | pages_behind: q}

  # Puts new value for `:load_first_page?` field
  @spec put_load_first_page?(__MODULE__.t(), boolean()) :: __MODULE__.t()
  def put_load_first_page?(%__MODULE__{} = schema, q) when is_boolean(q), do: %{schema | load_first_page?: q}

  # Puts new value for `:load_last_page?` field
  @spec put_load_last_page?(__MODULE__.t(), boolean()) :: __MODULE__.t()
  def put_load_last_page?(%__MODULE__{} = schema, q) when is_boolean(q), do: %{schema | load_last_page?: q}

  # Puts new value for `:load_opening_separator?` field
  @spec put_load_opening_separator?(__MODULE__.t(), boolean()) :: __MODULE__.t()
  def put_load_opening_separator?(%__MODULE__{} = schema, q) when is_boolean(q), do: %{schema | load_opening_separator?: q}

  # Puts new value for `:load_closing_separator?` field
  @spec put_load_closing_separator?(__MODULE__.t(), boolean()) :: __MODULE__.t()
  def put_load_closing_separator?(%__MODULE__{} = schema, q) when is_boolean(q), do: %{schema | load_closing_separator?: q}
end
