@echo off
setlocal
cd /d "%~dp0"

title Garmin Training Sync

echo ==========================================
echo          Garmin Training Sync
echo ==========================================
echo.

REM ------------------------------------------------
REM Verificar que Python esté instalado
REM ------------------------------------------------
python --version >nul 2>&1

if errorlevel 1 (
    echo [ERROR] Python no esta instalado o no esta disponible en PATH.
    echo.
    echo Instale Python 3.12 o superior desde:
    echo https://www.python.org/downloads/
    echo.
    echo Durante la instalacion marque:
    echo "Add Python to PATH"
    echo.
    pause
    exit /b 1
)

REM ------------------------------------------------
REM Verificar requirements.txt
REM ------------------------------------------------
if not exist "requirements.txt" (
    echo [ERROR] No se encontro requirements.txt.
    echo.
    echo Verifique que este archivo se encuentre en la carpeta del proyecto.
    echo.
    pause
    exit /b 1
)

REM ------------------------------------------------
REM Crear entorno virtual si no existe
REM ------------------------------------------------
if not exist ".venv\Scripts\python.exe" (
    echo Primera ejecucion detectada.
    echo.
    echo Creando entorno virtual...
    python -m venv .venv

    if errorlevel 1 (
        echo.
        echo [ERROR] No se pudo crear el entorno virtual.
        pause
        exit /b 1
    )

    echo.
    echo Actualizando pip...
    ".venv\Scripts\python.exe" -m pip install --upgrade pip

    if errorlevel 1 (
        echo.
        echo [ERROR] No se pudo actualizar pip.
        pause
        exit /b 1
    )

    echo.
    echo Instalando dependencias...
    ".venv\Scripts\python.exe" -m pip install -r requirements.txt

    if errorlevel 1 (
        echo.
        echo [ERROR] No se pudieron instalar las dependencias.
        pause
        exit /b 1
    )

    echo.
    echo Instalacion completada correctamente.
    echo.
)

REM ------------------------------------------------
REM Verificar que Streamlit esté instalado
REM ------------------------------------------------
".venv\Scripts\python.exe" -c "import streamlit" >nul 2>&1

if errorlevel 1 (
    echo Streamlit no esta instalado.
    echo Instalando dependencias nuevamente...
    echo.

    ".venv\Scripts\python.exe" -m pip install -r requirements.txt

    if errorlevel 1 (
        echo.
        echo [ERROR] No se pudieron instalar las dependencias.
        pause
        exit /b 1
    )
)

REM ------------------------------------------------
REM Iniciar aplicación
REM ------------------------------------------------
echo Iniciando aplicacion...
echo.
echo La aplicacion se abrira en el navegador.
echo Para cerrarla, cierre esta ventana.
echo.

".venv\Scripts\python.exe" -m streamlit run app.py

echo.
echo Garmin Training Sync se ha detenido.
pause

endlocal