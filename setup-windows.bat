@echo off

:start
echo Are you sure you want to setup Patakê? (y/n):
set /p confirm=

if /i "%confirm%" == "y" goto setup
if /i "%confirm%" == "n" goto end

:setup

echo
echo "*** CREATING PYTHON VIRTUAL ENVIRONMENT ***"
python -m venv .venv
call .venv\Scripts\activate

echo
echo "*** INSTALLING PYTHON DEPENDENCIES ***"
pip install -r requirements.txt

echo
echo "*** DONE ***"
echo "Run Patakê with: ./patake.bat <args>"
echo

:end


