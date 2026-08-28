@echo off
setlocal EnableExtensions
cd /d "%~dp0"

title DeltaruneVita - Prepare Texture Cache v0.3.6-r2

set "CURRENT_DIR=%~dp0"
for %%I in ("%~dp0..") do set "PARENT_DIR=%%~fI"

rem =========================================================================
rem Automatic migration from the most recent previous version found
rem side-by-side. Existing files in the new version are NOT overwritten.
rem =========================================================================

for %%V in (
    prepare_texture_cache_v0_3_5
    prepare_texture_cache_v0_3_4
    prepare_texture_cache_v0_3_3
    prepare_texture_cache_v0_3_2
    prepare_texture_cache_v0_3_1
    prepare_texture_cache_v0_3
) do (
    if exist "%PARENT_DIR%\%%V\" (
        echo [MIGRATE] Usando arquivos existentes de %%V

        if exist "%PARENT_DIR%\%%V\chapters\" (
            if not exist "%CURRENT_DIR%chapters\" mkdir "%CURRENT_DIR%chapters" >nul 2>&1
            robocopy "%PARENT_DIR%\%%V\chapters" "%CURRENT_DIR%chapters" /E /XC /XN /XO /NFL /NDL /NJH /NJS /NP >nul
        )

        if exist "%PARENT_DIR%\%%V\source\UTMT_CLI\" (
            if not exist "%CURRENT_DIR%source\UTMT_CLI\" mkdir "%CURRENT_DIR%source\UTMT_CLI" >nul 2>&1
            robocopy "%PARENT_DIR%\%%V\source\UTMT_CLI" "%CURRENT_DIR%source\UTMT_CLI" /E /XC /XN /XO /NFL /NDL /NJH /NJS /NP >nul
        )

        if exist "%PARENT_DIR%\%%V\source\PVRTexToolCLI\" (
            if not exist "%CURRENT_DIR%source\PVRTexToolCLI\" mkdir "%CURRENT_DIR%source\PVRTexToolCLI" >nul 2>&1
            robocopy "%PARENT_DIR%\%%V\source\PVRTexToolCLI" "%CURRENT_DIR%source\PVRTexToolCLI" /E /XC /XN /XO /NFL /NDL /NJH /NJS /NP >nul
        )

        if exist "%PARENT_DIR%\%%V\source\renderer_reference\" (
            if not exist "%CURRENT_DIR%source\renderer_reference\" mkdir "%CURRENT_DIR%source\renderer_reference" >nul 2>&1
            robocopy "%PARENT_DIR%\%%V\source\renderer_reference" "%CURRENT_DIR%source\renderer_reference" /E /XC /XN /XO /NFL /NDL /NJH /NJS /NP >nul
        )

        goto :migration_done
    )
)

:migration_done

where python >nul 2>&1
if errorlevel 1 (
    cls
    echo ====================================================================================
    echo  DELTARUNEVITA - PREPARE TEXTURE CACHE v0.3.6-r2
    echo ====================================================================================
    echo.
    echo  ERRO: Python nao foi encontrado no PATH.
    echo.
    pause
    exit /b 1
)

python "%~dp0source\prepare_texture_cache_v0_3_6.py"
set "EXITCODE=%ERRORLEVEL%"

if not "%EXITCODE%"=="0" (
    echo.
    echo Processo terminou com erro ^(%EXITCODE%^).
    echo.
    pause
)

exit /b %EXITCODE%
