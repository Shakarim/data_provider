defmodule DataProvider.Data.QueryModifierTest do
  use ExUnit.Case
  use DataProvider.DataCase
  alias DataProvider.TestSchema
  alias DataProvider.Data.QueryModifier
  import Ecto.Query

  def fixture(:query, _params), do: from(t in TestSchema)


  defp query(params), do: {:ok, query: fixture(:query, params)}

  defp get_sort_limit_expr(%Ecto.Query{} = query, param) do
    query
    |> Map.get(param)
    |> Map.get(:params)
    |> List.first()
    |> elem(0)
  end

  setup [:query]

  describe "`modify/2` |" do
    test "test offset and limit (page: 0, page size: 0)", %{query: query} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 0,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.params.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page: 1, page size: 0)", %{query: query} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 1,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.params.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page: 13, page size: 0)", %{query: query} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 13,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.params.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page: 0, page size: 13)", %{query: query} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 0,
          params: %DataProvider.Pagination.Params{page_size: 13}
        }
      }
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.params.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page: 0, page size: 1)", %{query: query} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 0,
          params: %DataProvider.Pagination.Params{page_size: 1}
        }
      }
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === data_provider.pagination.params.page_size
      assert get_sort_limit_expr(new_query, :offset) === 0
    end

    test "test offset and limit (page: 13, page size: 13)", %{query: query} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 13,
          params: %DataProvider.Pagination.Params{page_size: 13}
        }
      }
      new_query = QueryModifier.modify(query, data_provider)

      assert get_sort_limit_expr(new_query, :limit) === 13
      assert get_sort_limit_expr(new_query, :offset) === (13 - 1) * 13
    end

    test "test order expression", %{query: query} do
      data_provider = %DataProvider{sort: %DataProvider.Sort{options: [desc: :inserted_at]}}
      new_query = QueryModifier.modify(query, data_provider)

      assert new_query.order_bys |> Enum.count() > 0
    end
  end
end
