defmodule DataProvider.TestImpl do
  defmacro __using__(opts) do
    quote do
      use DataProvider

      unquote do
        case Keyword.get(opts, :repo) do
          :valid ->
            quote do
              def repo(), do: DataProvider.TestRepo
            end
          :invalid ->
            quote do
              def repo(), do: :some_wrong_repo
            end
          _ -> nil
        end
      end

      unquote do
        case Keyword.get(opts, :find) do
          :query ->
            quote do
              import Ecto.Query

              def find(%DataProvider{}), do: from(t in DataProvider.TestSchema)
            end
          :list ->
            quote do
              import Ecto.Query

              def find(%DataProvider{search_options: %{options: %{"rem" => rem}}}) when is_integer(rem),
                  do: Enum.to_list(1001..2000)
              def find(%DataProvider{}), do: Enum.to_list(1..1000)
            end
          :invalid ->
            quote do
              def find(_), do: :wrong_find_result
            end
          _ -> nil
        end
      end
    end
  end
end
