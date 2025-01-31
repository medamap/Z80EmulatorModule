@echo off
setlocal ENABLEDELAYEDEXPANSION

echo Starting z80docker.bat...

:: 変数の初期化
set "ARCH="
set "ACTION="

:: 引数が足りない場合のエラーチェック
if "%~1"=="" (
    echo Error: No arguments provided.
    goto show_help
)
if "%~2"=="" (
    echo Error: Missing architecture argument.
    goto show_help
)
if "%~3"=="" (
    echo Error: Missing exec argument.
    goto show_help
)

:: 引数の解析
set "ARG1=%~1"
set "ARG2=%~2"
set "ARG3=%~3"

if /I "%ARG1%"=="architecture" (
    set "ARCH=%ARG2%"
) else (
    echo Error: Invalid first argument "%ARG1%".
    goto show_help
)

if /I "%ARG3%"=="exec" (
    set "ACTION=%~4"
) else (
    echo Error: Invalid third argument "%ARG3%".
    goto show_help
)

:: ARCHとACTIONのチェック
if "%ARCH%"=="" (
    echo Error: Missing architecture value.
    goto show_help
)
if "%ACTION%"=="" (
    echo Error: Missing exec value.
    goto show_help
)

:: ARCH に基づいた SERVICE の決定
if /I "%ARCH%"=="cpu" (
    set "SERVICE=z80-cpu"
) else if /I "%ARCH%"=="gpu" (
    set "SERVICE=z80-gpu"
) else (
    echo Error: Invalid architecture "%ARCH%".
    goto show_help
)

echo Using service: %SERVICE%

:: ACTION の処理
if /I "%ACTION%"=="build" (
    echo Running: docker-compose build %SERVICE%
    docker-compose build %SERVICE%
    exit /b %ERRORLEVEL%
)
if /I "%ACTION%"=="up" (
    echo Running: docker-compose up -d %SERVICE%
    docker-compose up -d %SERVICE%
    exit /b %ERRORLEVEL%
)
if /I "%ACTION%"=="down" (
    echo Running: docker-compose down %SERVICE%
    docker-compose down %SERVICE%
    exit /b %ERRORLEVEL%
)
if /I "%ACTION%"=="shell" (
    echo Running: docker-compose exec %SERVICE% bash
    docker-compose exec %SERVICE% bash
    exit /b %ERRORLEVEL%
)

:: 無効なアクション
echo Error: Invalid action "%ACTION%".
goto show_help

:show_help
echo.
echo Error: Invalid usage.
echo.
echo Usage: z80docker.bat architecture cpu^|gpu exec build^|up^|down^|shell
echo.
echo OPTIONS:
echo   architecture   Specify architecture: cpu or gpu
echo   exec           Specify action: build, up, down, or shell
echo.
exit /b 1
