# pg-ext-check

A docker image to build and test PostgreSQL extensions. An already built and ready to use image can be found on [docker hub](https://hub.docker.com/repository/docker/zilder/pg-ext-check).

## Usage example for Github Actions

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
      matrix:
        pg: [13, 12, 11, 10, 9.6, 9.5]
    name: PostgreSQL ${{ matrix.pg }}
    runs-on: ubuntu-latest
    container: zilder/pg-ext-check
    steps:
      - run: pg-setup ${{ matrix.pg }}
      - uses: actions/checkout@v2
      - run: build-check
```

## Command line example

```bash
export PG_VERSION=13
docker run -it --rm --mount "type=bind,src=$(pwd),dst=/repo" zilder/pg-ext-check \ 
    /bin/bash -c "cd /repo && pg-setup $PG_VERSION && build-check"
```
