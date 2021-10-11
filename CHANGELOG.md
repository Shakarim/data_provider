# Changelog for v1.x

## 1.1.0 (2021-10-11)

### Bug fixes

* Add correctly raising of `DataProvider.RepoCallError` for implementations, which `find/1` returns `Ecto.Query` but `repo/0` returns not a `Ecto.Repo` implementation.
    
### Enhancements

* From now on `DataProvider.RepoCallError` message more informative for modules, which returns `Ecto.Query` in `find/1` implementation but in `repo/0` returns not a `Ecto.Repo` (or invalid `Ecto.Repo`) implementation. 