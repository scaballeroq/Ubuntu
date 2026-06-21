#!/bin/bash
# podman-mysql.sh

set -euo pipefail

MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-root}"

if ! podman network exists devfed-net; then podman network create devfed-net; fi

echo "ℹ️ Iniciando MySQL (latest)..."
podman run -d --replace \
    --name mysql-dev \
    --network devfed-net \
    -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
    -p 3306:3306 \
    docker.io/library/mysql:latest
echo "✅ MySQL iniciado en puerto 3306 (user: root)"
