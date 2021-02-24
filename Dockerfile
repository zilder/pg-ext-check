FROM debian:buster-slim

# Environment
ENV LANG=C.UTF-8 REPO=/repo

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential clang llvm gnupg2 && \
    apt-get clean && \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*

# Make directories
RUN	mkdir -p $REPO

# Add script that automates repository setup for postgres packages
ADD https://salsa.debian.org/postgresql/postgresql-common/raw/master/pgdg/apt.postgresql.org.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/apt.postgresql.org.sh

# Copy scripts into docker image
COPY bin/* /usr/local/bin/

