#!/bin/bash
# podman-postgres.sh

set -euo pipefail

PG_PASSWORD="${PG_PASSWORD:-postgres}"

if ! podman network exists devfed-net; then podman network create devfed-net; fi

echo "ℹ️ Iniciando PostgreSQL (latest)..."
podman run -d --replace \
    --name postgres-dev \
    --network devfed-net \
    -e POSTGRES_PASSWORD="$PG_PASSWORD" \
    -p 5432:5432 \
    docker.io/library/postgres:latest
echo "✅ PostgreSQL iniciado en puerto 5432 (user: postgres)"
