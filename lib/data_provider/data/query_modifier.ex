defmodule DataProvider.Data.QueryModifier do
  @moduledoc false
  # Query modificator for `DataProvider.Data`.
  #
  # Needs `DataProvider.Data` for changing the `Ecto.Query`

  alias Ecto.Query
  alias DataProvider.Pagination
  alias DataProvider.Pagination.Params
  alias DataProvider.Sort
  import Query

  @doc false
  # Modify received `Ecto.Query` by `DataProvider` in second argument
  @spec modify(Query.t, DataProvider.t) :: Query.t
  def modify(%Query{} = query, %DataProvider{} = data_provider) do
    query
    |> set_limit(data_provider)
    |> set_offset(data_provider)
    |> set_sorting(data_provider)
  end


  # Set limit for query
  @spec set_limit(Query.t, DataProvider.t) :: Query.t
  defp set_limit(%Query{} = query, %DataProvider{pagination: %Pagination{} = pagination}) do
    page_size = Pagination.selection_limit(pagination)
    limit(query, ^page_size)
  end

  # Set offset for query
  @spec set_offset(Query.t, DataProvider.t) :: Query.t
  defp set_offset(%Query{} = query, %DataProvider{pagination: %Pagination{} = pagination}) do
    offset = Pagination.start_position(pagination)
    offset(query, ^offset)
  end

  # Set order params for request
  @spec set_sorting(Query.t, DataProvider.t) :: Query.t
  defp set_sorting(%Query{} = query, %DataProvider{sort: %Sort{options: sorting_options}}) when sorting_options !== [],
       do: order_by(query, ^sorting_options)
  defp set_sorting(%Query{} = query, %DataProvider{}), do: query
end
