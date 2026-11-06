@echo off
rem Usage: scripts\run.bat path\to\sol.cpp   (reads input.txt next to the file if present)
if "%~1"=="" (
    echo Usage: scripts\run.bat path\to\sol.cpp
    exit /b 1
)
if not exist "%~dp0..\out" mkdir "%~dp0..\out"
set "EXE=%~dp0..\out\%~n1.exe"
g++ -std=c++17 -O2 -Wall -DLOCAL -o "%EXE%" "%~1"
if errorlevel 1 (
    echo Compilation failed
    exit /b 1
)
if exist "%~dp1input.txt" (
    "%EXE%" < "%~dp1input.txt"
) else (
    "%EXE%"
)
