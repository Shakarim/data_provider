defmodule DataProvider.SearchOptionsTest do
  use ExUnit.Case
  alias DataProvider.SearchOptions
  doctest DataProvider.SearchOptions

  describe "`create/1` |" do
    test "test default values" do
      result = SearchOptions.create()

      assert result === %SearchOptions{options: %{}}
    end

    test "test preset values" do
      result = SearchOptions.create(%{"first_field" => "first_field_value"})

      assert result === %SearchOptions{options: %{"first_field" => "first_field_value"}}
    end
  end

  describe "`merge_options/2` empty struct |" do
    test "test empty options", %{} do
      search_options = %SearchOptions{options: %{}}
      result = SearchOptions.merge_options(search_options, %{})

      assert result === %SearchOptions{options: %{}}
    end

    test "test preset values" do
      search_options = %SearchOptions{options: %{}}
      result = SearchOptions.merge_options(search_options, %{new_param: "new param value"})

      assert result === %SearchOptions{options: %{new_param: "new param value"}}
    end
  end

  describe "`merge_options/2` filled struct |" do
    test "test empty options", %{} do
      search_options = %SearchOptions{options: %{some_exist: "some exist"}}
      result = SearchOptions.merge_options(search_options, %{})

      assert result === %SearchOptions{options: %{some_exist: "some exist"}}
    end

    test "test preset values" do
      search_options = %SearchOptions{options: %{some_exist: "some exist"}}
      result = SearchOptions.merge_options(search_options, %{new_param: "new param value"})

      assert result === %SearchOptions{options: %{some_exist: "some exist", new_param: "new param value"}}
    end
  end

  describe "`put_options/2` empty struct |" do
    test "test empty options" do
      search_options = %SearchOptions{options: %{}}
      result = SearchOptions.put_options(search_options, %{})

      assert result === %SearchOptions{options: %{}}
    end

    test "test not empty options" do
      search_options = %SearchOptions{options: %{}}
      result = SearchOptions.put_options(search_options, %{"first_field" => "first_field_value"})

      assert result === %SearchOptions{options: %{"first_field" => "first_field_value"}}
    end
  end

  describe "`put_options/2` filled struct |" do
    test "test empty options" do
      search_options = %SearchOptions{options: %{some_exist: "some exist"}}
      result = SearchOptions.put_options(search_options, %{})

      assert result === %SearchOptions{options: %{}}
    end

    test "test not empty options" do
      search_options = %SearchOptions{options: %{some_exist: "some exist"}}
      result = SearchOptions.put_options(search_options, %{"first_field" => "first_field_value"})

      assert result === %SearchOptions{options: %{"first_field" => "first_field_value"}}
    end
  end
end
