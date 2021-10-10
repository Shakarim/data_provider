defmodule DataProvider.Data.ListModifier do
  @moduledoc false

  alias DataProvider.Pagination

  @spec modify(List.t, DataProvider.t) :: List.t
  def modify(items_list, %DataProvider{pagination: %Pagination{} = pagination}) when is_list(items_list) do
    start_offset = Pagination.start_position(pagination)
    limit_index = Pagination.end_position(pagination)

    slice(items_list, start_offset, limit_index)
  end

  # Slices list by start and end position
  @spec slice(List.t, Integer.t, Integer.t) :: List.t
  defp slice(items_list, s_pos, e_pos) when is_integer(s_pos) and is_integer(e_pos) and e_pos > 0,
       do: Enum.slice(items_list, s_pos..e_pos)
  defp slice(_items_list, s_pos, e_pos) when is_integer(s_pos) and is_integer(e_pos), do: []
end