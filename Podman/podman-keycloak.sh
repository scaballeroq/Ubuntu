#!/bin/bash
# podman-keycloak.sh

set -euo pipefail

KC_ADMIN="${KC_ADMIN:-admin}"
KC_ADMIN_PASSWORD="${KC_ADMIN_PASSWORD:-admin}"

if ! podman network exists devfed-net; then podman network create devfed-net; fi

echo "ℹ️ Iniciando Keycloak..."
podman run -d --replace \
    --name keycloak-dev \
    --network devfed-net \
    -e KEYCLOAK_ADMIN="$KC_ADMIN" \
    -e KEYCLOAK_ADMIN_PASSWORD="$KC_ADMIN_PASSWORD" \
    -p 8083:8080 \
    quay.io/keycloak/keycloak:latest start-dev
echo "✅ Keycloak iniciado en http://localhost:8083"
