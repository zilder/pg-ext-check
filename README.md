# pg-ext-check

A docker image to build and test PostgreSQL extensions. The already built and ready to use image can be found on [docker hub](https://hub.docker.com/repository/docker/zilder/pg-ext-check).

## Commands

* `pg-setup <PG_VERSION>`: install and run specified PostgreSQL version.
* `install-dependency REPO1 [REPO2 ...]`: clone, build and install listed PostgreSQL extensions. GitHub is used as default platform, but can be changed by `HOST` environment variable. Authentication tokens (e.g. GitHub personal access token) are supported and can be specified with `AUTH_TOKEN` environment variable.
* `build-check`: build and install extension and run regression tests. In case of test failure the `regression.diff` is printed out and error code is returned.
* `update-check`: when extension has both extension script and update script, check that update script applies successfully and resulting extension containes the same objects that the base script does.

## Example for Github Actions

```yaml
name: CI

on:
  push:
    branches: ['*']
  pull_request:
    branches: ['*']

jobs:
  test:
    strategy:
      fail-fast: false
      matrix:
        pg: [13, 12, 11, 10, 9.6, 9.5]
    name: PostgreSQL ${{ matrix.pg }}
    runs-on: ubuntu-latest
    container: zilder/pg-ext-check
    steps:
      - run: pg-setup ${{ matrix.pg }}
      - run: install-dependency zilder/pg_cryogen
        env:
          AUTH_TOKEN: ${{ secrets.SUPER_SECRET_TOKEN }}
      - uses: actions/checkout@v2
      - run: build-check
```

## Command line example

```bash
export PG_VERSION=13
docker run -it --rm --mount "type=bind,src=$(pwd),dst=/repo" zilder/pg-ext-check \ 
    /bin/bash -c "cd /repo && pg-setup $PG_VERSION && build-check"
```
