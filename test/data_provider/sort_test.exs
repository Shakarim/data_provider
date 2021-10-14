defmodule DataProvider.SortTest do
  use ExUnit.Case
  alias DataProvider.Sort
  doctest DataProvider.Sort

  def fixture(:sort, _), do: Sort.create()
  def fixture(:filled_sort, _), do: Sort.create([desc: "inserted_at"])


  defp sort(params), do: {:ok, sort: fixture(:sort, params)}
  defp filled_sort(params), do: {:ok, filled_sort: fixture(:filled_sort, params)}

  setup [:sort, :filled_sort]

  describe "`create/1` |" do
    test "test default values" do
      result = Sort.create()

      assert result === %Sort{options: []}
    end

    test "test preset values" do
      result = Sort.create(asc: "field")

      assert result === %Sort{options: [asc: "field"]}
    end
  end

  describe "`merge_options/2` empty struct |" do
    test "test empty options" do
      sort = %Sort{options: []}
      result = Sort.merge_options(sort, [])

      assert result === %Sort{options: []}
    end

    test "test not empty options" do
      sort = %Sort{options: []}
      result = Sort.merge_options(sort, asc: :new_field)

      assert result === %Sort{options: [asc: :new_field]}
    end
  end

  describe "`merge_options/2` filled struct |" do
    test "test empty options" do
      sort = %Sort{options: [asc: :old_field]}
      result = Sort.merge_options(sort, [])

      assert result === %Sort{options: [asc: :old_field]}
    end

    test "test not empty options" do
      sort = %Sort{options: [asc: :old_fields]}
      result = Sort.merge_options(sort, desc: :new_fields)

      assert result === %Sort{options: [asc: :old_fields, desc: :new_fields]}
    end
  end

  describe "`put_options/2` empty struct |" do
    test "test empty options" do
      sort = %Sort{options: []}
      result = Sort.put_options(sort, [])

      assert result === %Sort{options: []}
    end

    test "test not empty options" do
      sort = %Sort{options: []}
      result = Sort.put_options(sort, [asc: :putted_option])

      assert result === %Sort{options: [asc: :putted_option]}
    end
  end

  describe "`put_options/2` filled struct |" do
    test "test empty options" do
      sort = %Sort{options: [desc: :exist_option]}
      result = Sort.put_options(sort, [])

      assert result === %Sort{options: []}
    end

    test "test not empty options" do
      sort = %Sort{options: [desc: :exist_option]}
      result = Sort.put_options(sort, [asc: :putted_option])

      assert result === %Sort{options: [asc: :putted_option]}
    end
  end
end
