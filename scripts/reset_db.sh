#!/usr/bin/env bash


psql -c "UPDATE pg_database SET datallowconn=false WHERE datname='eyesite_dev';"
psql -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'eyesite_dev' AND pid <> pg_backend_pid();"

mix ecto.drop
mix ecto.create
mix ecto.migrate