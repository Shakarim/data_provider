defmodule DataProvider.PaginationTest do
  use ExUnit.Case
  alias DataProvider.Pagination
  doctest DataProvider.Pagination

  describe "`create/1` |" do
    test "test valid attrs" do
      result = Pagination.create(%{page: 5, params: %{page_size: 100}})

      assert result === %Pagination{page: 5, params: %Pagination.Params{page_size: 100}}
    end

    test "test default attrs" do
      result = Pagination.create(%{})

      assert result === %Pagination{page: 1, params: %Pagination.Params{page_size: 15}}
    end
  end

  test "`page/1` |" do
    pagination = %Pagination{page: 5}
    result = Pagination.page(pagination)

    assert result === 5
  end

  test "`put_page/1` |" do
    pagination = %Pagination{page: 5, params: %Pagination.Params{page_size: 100}}
    result = Pagination.put_page(pagination, 10)

    assert pagination.page === 5
    assert result.page === 10
  end

  test "`put_params/2 |" do
    pagination = %Pagination{}
    result = Pagination.put_params(pagination, %{page_size: 100})

    assert result === %Pagination{page: 1, params: %Pagination.Params{page_size: 100}}
  end

  describe "`start_position/1` |" do
    test "test result (page: 0, page size: 0)" do
      pagination = %Pagination{page: 0, params: %Pagination.Params{page_size: 0}}
      result = Pagination.start_position(pagination)

      assert result === 0
    end

    test "test result (page: 1, page size: 0)" do
      pagination = %Pagination{page: 1, params: %Pagination.Params{page_size: 0}}
      result = Pagination.start_position(pagination)

      assert result === 0
    end

    test "test result (page: 13, page size: 0)" do
      pagination = %Pagination{page: 13, params: %Pagination.Params{page_size: 0}}
      result = Pagination.start_position(pagination)

      assert result === 0
    end

    test "test result (page: 0, page size: 13)" do
      pagination = %Pagination{page: 0, params: %Pagination.Params{page_size: 13}}
      result = Pagination.start_position(pagination)

      assert result === 0
    end

    test "test result (page: 1, page size: 13)" do
      pagination = %Pagination{page: 1, params: %Pagination.Params{page_size: 13}}
      result = Pagination.start_position(pagination)

      assert result === 0
    end

    test "test result (page: 13, page size: 13)" do
      pagination = %Pagination{page: 13, params: %Pagination.Params{page_size: 13}}
      result = Pagination.start_position(pagination)

      assert result === (13 - 1) * 13
    end
  end

  test "`selection_limit/1` |" do
    pagination = %Pagination{page: 0, params: %Pagination.Params{page_size: 25}}
    result = Pagination.selection_limit(pagination)

    assert result === 25
  end

  describe "`end_position/1` |" do
    test "test result (page: 0, page size: 0)" do
      pagination = %Pagination{page: 0, params: %Pagination.Params{page_size: 0}}
      result = Pagination.end_position(pagination)

      assert result === 0
    end

    test "test result (page: 1, page size: 0)" do
      pagination = %Pagination{page: 1, params: %Pagination.Params{page_size: 0}}
      result = Pagination.end_position(pagination)

      assert result === 0
    end

    test "test result (page: 13, page size: 0)" do
      pagination = %Pagination{page: 13, params: %Pagination.Params{page_size: 0}}
      result = Pagination.end_position(pagination)

      assert result === 0
    end

    test "test result (page: 0, page size: 13)" do
      pagination = %Pagination{page: 0, params: %Pagination.Params{page_size: 13}}
      result = Pagination.end_position(pagination)

      assert result === 0
    end

    test "test result (page: 1, page size: 13)" do
      pagination = %Pagination{page: 1, params: %Pagination.Params{page_size: 13}}
      result = Pagination.end_position(pagination)

      assert result === (13 * 1) - 1
    end

    test "test result (page: 13, page size: 13)" do
      pagination = %Pagination{page: 13, params: %Pagination.Params{page_size: 13}}
      result = Pagination.end_position(pagination)

      assert result === (13 * 13) - 1
    end
  end
end
