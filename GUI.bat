@echo off
setlocal enabledelayedexpansion

:: Check if input file exists
if not exist "videos.txt" (
    echo Error: videos.txt not found.
    echo Please create a file named videos.txt with YouTube URLs.
    pause
    exit /b 1
)

:: Check if yt-dlp exists
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: yt-dlp not found.
    echo Please ensure yt-dlp is installed and in your system PATH
    echo You can download it from: https://github.com/yt-dlp/yt-dlp
    pause
    exit /b 1
)

echo YouTube Batch Downloader (using yt-dlp^)
echo =====================================
echo.
echo Common resolution codes:
echo 1080p = 137+140 (HD video + audio^)
echo 720p  = 22    (MP4 with audio^)
echo 480p  = 135+140 (video + audio^)
echo 360p  = 18    (MP4 with audio^)
echo.
echo Notes:
echo - Use 'bestvideo+bestaudio' for highest quality
echo - Use 'best' for best quality single file
echo - Add [ext=mp4] to force MP4 format, e.g.: bestvideo[ext=mp4]+bestaudio[ext=m4a]
echo.

:: Process each URL
for /f "tokens=*" %%a in (videos.txt) do (
    echo.
    echo Processing URL: %%a
    echo.
    
    :: Check if URL contains playlist
    yt-dlp --flat-playlist --dump-single-json "%%a" > temp.json 2>&1
    findstr /C:"_type\": \"playlist\"" temp.json >nul
    if !errorlevel! equ 0 (
        echo This URL contains a playlist.
        set /p playlist_choice="Do you want to download [1] Just this video or [2] Entire playlist? (1/2): "
        
        if "!playlist_choice!"=="2" (
            echo.
            echo Available formats for videos:
            echo -------------------------------
            yt-dlp -F "%%a"
        ) else (
            echo.
            echo Available formats for this video:
            echo -------------------------------
            yt-dlp --no-playlist -F "%%a"
        )
    ) else (
        echo Available formats for this video:
        echo -------------------------------
        yt-dlp --no-playlist -F "%%a"
    )
    
    del temp.json >nul 2>&1
    
    echo -------------------------------
    echo.
    echo How to select resolution:
    echo 1. Look at the format codes above
    echo 2. For best quality with audio, use: bestvideo+bestaudio
    echo 3. For specific resolution, use format code like: 137+140
    echo 4. For simple format, use single code like: 22 for 720p
    echo.
    set /p format="Enter the format code for desired resolution: "
    
    echo.
    if "!playlist_choice!"=="2" (
        echo Downloading playlist with format code !format!...
        yt-dlp -f !format! "%%a" --progress
    ) else (
        echo Downloading video with format code !format!...
        yt-dlp --no-playlist -f !format! "%%a" --progress
    )
    
    if !errorlevel! neq 0 (
        echo Error downloading. Continuing with next URL...
    ) else (
        echo Download completed successfully.
    )
    
    echo.
    echo ------------------------
    set "playlist_choice="
)

echo.
echo All downloads completed.
pause