#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    cat << EOF
Usage:
    pg_setup.sh PG_VERSION
EOF
    exit 1
fi

set -ux

apt.postgresql.org.sh -i -v $1
pg_createcluster --start $1 test -p 5432 -- -A trust
