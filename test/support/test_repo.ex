defmodule DataProvider.TestRepo do
  @moduledoc false
  @fake_result Enum.to_list(1..100)

  @doc false
  def all(_), do: @fake_result
end
