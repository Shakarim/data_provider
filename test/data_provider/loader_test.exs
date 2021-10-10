defmodule DataProvider.LoaderTest do
  use ExUnit.Case
  alias DataProvider.FakeModules.QueryModule
  alias DataProvider.FakeModules.ListModule
  doctest DataProvider.Loader

  describe "`load/1` |" do
    test "test `QueryModule` loading" do
      data_provider = QueryModule.data_provider()

      assert match?(%DataProvider{}, data_provider)
    end

    test "test `ListModule` loading" do
      data_provider = ListModule.data_provider()

      assert match?(%DataProvider{}, data_provider)
    end
  end
end
