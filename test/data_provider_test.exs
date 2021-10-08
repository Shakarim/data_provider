defmodule DataProviderTest do
  use ExUnit.Case
  doctest DataProvider

  test "greets the world" do
    assert DataProvider.hello() == :world
  end
end
