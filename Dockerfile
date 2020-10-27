ARG PG_VERSION
FROM postgres:${PG_VERSION}-alpine

# Environment
ENV LANG=C.UTF-8 PGDATA=/data PGPORT=55432 REPO=/repo

# Install dependencies
RUN apk add --no-cache make musl-dev gcc clang llvm lz4-dev zstd-dev curl git

# Make directories
RUN	mkdir -p $PGDATA && \
    mkdir -p $REPO

# Grant privileges
RUN	chown -R postgres:postgres $PGDATA && \
    chown -R postgres:postgres $REPO && \
	chmod a+rwx /usr/local/lib/postgresql && \
	chmod a+rwx /usr/local/share/postgresql/extension

COPY bin/* /usr/local/bin/

USER postgres

# initialize database
RUN initdb -D $PGDATA

USER root
