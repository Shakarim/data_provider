defmodule DataProvider.LoaderTest do
  use ExUnit.Case
  alias DataProvider.TestModules.NoFindNoRepo
  alias DataProvider.TestModules.NoFindValidRepo
  alias DataProvider.TestModules.NoFindInvalidRepo
  alias DataProvider.TestModules.QueryFindNoRepo
  alias DataProvider.TestModules.QueryFindValidRepo
  alias DataProvider.TestModules.QueryFindInvalidRepo
  alias DataProvider.TestModules.ListFindNoRepo
  alias DataProvider.TestModules.ListFindValidRepo
  alias DataProvider.TestModules.ListFindInvalidRepo
  alias DataProvider.TestModules.InvalidFindNoRepo
  alias DataProvider.TestModules.InvalidFindValidRepo
  alias DataProvider.TestModules.InvalidFindInvalidRepo
  alias DataProvider.Loader
  doctest DataProvider.Loader

  describe "`load/1` |" do
    test "test `NoFindNoRepo` loading" do
      data_provider = NoFindNoRepo.data_provider()
      result = Loader.load(data_provider)

      assert match?(%DataProvider{}, result)
    end
    test "test `NoFindValidRepo` loading" do
      data_provider = NoFindValidRepo.data_provider()
      result = Loader.load(data_provider)

      assert match?(%DataProvider{}, result)
    end
    test "test `NoFindInvalidRepo` loading" do
      data_provider = NoFindInvalidRepo.data_provider()
      result = Loader.load(data_provider)

      assert match?(%DataProvider{}, result)
    end

    test "test `QueryFindNoRepo` loading" do
      data_provider = QueryFindNoRepo.data_provider()

      assert_raise DataProvider.RepoNotDefinedError, fn ->
        Loader.load(data_provider)
      end
    end
    test "test `QueryFindValidRepo` loading" do
      data_provider = QueryFindValidRepo.data_provider()
      result = Loader.load(data_provider)

      assert match?(%DataProvider{}, result)
    end
    test "test `QueryFindInvalidRepo` loading" do
      data_provider = QueryFindInvalidRepo.data_provider()

      assert_raise UndefinedFunctionError, fn ->
        Loader.load(data_provider)
      end
    end

    test "test `ListFindNoRepo` loading" do
      data_provider = ListFindNoRepo.data_provider()
      result = Loader.load(data_provider)

      assert match?(%DataProvider{}, result)
    end
    test "test `ListFindValidRepo` loading" do
      data_provider = ListFindValidRepo.data_provider()
      result = Loader.load(data_provider)

      assert match?(%DataProvider{}, result)
    end
    test "test `ListFindInvalidRepo` loading" do
      data_provider = ListFindInvalidRepo.data_provider()
      result = Loader.load(data_provider)

      assert match?(%DataProvider{}, result)
    end

    test "test `InvalidFindNoRepo` loading" do
      data_provider = InvalidFindNoRepo.data_provider()

      assert_raise DataProvider.UndefinedFindError, fn ->
        Loader.load(data_provider)
      end
    end
    test "test `InvalidFindValidRepo` loading" do
      data_provider = InvalidFindValidRepo.data_provider()

      assert_raise DataProvider.UndefinedFindError, fn ->
        Loader.load(data_provider)
      end
    end
    test "test `InvalidFindInvalidRepo` loading" do
      data_provider = InvalidFindInvalidRepo.data_provider()

      assert_raise DataProvider.UndefinedFindError, fn ->
        Loader.load(data_provider)
      end
    end
  end
end
