@echo off
setlocal enabledelayedexpansion

title Youtube Toolbox
color 0B

:check
:: --------------------------------------------------
:: Automatically get the folder where this script is running
:: --------------------------------------------------
set "base_folder=%~dp0"
set "base_folder=%base_folder:~0,-1%"

:: Set folders
set "downloads_folder=%base_folder%\downloads"
if not exist "%downloads_folder%" mkdir "%downloads_folder%"

set "target_folder=%base_folder%\music_files"

:: Paths to executables (make sure folder names are consistent)
set "yt_dlp_path=%base_folder%\scripts\yt-dlp\yt-dlp.exe"
set "ffmpeg_path=%base_folder%\scripts\ffmpeg\bin"
set "ffmpeg_check=%ffmpeg_path%\ffmpeg.exe"
set "sevenzip_path=%base_folder%\scripts\7zip\7z.exe"
set "dupefinder_path=%base_folder%\scripts\dupefinder\dupefinder.ps1"
set "downloads_folder_local=%USERPROFILE%\Downloads"

:: Fix duplicate and inconsistent 7zip folder name - choose one and remove the other
:: Removed duplicate sevenzip_path with "7zip" folder; keeping "7-zip"
:: set "sevenzip_path=%base_folder%\scripts\7zip\7z.exe"  <-- Remove or comment this

:: Initialize these variables empty
set "archive_file="
set "extracted_folder="

REM Now you can safely use these variables, e.g.
REM "%ffmpeg_path%\ffmpeg.exe" -i "input.mp4" output.wav

if not exist "%yt_dlp_path%" (
    echo [ERROR] yt-dlp.exe not found at "%yt_dlp_path%"
	goto downloadyt-dlp
)

if not exist "%ffmpeg_check%" (
    echo [ERROR] ffmpeg not found at "%ffmpeg_check%"
	
    goto downloadffmpeg
)

if not exist "!dupefinder_path!" (
    echo [ERROR] Dupefinder not found at "!dupefinder_path!"
    goto downloaddupefinder
)

goto Welcome

:downloadyt-dlp
cls
title yt-dlp Downloader
color 0B
echo ==================================================
echo                 yt-dlp Downloader
echo ==================================================
echo yt-dlp is required to run this program
echo.

echo.
setlocal enabledelayedexpansion

set /p yt_dlp=Download Required (Y/N): 

if /i "%yt_dlp%"=="Y" (
    echo.
    echo Opening download page in your default browser...
    taskkill /F /IM chrome.exe >nul 2>&1
    start "" "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"

    echo.
    echo Waiting for the download to complete...
    call :WaitForFilePattern "!downloads_folder_local!" "yt-dlp.exe"

    echo.
    echo Download detected!

    rem Locate downloaded file
    for %%F in ("%downloads_folder_local%\yt-dlp.exe") do (
        set "downloaded_file=%%~fF"
    )

    echo downloaded_file is "!downloaded_file!"
    echo.

    if "!downloaded_file!"=="" (
        echo ERROR: No yt-dlp.exe file found!
		timeout /t 5 >nul
		goto check
    )

    echo Copying yt-dlp.exe to scripts folder...
    if not exist "!base_folder!\scripts\yt-dlp" (
        mkdir "!base_folder!\scripts\yt-dlp"
    )
    copy /y "!downloaded_file!" "!base_folder!\scripts\yt-dlp\yt-dlp.exe" >nul

    if not exist "!base_folder!\scripts\yt-dlp\yt-dlp.exe" (
        echo ERROR: Failed to copy yt-dlp.exe.
		timeout /t 5 >nul
		goto check
    )

    echo Cleaning up...
    echo Deleting downloaded yt-dlp.exe from Downloads folder
    del /f /q "!downloaded_file!"

    echo.
    echo yt-dlp successfully installed!
    timeout /t 2 >nul
    endlocal
    goto check

) else if /i "%yt-dlp%"=="N" (
    echo Please Type Y.
    timeout /t 2 >nul
    endlocal
    goto check
) else (
    echo Invalid input. Please enter Y or N.
	timeout /t 2 >nul
    goto check
)

:downloadffmpeg
cls
title FFMPEG Downloader
color 0B
echo ==================================================
echo                 FFMPEG Downloader
echo ==================================================
echo FFMPEG is required to run this program
echo.

setlocal enabledelayedexpansion

set /p ffmpeg_choice=Download now? (Y/N): 

