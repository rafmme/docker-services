#
# example Dockerfile for https://docs.docker.com/engine/examples/postgresql_service/
#

FROM ubuntu:18.04


RUN apt-get update && apt-get install -y gnupg2

RUN mkdir ~/.gnupg2 && echo "disable-ipv6" >> ~/.gnupg2/dirmngr.conf

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``9.3``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL 9.3
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

# Note: The official Debian and Ubuntu images automatically ``apt-get clean``
# after each ``apt-get``

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN sed -i "s/host all all 127.0.0.1\/32 md5/host all all 0.0.0.0\/0 peer/gi" /etc/postgresql/9.3/main/pg_hba.conf
RUN sed -i "s/host all all ::1\/128 md5/host all all ::1\/128 peer/gi" /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "hostnossl  all  all  0.0.0.0/0  trust" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/gi" /etc/postgresql/9.3/main/postgresql.conf


# Run command to create database haven_db
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE DATABASE haven_db;"

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
