#!/bin/sh

versions=(09 10 11 12)

echo "\n>>> stop container..."
docker-compose stop

echo "\n>>> rm container..."
docker-compose rm -f

for v in ${versions[@]}; do
    echo "\n>>> rm ${v} volumes..."

    if [ -e "./volumes/${v}/" ]; then
        rm -rf "./volumes/${v}/"
    else
        echo " - ./volumes/${v}/ is not exists"
    fi

    echo "\n>>> make ${v} volumes..."

    mkdir -p "./volumes/${v}/config"
    mkdir -p "./volumes/${v}/data"
    mkdir -p "./volumes/${v}/entrypoint"

    echo "\n>>> setup ${v} init..."

    if [ -e "./initfiles/config/postgresql.conf" ]; then
        cp -a "./initfiles/config/postgresql.conf" "./volumes/${v}/config/postgresql.conf"
    else
        echo " - ./initfiles/config/postgresql.conf is not exists"
    fi

    if [ -e "./initfiles/entrypoint/DDL.sql" ]; then
        cp -a "./initfiles/entrypoint/DDL.sql" "./volumes/${v}/entrypoint/DDL.sql"
    else
        echo " - ./initfiles/entrypoint/DDL.sql is not exists"
    fi
done

echo "\n>>> cleanup completed"

exit 0
