# Video Downloader with YouTube Links

This project allows you to easily download videos from YouTube by following a simple setup process. 🚀

---

## Features
- Download multiple videos by adding their YouTube links.
- Simple graphical interface for ease of use.
- **Smart Playlist Detection**: If a link is part of a playlist, the program will prompt you to download the entire playlist or just the specific video.

---

## Requirements
Before running the project, you need to install **FFmpeg**. FFmpeg is a crucial dependency for this tool to work correctly. 

### Install FFmpeg
1. Follow the detailed steps provided [here](https://www.geeksforgeeks.org/how-to-install-ffmpeg-on-windows/) (right-click and choose "Open in new tab" to avoid leaving this page).
2. Ensure FFmpeg is properly added to your system's PATH variable.

---

## How to Use
1. Clone or download this repository to your local machine.
2. Open the `videos.txt` file and:
   - Add YouTube links, **one link per line**.
   - Save the file once you're done.
3. Double-click `GUI.bat` to start the application.
4. Follow the instructions in the graphical interface:
   - If a link is from a playlist, choose whether to download the **entire playlist** or just the **specific video**.
   - Monitor the progress as your videos download.

---

## Example `videos.txt` File
```text
https://www.youtube.com/watch?v=example1
https://www.youtube.com/watch?v=example2&list=playlistID
https://www.youtube.com/watch?v=example3