if /i "!ffmpeg_choice!"=="Y" (
    echo.
    echo Opening download page in your default browser...
    start "" "https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z"

    echo.
    echo Waiting for the download to complete...
    call :WaitForFilePattern "!downloads_folder_local!" "*full_build.7z"

    echo.
    echo Download detected!

    rem Locate downloaded file
    for %%F in ("!downloads_folder_local!\*full_build.7z") do (
        set "archive_file=%%~fF"
        set "extracted_folder=%%~nF"
    )

    echo archive_file is "!archive_file!"
    echo extracted_folder is "!extracted_folder!"
    echo.

    if "!archive_file!"=="" (
        echo ERROR: No ffmpeg file found!
		timeout /t 5 >nul
		goto check
    )

    echo Extracting "!archive_file!" to "!downloads_folder!"...
    "!sevenzip_path!" x "!archive_file!" -o"!downloads_folder!" -y
    if errorlevel 1 (
        echo Extraction failed with error code !errorlevel!.
		timeout /t 5 >nul
		goto check
    )

    if not exist "!base_folder!\scripts\ffmpeg" (
        mkdir "!base_folder!\scripts\ffmpeg"
    )

    echo Copying bin folder...
    echo From: "!downloads_folder!\!extracted_folder!\bin"
    echo To:   "!base_folder!\scripts\ffmpeg\bin"

    xcopy /e /i /y "!downloads_folder!\!extracted_folder!\bin" "!base_folder!\scripts\ffmpeg\bin" >nul

    if not exist "!base_folder!\scripts\ffmpeg\bin\ffmpeg.exe" (
        echo ERROR: Failed to copy ffmpeg binaries.
		timeout /t 5 >nul
		goto check
    )

    echo Cleaning up...
    echo Deleting extracted folder: "!downloads_folder!\!extracted_folder!"
    rmdir /s /q "!downloads_folder!\!extracted_folder!"

    echo Deleting archive file: "!archive_file!"
    del /f /q "!archive_file!"

if exist "%archive_file%" (
    echo Deleting downloaded archive file: "%archive_file%"
    del /f /q "%archive_file%"
    if errorlevel 1 (
        echo Failed to delete "%archive_file%"
    ) else (
        echo Deleted successfully.
    )
) else (
    echo Archive file "%archive_file%" not found, nothing to delete.
)

    echo.
    echo FFmpeg successfully installed!
    timeout /t 2 >nul
    endlocal
    goto check

) else if /i "!ffmpeg_choice!"=="N" (
    echo Skipping download step.
    timeout /t 2 >nul
    endlocal
    goto check
) else (
    echo Invalid input. Please enter Y or N.
    timeout /t 2 >nul
    endlocal
    goto check
)

:downloaddupefinder
cls
title Dupefinder Downloader
color 0B
echo ==================================================
echo              Dupefinder Downloader
echo ==================================================
echo Dupefinder is required to run this program.
echo.

setlocal enabledelayedexpansion

set /p dupefinder_dl=Download Dupefinder archive now? (Y/N): 

if /i "!dupefinder_dl!"=="Y" (
    echo.
    echo Opening download page in your default browser...
    taskkill /F /IM chrome.exe >nul 2>&1
    start "" "https://github.com/MoreKronos/Dupefinder/archive/refs/heads/main.zip"

    echo.
    echo Waiting for the download to complete...
    call :WaitForFilePattern "!downloads_folder_local!" "Dupefinder-main.zip"

    echo.
    echo Download detected!

    rem Locate downloaded file
    for %%F in ("!downloads_folder_local!\Dupefinder-main.zip") do (
        set "downloaded_file=%%~fF"
    )

    echo Downloaded file: "!downloaded_file!"
    echo.

    if "!downloaded_file!"=="" (
        echo ERROR: No Dupefinder-main.zip file found!
        timeout /t 5 >nul
        goto check
    )

    echo Extracting Dupefinder archive...
    if not exist "!base_folder!\scripts\dupefinder" (
        mkdir "!base_folder!\scripts\dupefinder"
    )

    rem Extract to downloads folder temporarily
    "!sevenzip_path!" x "!downloaded_file!" -o"!downloads_folder!\dupefinder_extract" -y
    if errorlevel 1 (
        echo ERROR: Extraction failed with error code !errorlevel!.
        timeout /t 5 >nul
        goto check
    )

    rem Copy only the dupefinder.ps1 file into scripts\dupefinder
    copy /y "!downloads_folder!\dupefinder_extract\Dupefinder-main\dupefinder.ps1" "!base_folder!\scripts\dupefinder\dupefinder.ps1" >nul

    if not exist "!base_folder!\scripts\dupefinder\dupefinder.ps1" (
        echo ERROR: Failed to copy dupefinder.ps1.
        timeout /t 5 >nul
        goto check
    )

    echo Cleaning up...
    rem Delete the extracted folder
    rmdir /s /q "!downloads_folder!\dupefinder_extract"

    rem Delete the downloaded zip
    del /f /q "!downloaded_file!"

    echo.
    echo Dupefinder successfully installed!
    timeout /t 2 >nul
    endlocal
    goto check

) else if /i "!dupefinder_dl!"=="N" (
    echo Please type Y to download.
    timeout /t 2 >nul
    endlocal
    goto check
) else (
    echo Invalid input. Please enter Y or N.
    timeout /t 2 >nul
    goto check
)

