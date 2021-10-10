defmodule DataProvider.Data.ListModifierTest do
  use ExUnit.Case
  alias DataProvider.Data.ListModifier
  doctest DataProvider.Data.ListModifier

  def fixture(:data_provider, _params), do: DataProvider.create()
  def fixture(:data_list, _params), do: Enum.to_list(1..1000)

  defp data_provider(params), do: {:ok, data_provider: fixture(:data_provider, params)}

  defp data_list(params), do: {:ok, data_list: fixture(:data_list, params)}

  defp load_state(data_provider, page_size, page),
       do: %{data_provider | pagination: %{data_provider.pagination | page_size: page_size, page: page}}

  setup [:data_provider, :data_list]

  describe "`modify/2` empty list |" do
    test "test result (page size: 0, page: 0)", %{data_provider: data_provider} do
      data_provider = load_state(data_provider, 0, 0)

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page size: 0, page: 1)", %{data_provider: data_provider} do
      data_provider = load_state(data_provider, 0, 1)

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page size: 0, page: 13)", %{data_provider: data_provider} do
      data_provider = load_state(data_provider, 0, 13)

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page size: 13, page: 0)", %{data_provider: data_provider} do
      data_provider = load_state(data_provider, 13, 0)

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page size: 13, page: 1)", %{data_provider: data_provider} do
      data_provider = load_state(data_provider, 13, 1)

      assert ListModifier.modify([], data_provider) === []
    end

    test "test result (page size: 13, page: 13)", %{data_provider: data_provider} do
      data_provider = load_state(data_provider, 13, 13)

      assert ListModifier.modify([], data_provider) === []
    end
  end

  describe "`modify/2` filled list |" do
    test "test result (page size: 0, page: 0)", %{data_list: data_list, data_provider: data_provider} do
      data_provider = load_state(data_provider, 0, 0)

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page size: 0, page: 1)", %{data_list: data_list, data_provider: data_provider} do
      data_provider = load_state(data_provider, 0, 1)

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page size: 0, page: 13)", %{data_list: data_list, data_provider: data_provider} do
      data_provider = load_state(data_provider, 0, 13)

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page size: 13, page: 0)", %{data_list: data_list, data_provider: data_provider} do
      data_provider = load_state(data_provider, 13, 0)

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page size: 1, page: 0)", %{data_list: data_list, data_provider: data_provider} do
      data_provider = load_state(data_provider, 1, 0)

      assert ListModifier.modify(data_list, data_provider) === []
    end

    test "test result (page size: 13, page: 13)", %{data_list: data_list, data_provider: data_provider} do
      data_provider = load_state(data_provider, 13, 13)

      assert ListModifier.modify(data_list, data_provider) === Enum.to_list(157..169)
    end
  end
end
