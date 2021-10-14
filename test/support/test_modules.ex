defmodule DataProvider.TestModules do
  @moduledoc false

  # alias DataProvider.TestModules.NoFindNoRepo
  # alias DataProvider.TestModules.NoFindValidRepo
  # alias DataProvider.TestModules.NoFindInvalidRepo
  # alias DataProvider.TestModules.QueryFindNoRepo
  # alias DataProvider.TestModules.QueryFindValidRepo
  # alias DataProvider.TestModules.QueryFindInvalidRepo
  # alias DataProvider.TestModules.ListFindNoRepo
  # alias DataProvider.TestModules.ListFindValidRepo
  # alias DataProvider.TestModules.ListFindInvalidRepo
  # alias DataProvider.TestModules.InvalidFindNoRepo
  # alias DataProvider.TestModules.InvalidFindValidRepo
  # alias DataProvider.TestModules.InvalidFindInvalidRepo

  defmodule NoFindNoRepo do
    use DataProvider.TestImpl
  end

  defmodule NoFindValidRepo do
    use DataProvider.TestImpl, repo: :valid
  end

  defmodule NoFindInvalidRepo do
    use DataProvider.TestImpl, repo: :invalid
  end

  defmodule QueryFindNoRepo do
    use DataProvider.TestImpl, find: :query
  end

  defmodule QueryFindValidRepo do
    use DataProvider.TestImpl, find: :query, repo: :valid
  end

  defmodule QueryFindInvalidRepo do
    use DataProvider.TestImpl, find: :query, repo: :invalid
  end

  defmodule ListFindNoRepo do
    use DataProvider.TestImpl, find: :list, find: :valid
  end

  defmodule ListFindValidRepo do
    use DataProvider.TestImpl, find: :list, repo: :valid
  end

  defmodule ListFindInvalidRepo do
    use DataProvider.TestImpl, find: :list,repo: :invalid
  end

  defmodule InvalidFindNoRepo do
    use DataProvider.TestImpl, find: :invalid
  end

  defmodule InvalidFindValidRepo do
    use DataProvider.TestImpl, find: :invalid, repo: :valid
  end

  defmodule InvalidFindInvalidRepo do
    use DataProvider.TestImpl, find: :invalid, repo: :invalid
  end
end
