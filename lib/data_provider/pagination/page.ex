defmodule DataProvider.Pagination.Page do
  @moduledoc ~S"""
  Struct module of pagination page

  ## Types

  The `DataProvider.Pagination` creates 4 type values for this module:

    * `:regular` - Regular page for navigation. Have integer number, greater
    than 0 and `:active` value as `true` if `:page` of `DataProvider.Pagination`
    equal for `:number` of `DataProvider.Pagination.Page`

    * `:first` - Page to fast move to first page in list. Can not be active, but
    contain `:number` equal 1.

    * `:last` - Page to fast move to last page in list. Can not be active. Page with
    this type has dynamic value of `number`. The value of his `number` is calculated
    count of possible pages.

    * `:separator` - Page with no link and no valid `number`. It's blank page, uses
    for separating the pages list only.

  ## Active

  The `:active` it is boolean value of activity state of page. By default, all pages `active: false`,
  but this value can be true, when `:page` of `DataProvider.Pagination` and `:number` of
  `DataProvider.Pagination.Page` are equal and `:type` of `DataProvider.Pagination.Page` is `:regular`.

  ## Number

  Integer value of page, by default - 0.

  ## Title

  The title of page, by default "...", but when `:type` is `:regular`, `:first` or `:last` - can contain
  stringyfied value of `:number`.

  """

  defstruct type: :regular,
            active: false,
            number: 0,
            title: "..."

  @typedoc ~S"""
  The `DataProvider.Pagination.Page` struct module for `:pages` of `DataProvider.Pagination`

  ## Fields

    * `type` - the type of page, atom, by default is `:regular`, can accept
    values: `:regular`, `:first`, `:last`, `:separator`

    * `active` - boolean value of active state of page, by default is `false`

    * `number` - integer value with number of page, by default is 0

    * `title` - string, the title of this page (it can be different than number)
    by default is "..."

  """
  @type t() :: %__MODULE__{
                 type: atom(),
                 active: boolean(),
                 number: integer(),
                 title: String.t()
               }
end
