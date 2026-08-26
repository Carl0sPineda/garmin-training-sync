#!/usr/bin/env bash
cd "$(dirname "$0")"

echo "=========================================="
echo "         Garmin Training Sync"
echo "=========================================="
echo

# ------------------------------------------------
# Verificar que Python esté instalado
# ------------------------------------------------
PYTHON_BIN="python3"
if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
    PYTHON_BIN="python"
fi

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
    echo "[ERROR] Python no esta instalado o no esta disponible en PATH."
    echo
    echo "Instale Python 3.12 o superior usando el gestor de paquetes de su distribucion"
    echo "(por ejemplo: sudo apt install python3 python3-venv) o desde:"
    echo "https://www.python.org/downloads/"
    echo
    read -r -p "Presione Enter para salir..."
    exit 1
fi

# ------------------------------------------------
# Verificar requirements.txt
# ------------------------------------------------
if [ ! -f "requirements.txt" ]; then
    echo "[ERROR] No se encontro requirements.txt."
    echo
    echo "Verifique que este archivo se encuentre en la carpeta del proyecto."
    echo
    read -r -p "Presione Enter para salir..."
    exit 1
fi

# ------------------------------------------------
# Crear entorno virtual si no existe
# ------------------------------------------------
if [ ! -f ".venv/bin/python" ]; then
    echo "Primera ejecucion detectada."
    echo
    echo "Creando entorno virtual..."
    if ! "$PYTHON_BIN" -m venv .venv; then
        echo
        echo "[ERROR] No se pudo crear el entorno virtual."
        read -r -p "Presione Enter para salir..."
        exit 1
    fi

    echo
    echo "Actualizando pip..."
    if ! .venv/bin/python -m pip install --upgrade pip; then
        echo
        echo "[ERROR] No se pudo actualizar pip."
        read -r -p "Presione Enter para salir..."
        exit 1
    fi

    echo
    echo "Instalando dependencias..."
    if ! .venv/bin/python -m pip install -r requirements.txt; then
        echo
        echo "[ERROR] No se pudieron instalar las dependencias."
        read -r -p "Presione Enter para salir..."
        exit 1
    fi

    echo
    echo "Instalacion completada correctamente."
    echo
fi

# ------------------------------------------------
# Verificar que Streamlit esté instalado
# ------------------------------------------------
if ! .venv/bin/python -c "import streamlit" >/dev/null 2>&1; then
    echo "Streamlit no esta instalado."
    echo "Instalando dependencias nuevamente..."
    echo

    if ! .venv/bin/python -m pip install -r requirements.txt; then
        echo
        echo "[ERROR] No se pudieron instalar las dependencias."
        read -r -p "Presione Enter para salir..."
        exit 1
    fi
fi

# ------------------------------------------------
# Iniciar aplicación
# ------------------------------------------------
echo "Iniciando aplicacion..."
echo
echo "La aplicacion se abrira en el navegador."
echo "Para cerrarla, presione Ctrl+C en esta ventana."
echo

.venv/bin/python -m streamlit run app.py

echo
echo "Garmin Training Sync se ha detenido."
read -r -p "Presione Enter para salir..."
