@echo off

REM - This batch file will clean and build the editor and game code for your Unreal Engine project.

REM - Replace MyAwesomeGame with the name of your project here!!!
set PROJECT_NAME=MyAwesomeGame

if exist "%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" goto Continue

echo.
echo Warning - %USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject does not exist!
echo (edit this batch file in a text editor and set PROJECT_NAME to the name of your project)
echo.

pause

goto Exit

:Continue

if exist CLEAN_FAILED.txt del CLEAN_FAILED.txt
if exist BUILD_TOOLS_FAILED.txt del BUILD_TOOLS_FAILED.txt
if exist BUILD_EDITOR_FAILED.txt del BUILD_EDITOR_FAILED.txt
if exist BUILD_GAME_FAILED.txt del BUILD_GAME_FAILED.txt

REM - We need to check if this is an "Installed Build" (i.e. installed from the Epic Launcher) or a source code build (from GitHub).
REM - We don't clean tools on an installed build.
if exist "Engine\Build\InstalledBuild.txt" (
    goto InstalledBuild
) else (
    goto SourceCodeBuild
)

:InstalledBuild

REM - Check if a .sln file exists for the project, if so, then it is a C++ project and you can clean and build the game editor and game.
REM - (otherwise it's a Blueprint project).
if exist "%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.sln" (
    echo.
    echo %date% %time% Cleaning Game Editor...
    echo.

    call Engine\Build\BatchFiles\Clean.bat -Target="%PROJECT_NAME%Editor Win64 Development" -Project="%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" -WaitMutex -FromMSBuild
    if errorlevel 1 goto Error_CleanFailed

    echo.
    echo %date% %time% Building Game Editor...
    echo.

    call Engine\Build\BatchFiles\RunUAT.bat BuildEditor -Project="%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" -notools
    if errorlevel 1 goto Error_BuildEditorFailed

    echo.
    echo %date% %time% Cleaning Game...
    echo.

    call Engine\Build\BatchFiles\Clean.bat -Target="%PROJECT_NAME% Win64 Development" -Target="%PROJECT_NAME% Win64 Shipping" -Target="%PROJECT_NAME% Win64 DebugGame" -Project="%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" -WaitMutex -FromMSBuild
    if errorlevel 1 goto Error_CleanFailed

    echo.
    echo %date% %time% Building Game...
    echo.

    call Engine\Build\BatchFiles\RunUAT.bat BuildGame -project="%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" -platform=Win64 -notools -configuration=Development+Shipping+DebugGame
    if errorlevel 1 goto Error_BuildGameFailed
) else (
    echo.
    echo You don't need to run this batch file.  There's nothing to build for Blueprint projects.

    goto Exit
)

echo.
echo %date% %time% Done!

goto Exit


:SourceCodeBuild

echo.
echo %date% %time% Cleaning Tools...
echo.

call Engine\Build\BatchFiles\Clean.bat UnrealHeaderTool Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat UnrealPak Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat ShaderCompileWorker Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat UnrealLightmass Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat UnrealFrontend Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat UnrealInsights Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat UnrealMultiUserServer Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat CrashReportClient Win64 Shipping -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat CrashReportClientEditor Win64 Shipping -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed

echo.
echo %date% %time% Cleaning Editor...
echo.

call Engine\Build\BatchFiles\Clean.bat -Target="UE4Editor Win64 Development" -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed

echo.
echo %date% %time% Cleaning Editor Game (UE4Game)...
echo.

call Engine\Build\BatchFiles\Clean.bat UE4Game Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat UE4Game Win64 Shipping -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed
call Engine\Build\BatchFiles\Clean.bat UE4Game Win64 DebugGame -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_CleanFailed

REM - Check if a .sln file exists for the project, if so, then it is a C++ project and you can clean the game editor and game.
REM - (otherwise it's a Blueprint project).
if exist "%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.sln" (
    echo.
    echo %date% %time% Cleaning Game Editor...
    echo.

    call Engine\Build\BatchFiles\Clean.bat -Target="%PROJECT_NAME%Editor Win64 Development" -Project="%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" -WaitMutex -FromMSBuild
    if errorlevel 1 goto Error_CleanFailed

    echo.
    echo %date% %time% Cleaning Game...
    echo.

    call Engine\Build\BatchFiles\Clean.bat -Target="%PROJECT_NAME% Win64 Development" -Target="%PROJECT_NAME% Win64 Shipping" -Target="%PROJECT_NAME% Win64 DebugGame" -Project="%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" -WaitMutex -FromMSBuild
    if errorlevel 1 goto Error_CleanFailed
)

echo.
echo %date% %time% Building Tools...
echo.

Engine\Binaries\DotNET\UnrealBuildTool.exe UnrealFrontend Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_BuildToolsFailed
Engine\Binaries\DotNET\UnrealBuildTool.exe UnrealInsights Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_BuildToolsFailed
Engine\Binaries\DotNET\UnrealBuildTool.exe UnrealMultiUserServer Win64 Development -WaitMutex -FromMSBuild
if errorlevel 1 goto Error_BuildToolsFailed

REM - Other tools will get built by UBT when building editor (when -notools is NOT specified)

echo.
echo %date% %time% Building Editor...
echo.

call Engine\Build\BatchFiles\RunUAT.bat BuildEditor
if errorlevel 1 goto Error_BuildEditorFailed

echo.
echo %date% %time% Building Editor Game (UE4Game)...
echo.

call Engine\Build\BatchFiles\RunUAT.bat BuildGame -platform=Win64 -configuration=Development+Shipping+DebugGame
if errorlevel 1 goto Error_BuildGameFailed

REM - Check if a .sln file exists for the project, if so, then it is a C++ project and you can build the game editor (otherwise it's a Blueprint project).
if exist "%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.sln" (
    echo.
    echo %date% %time% Building Game Editor...
    echo.

    call Engine\Build\BatchFiles\RunUAT.bat BuildEditor -Project="%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" -notools
    if errorlevel 1 goto Error_BuildEditorFailed

    echo.
    echo %date% %time% Building Game...
    echo.

    call Engine\Build\BatchFiles\RunUAT.bat BuildGame -project="%USERPROFILE%\Documents\Unreal Projects\%PROJECT_NAME%\%PROJECT_NAME%.uproject" -platform=Win64 -notools -configuration=Development+Shipping+DebugGame
    if errorlevel 1 goto Error_BuildGameFailed
)

echo.
echo %date% %time% Done!

goto Exit

:Error_CleanFailed
echo.
echo %date% %time% Error - Clean failed!
type NUL > CLEAN_FAILED.txt
goto Exit

:Error_BuildToolsFailed
echo.
echo %date% %time% Error - Build Tools failed!
type NUL > BUILD_TOOLS_FAILED.txt
goto Exit

:Error_BuildEditorFailed
echo.
echo %date% %time% Error - Build Editor failed!
type NUL > BUILD_EDITOR_FAILED.txt
goto Exit

:Error_BuildGameFailed
echo.
echo %date% %time% Error - Build Game failed!
type NUL > BUILD_GAME_FAILED.txt
goto Exit


:Exit
