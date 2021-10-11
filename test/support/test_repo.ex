defmodule DataProvider.TestRepo do
  @moduledoc false
  @fake_result [
    "fake result data #1"
  ]

  @doc false
  def all(_), do: @fake_result
end
