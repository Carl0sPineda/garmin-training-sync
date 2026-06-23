@echo off
cd /d "%~dp0"

echo ==========================================
echo Garmin Training Sync - Instalacion
echo ==========================================
echo.

echo Creando entorno virtual...
python -m venv .venv

echo.
echo Activando entorno virtual...
call .venv\Scripts\activate

echo.
echo Actualizando pip...
python -m pip install --upgrade pip

echo.
echo Instalando dependencias...
pip install -r requirements.txt

echo.
echo ==========================================
echo Instalacion finalizada correctamente.
echo Ahora puede ejecutar start_app.bat
echo ==========================================
echo.

pause