:WaitForFilePattern
setlocal
set "folder=%~1"
set "pattern=%~2"
set "lastSize=0"
set /a stableCount=0

:WaitLoopPattern
for %%F in ("%folder%\%pattern%") do (
    set "filePath=%%~fF"
    goto FileFoundPattern
)
timeout /t 2 >nul
goto WaitLoopPattern

:FileFoundPattern
for %%I in ("%filePath%") do set "currentSize=%%~zI"

if "%currentSize%"=="%lastSize%" (
    set /a stableCount+=1
) else (
    set "lastSize=%currentSize%"
    set /a stableCount=0
)

if %stableCount% geq 3 (
    endlocal & exit /b
)

timeout /t 2 >nul
goto WaitLoopPattern

:Welcome
cls
title Welcome
color 0B
echo ==================================================
echo                      Welcome
echo ==================================================
echo.
timeout /t 2 >nul

:DownloadPrompt
cls
color 0B
title YouTube Music Downloader
echo ==================================================
echo                YouTube Music Downloader
echo ==================================================
echo.

set /p music_download=Do you want to download music from YouTube? (Y/N): 

if /i "%music_download%"=="Y" (
    cls
	goto Download
    timeout /t 2 >nul
) else if /i "%music_download%"=="N" (
    echo Skipping download step.
    timeout /t 2 >nul
	goto Organizer
) else (
    echo Invalid input. Please enter Y or N.
    timeout /t 2 >nul
    goto DownloadPrompt
)
:Download
cls
echo ==================================================
echo             YouTube Music Downloader
echo ==================================================
echo This tool supports downloading single videos or full playlists.
echo Output files will be saved to the "downloads" folder.
echo.

echo Base folder: "%base_folder%"
echo Target folder: "%target_folder%"

:: Prompt user without breaking on &
set /p yt_url=Enter YouTube playlist or video URL: 
:: Remove any surrounding quotes user might add (optional)
set "yt_url=%yt_url:"=%"

if "%yt_url%"=="" (
    echo.
    echo [ERROR] No URL entered.
    timeout /t 2 >nul
    goto InputURL
)

:: If URL contains playlist (list=), keep it as-is, else try to shorten single video URLs
echo !yt_url! | findstr /i "list=" >nul
if not errorlevel 1 (
    rem URL has playlist parameter, keep full URL
    set "clean_url=!yt_url!"
) else (
    rem No playlist, check if it has watch?v=
    echo !yt_url! | findstr /i "watch?v=" >nul
    if not errorlevel 1 (
        rem Extract video ID after v=
        for /f "tokens=2 delims==&" %%B in ("!yt_url!") do set "video_id=%%B"
        set "clean_url=https://youtu.be/!video_id!"
    ) else (
        rem Use input as is (for already short URLs)
        set "clean_url=!yt_url!"
    )
)
set "yt_url=!clean_url!"
cls

:: Check yt-dlp existence
if not exist "%yt_dlp_path%" (
    echo [ERROR] yt-dlp.exe not found at "%yt_dlp_path%"
    pause
    goto InputURL
)

:: Check ffmpeg existence
if not exist "%ffmpeg_path%" (
    echo [ERROR] ffmpeg folder not found at "%ffmpeg_path%"
    pause
    goto InputURL
)

:: Make sure downloads folder exists
if not exist "%downloads_folder%" mkdir "%downloads_folder%"

echo ==================================================
echo Downloading and converting audio...
echo ==================================================
echo.

