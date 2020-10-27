#!/usr/bin/env bash

set -ux

status=0

# build extension
make install

# run regression tests
export PG_REGRESS_DIFF_OPTS="-w -U3" # for alpine's diff (BusyBox)
make installcheck PGUSER=postgres || status=$?

# show diff if needed and exit if something's wrong
if [[ $status -ne 0 ]] && [[ -f regression.diffs ]]; then
    cat regression.diffs;
fi

exit $status
