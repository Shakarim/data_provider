defmodule DataProvider.Loader do
  @moduledoc false
  alias DataProvider.Data

  @doc false
  # Loads `DataProvider.Data` into `:data` field of `DataProvider`
  # Receives one argument `DataProvider` only
  @spec load(DataProvider.t) :: Data.t
  def load(%DataProvider{module: module} = data_provider) do
    find_result = case apply(module, :find, [data_provider]) do
      %Ecto.Query{} = query -> query
      find_result when is_list(find_result) -> find_result
      _ -> raise(DataProvider.UndefinedFindResultError)
    end
    %{data_provider | data: Data.create(data_provider, find_result)}
  end
end