defmodule DataProvider.Pagination.Page do
  @moduledoc ~S"""
  Struct module of pagination page
  """

  defstruct type: :regular,
            active: false,
            number: 0,
            title: "..."

  @typedoc ~S"""
  Struct module contain fields:

    * `type` - the type of page, can be: :regular, :first, :last, :separator

    * `active` - boolean value of active state of page

    * `number` - the number of page

    * `title` - the title of this page (it can be different than number)

  """
  @type t() :: %__MODULE__{
                 type: atom(),
                 active: boolean(),
                 number: integer(),
                 title: String.t()
               }
end
