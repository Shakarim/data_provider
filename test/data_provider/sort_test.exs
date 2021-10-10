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

      assert match?(%Sort{}, result)
      assert result.options === []
    end

    test "test preset values" do
      attrs = [asc: "field"]
      result = Sort.create(attrs)

      assert match?(%Sort{}, result)
      assert result.options === attrs
    end
  end

  describe "`merge_options/2` empty struct |" do
    test "test empty options", %{sort: sort} do
      result = Sort.merge_options(sort, [])

      assert result.options === sort.options
    end

    test "test preset values", %{sort: sort} do
      attrs = [asc: :new_field]
      result = Sort.merge_options(sort, attrs)

      assert result.options === attrs
    end
  end

  describe "`merge_options/2` filled struct |" do
    test "test empty options", %{filled_sort: sort} do
      result = Sort.merge_options(sort, [])

      assert result.options === sort.options
    end

    test "test preset values", %{filled_sort: sort} do
      attrs = [asc: :some_field]
      result = Sort.merge_options(sort, attrs)

      assert result.options === [desc: "inserted_at", asc: :some_field]
    end
  end

  test "test `put_options/2`", %{filled_sort: sort} do
    attrs = [desc: :new_values]
    result = Sort.put_options(sort, attrs)

    assert result.options === attrs
  end
end
