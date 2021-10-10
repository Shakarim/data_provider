defmodule DataProvider.SearchOptionsTEst do
  use ExUnit.Case
  alias DataProvider.SearchOptions
  doctest DataProvider.SearchOptions

  def fixture(:search_options, _), do: SearchOptions.create()
  def fixture(:filled_search_options, _), do: SearchOptions.create(%{"random_field" => "random_value"})


  defp search_options(params), do: {:ok, search_options: fixture(:search_options, params)}
  defp filled_search_options(params), do: {:ok, filled_search_options: fixture(:filled_search_options, params)}

  setup [:search_options, :filled_search_options]

  describe "`create/1` |" do
    test "test default values" do
      result = SearchOptions.create()

      assert match?(%SearchOptions{}, result)
      assert result.options === %{}
    end

    test "test preset values" do
      attrs = %{"first_field" => "first_field_value"}
      result = SearchOptions.create(attrs)

      assert match?(%SearchOptions{}, result)
      assert result.options === attrs
    end
  end

  describe "`merge_options/2` empty struct |" do
    test "test empty options", %{search_options: search_options} do
      result = SearchOptions.merge_options(search_options, %{})

      assert result.options === search_options.options
    end

    test "test preset values", %{search_options: search_options} do
      attrs = %{"first_field" => "first_field_value"}
      result = SearchOptions.merge_options(search_options, attrs)

      assert result.options === attrs
    end
  end

  describe "`merge_options/2` filled struct |" do
    test "test empty options", %{filled_search_options: search_options} do
      result = SearchOptions.merge_options(search_options, %{})

      assert result.options === search_options.options
    end

    test "test preset values", %{filled_search_options: search_options} do
      attrs = %{"first_field" => "first_field_value"}
      result = SearchOptions.merge_options(search_options, attrs)

      assert result.options === Map.merge(attrs, search_options.options)
    end
  end

  test "test `put_options/2`", %{filled_search_options: search_options} do
    attrs = %{"first_field" => "first_field_value"}
    result = SearchOptions.put_options(search_options, attrs)

    assert result.options === attrs
  end
end
