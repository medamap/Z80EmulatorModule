@echo off
setlocal ENABLEDELAYEDEXPANSION

echo Starting z80docker.bat...

:: 引数のチェック
if "%~1"=="" (
    echo Error: No arguments provided.
    goto show_help
)

:: 変数の初期化
set "ARCH="
set "ACTION="

:: 引数の解析
:parse_args
if "%~1"=="" goto end_parse_args
echo Remaining arguments: "%~1" "%~2" "%~3" "%~4"

if /I "%~1"=="architecture" (
    shift
    if "%~1"=="" (
        echo Error: Missing value for architecture.
        goto show_help
    )
    set "ARCH=%~1"
    shift
    echo After setting ARCH: ARCH=%ARCH%
    goto parse_args
)

if /I "%~1"=="exec" (
    shift
    if "%~1"=="" (
        echo Error: Missing value for exec.
        goto show_help
    )
    set "ACTION=%~1"
    shift
    echo After setting ACTION: ACTION=%ACTION%
    goto parse_args
)

echo Error: Unknown argument "%~1"
goto show_help

:end_parse_args

:: ARCHとACTIONのチェック
if "%ARCH%"=="" (
    echo Error: Missing architecture argument.
    goto show_help
)
if "%ACTION%"=="" (
    echo Error: Missing exec argument.
    goto show_help
)

:: ARCH に基づいた SERVICE の決定
if /I "%ARCH%"=="cpu" (
    set "SERVICE=z80-cpu"
)
if /I "%ARCH%"=="gpu" (
    set "SERVICE=z80-gpu"
)

:: SERVICEが設定されていない場合、エラー
if "%SERVICE%"=="" (
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
