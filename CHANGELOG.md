# Changelog for v1.x

## 1.2.0 (2021-10-16)

### Enhancements

* Set `:params` field of `DataProvider.Pagination` as independent module `DataProvider.Pagination.Params`
* Add `:pages` field with available pages into `DataProvider.Pagination` struct. 

## 1.1.0 (2021-10-11)

### Bug fixes

* Add correctly raising of `DataProvider.RepoCallError` for implementations, which `find/1` returns `Ecto.Query` but `repo/0` returns not a `Ecto.Repo` implementation.
* Fix error of calculating the total data count in `DataProvider`. Before, total count were calculated based on exist items in `DataProvider.Data`. It was wrong, because `items` of `DataProvider.Data` contain items count, which limited by `page_size` of `DataProvider.Pagination`. From now on, total count calculates based on `DataProvider.SearchOptions` with no `DataProvider.Pagination` influence.
    
### Enhancements

* From now on `DataProvider.RepoCallError` message more informative for modules, which returns `Ecto.Query` in `find/1` implementation but in `repo/0` returns not a `Ecto.Repo` (or invalid `Ecto.Repo`) implementation. 