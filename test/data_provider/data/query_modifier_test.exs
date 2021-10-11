defmodule DataProvider.Data.QueryModifierTest do
  use ExUnit.Case
  use DataProvider.DataCase
  alias DataProvider.TestSchema
  alias DataProvider.Data.QueryModifier
  import Ecto.Query

  def fixture(:data_provider, _params), do: DataProvider.create()
  def fixture(:query, _params), do: from(t in TestSchema)


  defp data_provider(params), do: {:ok, data_provider: fixture(:data_provider, params)}

  defp query(params), do: {:ok, query: fixture(:query, params)}

  defp get_sort_limit_expr(%Ecto.Query{} = query, param) do
    query
    |> Map.get(param)
    |> Map.get(:params)
    |> List.first()
    |> elem(0)
  end

  defp set_pagination_state(data_provider, page_size, page) do
    pagination = %{data_provider.pagination | page_size: page_size, page: page}
    %{data_provider | pagination: pagination}
  end

  defp set_sorting_state(data_provider, params), do: %{data_provider | sort: %{data_provider.sort | options: params}}

  setup [:data_provider, :query]

  describe "`modify/2` |" do
    test "test offset and limit (page size: 0, page: 0)", %{query: query, data_provider: data_provider} do
      data_provider = set_pagination_state(data_provider, 0, 0)
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page size: 0, page: 1)", %{query: query, data_provider: data_provider} do
      data_provider = set_pagination_state(data_provider, 0, 1)
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page size: 0, page: 13)", %{query: query, data_provider: data_provider} do
      data_provider = set_pagination_state(data_provider, 0, 13)
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page size: 13, page: 0)", %{query: query, data_provider: data_provider} do
      data_provider = set_pagination_state(data_provider, 13, 0)
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page size: 1, page: 0)", %{query: query, data_provider: data_provider} do
      data_provider = set_pagination_state(data_provider, 1, 0)
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page size: 13, page: 13)", %{query: query, data_provider: data_provider} do
      data_provider = set_pagination_state(data_provider, 13, 13)
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === 13
      assert get_sort_limit_expr(new_query, :offset) === (13 - 1) * 13
    end

    test "test order expression", %{query: query, data_provider: data_provider} do
      data_provider = set_sorting_state(data_provider, desc: :inserted_at)
      new_query = QueryModifier.modify(query, data_provider)

      assert new_query.order_bys |> Enum.count() > 0
    end
  end
end
