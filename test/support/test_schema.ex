defmodule DataProvider.TestSchema do
  @moduledoc false
  use Ecto.Schema

  embedded_schema do
    field :identity, :string
  end
end
