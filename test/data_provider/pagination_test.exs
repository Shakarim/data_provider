defmodule DataProvider.PaginationTest do
  use ExUnit.Case
  alias DataProvider.Pagination
  doctest DataProvider.Pagination

  def fixture(:pagination, _params), do: Pagination.create()

  defp pagination(params), do: {:ok, pagination: fixture(:pagination, params)}

  defp load_state(pagination, page_size, page), do: %{pagination | page_size: page_size, page: page}

  setup [:pagination]

  describe "`create/1` |" do
    test "test valid attrs" do
      pagination = Pagination.create(%{page: 5, page_size: 100})

      assert match?(%Pagination{}, pagination)
      assert pagination.page === 5
      assert pagination.page_size === 100
    end

    test "test default attrs" do
      pagination = Pagination.create(%{})

      assert match?(%Pagination{}, pagination)
      assert is_integer(pagination.page)
      assert is_integer(pagination.page_size)
    end
  end

  describe "`start_position/1` |" do
    test "test result (page size: 0, page: 0)", %{pagination: pagination} do
      pagination = load_state(pagination, 0, 0)

      assert Pagination.start_position(pagination) === 0
    end

    test "test result (page size: 0, page: 1)", %{pagination: pagination} do
      pagination = load_state(pagination, 0, 1)

      assert Pagination.start_position(pagination) === 0
    end

    test "test result (page size: 0, page: 13)", %{pagination: pagination} do
      pagination = load_state(pagination, 0, 13)

      assert Pagination.start_position(pagination) === 0
    end

    test "test result (page size: 13, page: 0)", %{pagination: pagination} do
      pagination = load_state(pagination, 13, 0)

      assert Pagination.start_position(pagination) === 0
    end

    test "test result (page size: 13, page: 1)", %{pagination: pagination} do
      pagination = load_state(pagination, 13, 1)

      assert Pagination.start_position(pagination) === 0
    end

    test "test result (page size: 13, page: 13)", %{pagination: pagination} do
      pagination = load_state(pagination, 13, 13)

      assert Pagination.start_position(pagination) === (13 - 1) * 13
    end
  end

  describe "`end_position/1` |" do
    test "test result (page size: 0, page: 0)", %{pagination: pagination} do
      pagination = load_state(pagination, 0, 0)

      assert Pagination.end_position(pagination) === 0
    end

    test "test result (page size: 0, page: 1)", %{pagination: pagination} do
      pagination = load_state(pagination, 0, 1)

      assert Pagination.end_position(pagination) === 0
    end

    test "test result (page size: 0, page: 13)", %{pagination: pagination} do
      pagination = load_state(pagination, 0, 13)

      assert Pagination.end_position(pagination) === 0
    end

    test "test result (page size: 13, page: 0)", %{pagination: pagination} do
      pagination = load_state(pagination, 13, 0)

      assert Pagination.end_position(pagination) === 0
    end

    test "test result (page size: 13, page: 1)", %{pagination: pagination} do
      pagination = load_state(pagination, 13, 1)

      assert Pagination.end_position(pagination) === (13 * 1) - 1
    end

    test "test result (page size: 13, page: 13)", %{pagination: pagination} do
      pagination = load_state(pagination, 13, 13)

      assert Pagination.end_position(pagination) === (13 * 13) - 1
    end
  end

  test "`selection_limit/1` |", %{pagination: pagination} do
    result = Pagination.selection_limit(pagination)

    assert is_integer(result)
  end

  test "`page/1` |", %{pagination: pagination} do
    result = Pagination.page(pagination)

    assert is_integer(result)
  end

  test "`page_size/1` |", %{pagination: pagination} do
    result = Pagination.page_size(pagination)

    assert is_integer(result)
  end

  test "`put_page/1` |", %{pagination: pagination} do
    result = Pagination.put_page(pagination, 10)

    assert result.page !== pagination.page
    assert result.page === 10
  end

  test "`put_page_size/1` |", %{pagination: pagination} do
    result = Pagination.put_page_size(pagination, 100)

    assert result.page_size !== pagination.page_size
    assert result.page_size === 100
  end
end
