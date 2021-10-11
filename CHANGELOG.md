# Changelog for v1.x

## 1.1.0 (2021-10-11)

### Bug fixes

    *  Add correctly raising of `DataProvider.RepoCallError` for implementations, which `find/1` returns `Ecto.Query` but `repo/0` returns not a `Ecto.Repo` implementation  