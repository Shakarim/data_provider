defmodule DataProvider.PaginationTest do
  use ExUnit.Case
  alias DataProvider.Pagination
  alias DataProvider.Pagination.Params
  alias DataProvider.Pagination.Page
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

  describe "`create_page_list/3` for empty result |" do
    test "test count: 0, page: 0" do
      assert_raise FunctionClauseError, fn ->
        Pagination.create_page_list(%Pagination{
          page: 0,
          pages: [],
          params: %Params{
            page_size: 15,
            pages_ahead: 3,
            pages_behind: 3,
            load_first_page?: true,
            load_last_page?: true,
            load_opening_separator?: true,
            load_closing_separator?: true
          }
        }, 0)
      end
    end

    test "test count: 0, page: 1" do
      result = Pagination.create_page_list(%Pagination{
        page: 1,
        pages: [],
        params: %Params{
          page_size: 15,
          pages_ahead: 3,
          pages_behind: 3,
          load_first_page?: true,
          load_last_page?: true,
          load_opening_separator?: true,
          load_closing_separator?: true
        }
      }, 0)

      assert result === %Pagination{
               page: 1,
               pages: [],
               params: %Params{
                 page_size: 15,
                 pages_ahead: 3,
                 pages_behind: 3,
                 load_first_page?: true,
                 load_last_page?: true,
                 load_opening_separator?: true,
                 load_closing_separator?: true
               }
             }
    end

    test "test count: 1, page: 0" do
      assert_raise FunctionClauseError, fn ->
        Pagination.create_page_list(%Pagination{
          page: 0,
          pages: [],
          params: %Params{
            page_size: 15,
            pages_ahead: 3,
            pages_behind: 3,
            load_first_page?: true,
            load_last_page?: true,
            load_opening_separator?: true,
            load_closing_separator?: true
          }
        }, 1)
      end
    end
  end

  describe "`create_page_list/3` for single result |" do
    test "test count: 1, page: 1" do
      result = Pagination.create_page_list(%Pagination{
        page: 1,
        pages: [],
        params: %Params{
          page_size: 15,
          pages_ahead: 3,
          pages_behind: 3,
          load_first_page?: true,
          load_last_page?: true,
          load_opening_separator?: true,
          load_closing_separator?: true
        }
      }, 1)

      assert result === %Pagination{
               page: 1,
               pages: [
                 %Page{type: :regular, active: true, number: 1, title: "1"}
               ],
               params: %Params{
                 page_size: 15,
                 pages_ahead: 3,
                 pages_behind: 3,
                 load_first_page?: true,
                 load_last_page?: true,
                 load_opening_separator?: true,
                 load_closing_separator?: true
               }
             }
    end
  end

  describe "`create_page_list/3` for lot of results |" do
    test "test count: 1000, page: 1 with default values" do
      result = Pagination.create_page_list(%Pagination{
        page: 1,
        pages: [],
        params: %Params{
          page_size: 15,
          pages_ahead: 3,
          pages_behind: 3,
          load_first_page?: true,
          load_last_page?: true,
          load_opening_separator?: true,
          load_closing_separator?: true
        }
      }, 1000)

      assert result === %Pagination{
               page: 1,
               pages: [
                 %Page{type: :regular, number: 1, title: "1", active: true},
                 %Page{type: :regular, number: 2, title: "2", active: false},
                 %Page{type: :regular, number: 3, title: "3", active: false},
                 %Page{type: :regular, number: 4, title: "4", active: false},
                 %Page{type: :separator, number: 0, title: "...", active: false},
                 %Page{type: :last, number: 67, title: "67", active: false},
               ],
               params: %Params{
                 page_size: 15,
                 pages_ahead: 3,
                 pages_behind: 3,
                 load_first_page?: true,
                 load_last_page?: true,
                 load_opening_separator?: true,
                 load_closing_separator?: true
               }
             }
    end

    test "test count: 1000, page: 1 with no default values" do
      result = Pagination.create_page_list(%Pagination{
        page: 1,
        pages: [],
        params: %Params{
          page_size: 15,
          pages_ahead: 7,
          pages_behind: 7,
          load_first_page?: false,
          load_last_page?: false,
          load_opening_separator?: false,
          load_closing_separator?: false
        }
      }, 1000)

      assert result === %Pagination{
               page: 1,
               pages: [
                 %Page{type: :regular, number: 1, title: "1", active: true},
                 %Page{type: :regular, number: 2, title: "2", active: false},
                 %Page{type: :regular, number: 3, title: "3", active: false},
                 %Page{type: :regular, number: 4, title: "4", active: false},
                 %Page{type: :regular, number: 5, title: "5", active: false},
                 %Page{type: :regular, number: 6, title: "6", active: false},
                 %Page{type: :regular, number: 7, title: "7", active: false},
                 %Page{type: :regular, number: 8, title: "8", active: false}
               ],
               params: %Params{
                 page_size: 15,
                 pages_ahead: 7,
                 pages_behind: 7,
                 load_first_page?: false,
                 load_last_page?: false,
                 load_opening_separator?: false,
                 load_closing_separator?: false
               }
             }
    end

    test "test count: 1000, page: 30 with default values" do
      result = Pagination.create_page_list(%Pagination{
        page: 30,
        pages: [],
        params: %Params{
          page_size: 15,
          pages_ahead: 3,
          pages_behind: 3,
          load_first_page?: true,
          load_last_page?: true,
          load_opening_separator?: true,
          load_closing_separator?: true
        }
      }, 1000)

      assert result === %Pagination{
               page: 30,
               pages: [
                 %Page{type: :first, number: 1, title: "1", active: false},
                 %Page{type: :separator, number: 0, title: "...", active: false},
                 %Page{type: :regular, number: 27, title: "27", active: false},
                 %Page{type: :regular, number: 28, title: "28", active: false},
                 %Page{type: :regular, number: 29, title: "29", active: false},
                 %Page{type: :regular, number: 30, title: "30", active: true},
                 %Page{type: :regular, number: 31, title: "31", active: false},
                 %Page{type: :regular, number: 32, title: "32", active: false},
                 %Page{type: :regular, number: 33, title: "33", active: false},
                 %Page{type: :separator, number: 0, title: "...", active: false},
                 %Page{type: :last, number: 67, title: "67", active: false},
               ],
               params: %Params{
                 page_size: 15,
                 pages_ahead: 3,
                 pages_behind: 3,
                 load_first_page?: true,
                 load_last_page?: true,
                 load_opening_separator?: true,
                 load_closing_separator?: true
               }
             }
    end

    test "test count: 1000, page: 30 with no default values" do
      result = Pagination.create_page_list(%Pagination{
        page: 30,
        pages: [],
        params: %Params{
          page_size: 15,
          pages_ahead: 7,
          pages_behind: 7,
          load_first_page?: false,
          load_last_page?: false,
          load_opening_separator?: false,
          load_closing_separator?: false
        }
      }, 1000)

      assert result === %Pagination{
               page: 30,
               pages: [
                 %Page{type: :regular, number: 23, title: "23", active: false},
                 %Page{type: :regular, number: 24, title: "24", active: false},
                 %Page{type: :regular, number: 25, title: "25", active: false},
                 %Page{type: :regular, number: 26, title: "26", active: false},
                 %Page{type: :regular, number: 27, title: "27", active: false},
                 %Page{type: :regular, number: 28, title: "28", active: false},
                 %Page{type: :regular, number: 29, title: "29", active: false},
                 %Page{type: :regular, number: 30, title: "30", active: true},
                 %Page{type: :regular, number: 31, title: "31", active: false},
                 %Page{type: :regular, number: 32, title: "32", active: false},
                 %Page{type: :regular, number: 33, title: "33", active: false},
                 %Page{type: :regular, number: 34, title: "34", active: false},
                 %Page{type: :regular, number: 35, title: "35", active: false},
                 %Page{type: :regular, number: 36, title: "36", active: false},
                 %Page{type: :regular, number: 37, title: "37", active: false},
               ],
               params: %Params{
                 page_size: 15,
                 pages_ahead: 7,
                 pages_behind: 7,
                 load_first_page?: false,
                 load_last_page?: false,
                 load_opening_separator?: false,
                 load_closing_separator?: false
               }
             }
    end

    test "test count: 1000, page: 67 (last page) with default values" do
      result = Pagination.create_page_list(%Pagination{
        page: 67,
        pages: [],
        params: %Params{
          page_size: 15,
          pages_ahead: 3,
          pages_behind: 3,
          load_first_page?: true,
          load_last_page?: true,
          load_opening_separator?: true,
          load_closing_separator?: true
        }
      }, 1000)

      assert result === %Pagination{
               page: 67,
               pages: [
                 %Page{type: :first, number: 1, title: "1", active: false},
                 %Page{type: :separator, number: 0, title: "...", active: false},
                 %Page{type: :regular, number: 64, title: "64", active: false},
                 %Page{type: :regular, number: 65, title: "65", active: false},
                 %Page{type: :regular, number: 66, title: "66", active: false},
                 %Page{type: :regular, number: 67, title: "67", active: true}
               ],
               params: %Params{
                 page_size: 15,
                 pages_ahead: 3,
                 pages_behind: 3,
                 load_first_page?: true,
                 load_last_page?: true,
                 load_opening_separator?: true,
                 load_closing_separator?: true
               }
             }
    end

    test "test count: 1000, page: 67 (last page) with no default values" do
      result = Pagination.create_page_list(%Pagination{
        page: 67,
        pages: [],
        params: %Params{
          page_size: 15,
          pages_ahead: 7,
          pages_behind: 7,
          load_first_page?: false,
          load_last_page?: false,
          load_opening_separator?: false,
          load_closing_separator?: false
        }
      }, 1000)

      assert result === %Pagination{
               page: 67,
               pages: [
                 %Page{type: :regular, number: 60, title: "60", active: false},
                 %Page{type: :regular, number: 61, title: "61", active: false},
                 %Page{type: :regular, number: 62, title: "62", active: false},
                 %Page{type: :regular, number: 63, title: "63", active: false},
                 %Page{type: :regular, number: 64, title: "64", active: false},
                 %Page{type: :regular, number: 65, title: "65", active: false},
                 %Page{type: :regular, number: 66, title: "66", active: false},
                 %Page{type: :regular, number: 67, title: "67", active: true}
               ],
               params: %Params{
                 page_size: 15,
                 pages_ahead: 7,
                 pages_behind: 7,
                 load_first_page?: false,
                 load_last_page?: false,
                 load_opening_separator?: false,
                 load_closing_separator?: false
               }
             }
    end
  end
end
