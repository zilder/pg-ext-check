#!/usr/bin/env bash

set -ux

# start cluster
su postgres -c 'pg_ctl start -l /tmp/postgres.log -w -o "-p $PGPORT"'

# something's wrong? show logs and exit
if [[ $? -ne 0 ]]; then
    cat /tmp/postgres.log;
    exit 1;
fi