"%yt_dlp_path%" ^
    --extract-audio ^
    --audio-format mp3 ^
    --audio-quality 0 ^
    --output "%downloads_folder%\%%(autonumber)04d.%%(ext)s" ^
    --embed-thumbnail ^
    --add-metadata ^
    --ffmpeg-location "%ffmpeg_path%" ^
    --geo-bypass ^
    --sleep-interval 3 ^
    --max-sleep-interval 8 ^
    --limit-rate 1M ^
    --retries infinite ^
    --fragment-retries infinite ^
    --concurrent-fragments 1 ^
    --cookies "%base_folder%\cookies.txt" ^
    "!yt_url!"

echo.
echo ==================================================
echo             Download Complete!
echo ==================================================
echo.

:: Start renaming downloaded files to random numbers
echo Renaming downloaded files to random numbers...

pushd "%downloads_folder%"

setlocal enabledelayedexpansion
set "usedNumbers="

for %%F in (*.*) do (
    set "ext=%%~xF"

    :genRand
    set /a randNum=%random% * 65536 + %random%
    set /a randNum=randNum %% 200000 + 2000000

    echo !usedNumbers! | findstr /c:"!randNum! " >nul
    if not errorlevel 1 (
        goto genRand
    )

    set "usedNumbers=!usedNumbers!!randNum! "

    ren "%%F" "!randNum!!ext!"
    echo Renamed "%%F" to "!randNum!!ext!"
)

endlocal
popd

echo Renaming done.
timeout /t 2 >nul

goto Organizer
:Organizer
title Youtube Toolbox
color 0B
cls
echo ==================================================
echo            Welcome to Youtube Toolbox
echo ==================================================
echo.
echo This tool will:
echo    - Rename your MP3 files with clean, zero-padded numbers
echo    - Detect and handle duplicate songs
echo    - Organize your "music_files" folder quickly and cleanly
echo    - Allow you to type commands to perform specific actions
echo.

set /p "choice=Do you want to continue? (Y/N) or type a command: "

if /i "!choice!"=="Y" goto Continue

if /i "!choice!"=="N" (
    for /L %%x in (5,-1,1) do (
		title Goodbye
        cls
        echo ==================================================
        echo           Operation Cancelled by %USERNAME%
        echo ==================================================
        echo.
        echo Exiting in %%x seconds...
        timeout /t 1 >nul
    )
    cls
    echo ==================================================
    echo             Goodbye %USERNAME%
    echo ==================================================
    timeout /t 1 >nul
    exit /b
)

if /i "!choice!"=="commands" (
	title Commands
    cls
    echo.
    echo You have 5 seconds to review the commands...
    echo ===================================================
    echo                   Commands
    echo ===================================================
    echo.
    echo Available commands:
    echo  - exit      - Exit the program
    echo  - download  - Go to the download process
    echo.
    timeout /t 5 >nul
    goto Organizer
)

if /i "!choice!"=="download" goto DownloadPrompt
if /i "!choice!"=="exit" goto Exit

echo.
echo Invalid input. Please enter Y, N, or a valid command.
echo.
timeout /t 3 >nul
goto Organizer

:Continue
setlocal enabledelayedexpansion
title Preparing
cls
echo ==================================================
echo           Preparing Your Music Folder...
echo ==================================================

cd /d "%target_folder%"

set max=0
set /a count=1

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0scripts\dupefinder\dupefinder.ps1'"

timeout /t 5 >nul
title Organizing and Renaming Files...
for /L %%i in (1,1,1) do (	
    cls
    echo.
    echo --------------------------------------------------
    echo          Organizing and Renaming Files...
    echo --------------------------------------------------
    echo.
    set /a count=1
    for %%F in (*.mp3) do (
        set "filename=%%~nF"
        echo !filename! | findstr /r "^[0-9][0-9][0-9][0-9][0-9]$" >nul
        if errorlevel 1 (
            set "num=00000!count!"
            set "num=!num:~-5!"
            echo - Renaming "%%F" to "!num!%%~xF"
            ren "%%F" "!num!%%~xF"
            set /a count+=1
        ) else (
            echo - Skipping already numbered file: %%F
        )
    )
)

echo.
title complete.
echo - File numbering complete.
echo.

timeout /t 3 >nul

echo ==================================================
echo  All done! Your music_files folder is organized.
echo ==================================================
echo.
goto Exit
:Exit
title Exiting
color 0B
for /L %%x in (5,-1,1) do (
    cls
    echo ==================================================
    echo   All done! Your music_files folder is organized.
    echo ==================================================
    echo.
    echo Exiting in %%x seconds...
    timeout /t 1 >nul
)
title Goodbye
cls
echo ==================================================
echo             Goodbye %USERNAME%
echo ==================================================
timeout /t 1 >nul
exit /f
