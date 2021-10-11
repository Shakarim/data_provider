defmodule DataProvider.TestRepo do
  @moduledoc false
  @fake_result Enum.to_list(1..100)

  @doc false
  def all(_), do: Enum.filter(@fake_result, &(rem(&1, 2) == 0))

  @doc false
  def aggregate(_, _), do: Enum.count(@fake_result)
end
