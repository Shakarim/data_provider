defmodule DataProvider.Data.ListModifierTest do
  use ExUnit.Case
  alias DataProvider.Data.ListModifier
  doctest DataProvider.Data.ListModifier

  def fixture(:data_list, _params), do: Enum.to_list(1..1000)

  defp data_list(params), do: {:ok, data_list: fixture(:data_list, params)}

  setup [:data_list]

  describe "`modify/2` empty list |" do
    test "test result (page: 0, page size: 0)" do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 0,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page: 1, page size: 0)" do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 1,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page: 13, page size: 0)" do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 13,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page: 0, page size: 13)" do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 0,
          params: %DataProvider.Pagination.Params{page_size: 13}
        }
      }

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page: 1, page size: 13)" do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 1,
          params: %DataProvider.Pagination.Params{page_size: 13}
        }
      }

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page: 13, page size: 13)" do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 13,
          params: %DataProvider.Pagination.Params{page_size: 13}
        }
      }

      assert ListModifier.modify([], data_provider) === []
    end
  end

  describe "`modify/2` filled list |" do
    test "test result (page: 0, page size: 0)", %{data_list: data_list} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 0,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page: 1, page size: 0)", %{data_list: data_list} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 1,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page: 13, page size: 0)", %{data_list: data_list} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 13,
          params: %DataProvider.Pagination.Params{page_size: 0}
        }
      }

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page: 0, page size: 13)", %{data_list: data_list} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 0,
          params: %DataProvider.Pagination.Params{page_size: 13}
        }
      }

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page: 0, page size: 1)", %{data_list: data_list} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 0,
          params: %DataProvider.Pagination.Params{page_size: 1}
        }
      }

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page: 13, page size: 13)", %{data_list: data_list} do
      data_provider = %DataProvider{
        pagination: %DataProvider.Pagination{
          page: 13,
          params: %DataProvider.Pagination.Params{page_size: 13}
        }
      }

      assert ListModifier.modify(data_list, data_provider) === Enum.to_list(157..169)
    end
  end
end
