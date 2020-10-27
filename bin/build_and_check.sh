#!/usr/bin/env bash

set -ux

# build extension
make install

# run regression tests
status=0
make installcheck PGUSER=postgres || status=$?

# show diff if needed
if [[ $status -ne 0 ]] && [[ -f regression.diffs ]]; then
    cat regression.diffs;
fi

exit $status
