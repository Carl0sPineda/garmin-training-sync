#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

echo "=========================================="
echo "Garmin Training Sync - Instalacion"
echo "=========================================="
echo

PYTHON_BIN="python3"
if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
    PYTHON_BIN="python"
fi

echo "Creando entorno virtual..."
"$PYTHON_BIN" -m venv .venv

echo
echo "Actualizando pip..."
.venv/bin/python -m pip install --upgrade pip

echo
echo "Instalando dependencias..."
.venv/bin/python -m pip install -r requirements.txt

echo
echo "=========================================="
echo "Instalacion finalizada correctamente."
echo "Ahora puede ejecutar ./start_app.sh"
echo "=========================================="
echo
