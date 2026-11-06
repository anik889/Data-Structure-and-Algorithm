@echo off
rem Usage: scripts\new_problem.bat codeforces\div2 1900A
if "%~2"=="" (
    echo Usage: scripts\new_problem.bat PLATFORM NAME
    echo Example: scripts\new_problem.bat codeforces\div2 1900A
    exit /b 1
)
set "ROOT=%~dp0.."
if not exist "%ROOT%\04_practice\%~1" mkdir "%ROOT%\04_practice\%~1"
if exist "%ROOT%\04_practice\%~1\%~2.cpp" (
    echo Already exists.
    exit /b 1
)
copy "%ROOT%\02_cp_library_cpp\00_setup\template.cpp" "%ROOT%\04_practice\%~1\%~2.cpp" >nul
echo Created 04_practice\%~1\%~2.cpp
