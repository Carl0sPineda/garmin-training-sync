
@echo off
cd /d "%~dp0"

echo ==========================================
echo Garmin Training Sync
echo ==========================================
echo.

if exist ".venv\Scripts\activate.bat" (
    call .venv\Scripts\activate
)

echo Iniciando aplicacion...
echo.

python -m streamlit run app.py

pause