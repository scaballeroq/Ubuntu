#!/bin/bash
# ==============================================================================
# ENDURECIMIENTO DE SEGURIDAD BÁSICO (seguridad.sh)
# ==============================================================================
# Este script aplica configuraciones básicas de seguridad para Ubuntu:
#   - Firewall UFW (cortafuegos)
#
# Para seguridad avanzada (DNS-over-TLS), ejecutar seguridad-dot.sh
# ==============================================================================

set -euo pipefail

echo "🚀 Iniciando el proceso de endurecimiento de seguridad del sistema..."

# ==============================================================================
# PASO 1: CONFIGURACIÓN DEL CORTAFUEGOS (FIREWALL - UFW)
# ==============================================================================
echo "ℹ️ Paso 1: Configurando UFW (Uncomplicated Firewall)..."

# 1.1 Comprobar e instalar UFW si no está presente
if ! command -v ufw &> /dev/null; then
    echo "   - UFW no detectado. Procediendo a la instalación..."
    sudo apt update
    sudo apt install -y ufw
fi

# 1.2 Establecer las políticas de seguridad por defecto
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 1.3 Permitir y limitar el acceso por SSH
# Configurable mediante variable de entorno SSH_ALLOWED_NETWORK
SSH_ALLOWED_NETWORK="${SSH_ALLOWED_NETWORK:-192.168.1.0/24}"
sudo ufw limit from "$SSH_ALLOWED_NETWORK" to any port ssh

# 1.4 Activar el Firewall
sudo ufw --force enable

# ==============================================================================
# FIN DEL PROCESO
# ==============================================================================
echo "✅ Configuración de seguridad básica completada con éxito."
echo "💡 Para DNS cifrado (DNS-over-TLS), ejecuta: ./Setup/seguridad-dot.sh"
