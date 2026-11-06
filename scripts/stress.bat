@echo off
rem Usage: scripts\stress.bat sol.cpp brute.cpp gen.cpp [iterations]
rem gen.exe receives the test number as argv[1] (use it as the random seed).
setlocal
if "%~3"=="" (
    echo Usage: scripts\stress.bat sol.cpp brute.cpp gen.cpp [iterations]
    exit /b 1
)
set "N=%~4"
if "%N%"=="" set "N=500"
set "T=%TEMP%\stress_cp"
if not exist "%T%" mkdir "%T%"
g++ -std=c++17 -O2 -o "%T%\sol.exe" "%~1" || exit /b 1
g++ -std=c++17 -O2 -o "%T%\brute.exe" "%~2" || exit /b 1
g++ -std=c++17 -O2 -o "%T%\gen.exe" "%~3" || exit /b 1
for /l %%i in (1,1,%N%) do (
    "%T%\gen.exe" %%i > "%T%\in.txt"
    "%T%\sol.exe" < "%T%\in.txt" > "%T%\o1.txt"
    "%T%\brute.exe" < "%T%\in.txt" > "%T%\o2.txt"
    fc /b "%T%\o1.txt" "%T%\o2.txt" >nul
    if errorlevel 1 (
        echo MISMATCH on test %%i. Input saved at %T%\in.txt
        exit /b 1
    )
)
echo All %N% tests passed.
