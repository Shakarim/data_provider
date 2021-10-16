defmodule DataProvider.ParamsTest do
  use ExUnit.Case
  alias Ecto.Query
  alias DataProvider.Pagination.Params
  doctest DataProvider.Pagination.Params

  describe "`create/1` |" do
    test "test default params" do
      result = Params.create()

      assert result === %Params{
               page_size: 15,
               pages_ahead: 3,
               pages_behind: 3,
               load_first_page?: true,
               load_last_page?: true,
               load_opening_separator?: true,
               load_closing_separator?: true
             }
    end

    test "test not default params" do
      result = Params.create(%{
        page_size: 30,
        pages_ahead: 5,
        pages_behind: 5,
        load_first_page?: false,
        load_last_page?: false,
        load_opening_separator?: false,
        load_closing_separator?: false
      })

      assert result === %Params{
               page_size: 30,
               pages_ahead: 5,
               pages_behind: 5,
               load_first_page?: false,
               load_last_page?: false,
               load_opening_separator?: false,
               load_closing_separator?: false
             }
    end
  end

  describe "`page_size/1` | " do
    test "test valid attrs" do
      result = Params.page_size(%Params{
        page_size: 30,
        pages_ahead: 5,
        pages_behind: 5,
        load_first_page?: false,
        load_last_page?: false,
        load_opening_separator?: false,
        load_closing_separator?: false
      })

      assert result === 30
    end

    test "test invalid attrs" do
      assert_raise FunctionClauseError, fn ->
        Params.page_size(%Params{
          page_size: "30",
          pages_ahead: 5,
          pages_behind: 5,
          load_first_page?: false,
          load_last_page?: false,
          load_opening_separator?: false,
          load_closing_separator?: false
        })
      end
    end
  end
end
