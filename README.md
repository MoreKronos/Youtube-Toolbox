# YouTube Toolbox

> For an easier installation experience, it is **recommended** to download and use the Setup Wizard:  
> [Download Setup Wizard.exe](https://github.com/MoreKronos/Youtube-Toolbox/raw/refs/heads/main/Setup%20Wizard.exe)

A Windows batch-powered toolset for downloading and organizing YouTube music, podcasts, playlists, and audio content locally with minimal effort.  
This project leverages `yt-dlp`, `ffmpeg`, and a custom `Dupefinder` system to fetch, convert, rename, and clean your music library automatically.

---

## 💡 Features

- 📥 Download YouTube videos, full playlists, and podcasts as high-quality MP3s  
- 🎵 **Fully supports single videos and playlists (fixed in latest update)**  
- 🧠 Automatic file organization with clean numbering or randomized naming  
- 🗃️ Duplicate detection and removal using metadata (title + artist)  
- ⚡ Improved download engine stability and faster execution  
- 🧰 Automatic dependency handling (`yt-dlp`, `ffmpeg`, `7-Zip`, `dupefinder.ps1`)  
- 🔧 Improved error handling and input validation (no more broken URLs or invalid inputs)  
- 🎛️ Cleaner UI output with better download status feedback  

---

## 🆕 Latest Improvements

- ✔ Fixed single video downloads (previously unstable / failing)  
- ✔ Fixed playlist detection and processing  
- ✔ Fixed URL parsing issues (`&si=` and special YouTube parameters)  
- ✔ Fixed ffmpeg path handling and post-processing errors  
- ✔ Improved UI flow and download status clarity  
- ✔ Improved overall performance and stability  
- ✔ Fixed file output consistency across playlists and single downloads  
- ✔ Better error prevention before yt-dlp execution  

---

## ⚙️ Dependencies

The following tools are automatically downloaded or included:

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) — YouTube downloader with metadata support  
- [FFmpeg](https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z) — Audio processing and conversion  
- [7-Zip Portable](https://github.com/MoreKronos/7-zip-portable) — Archive extraction utility  
- [Dupefinder Script](https://github.com/MoreKronos/Dupefinder) — Custom duplicate MP3 detection and cleanup  

---

## 🚀 Usage

1. Download or clone this repository  
2. Run `Youtube Toolbox.exe` as Administrator  
3. Enter a YouTube URL:
   - Single video → automatically detected
   - Playlist → automatically detected  
4. The tool will:
   - Download audio
   - Convert to MP3
   - Organize files
   - Rename or clean duplicates  
5. Output is saved in the `music_files` folder  

---

## 🔒 Security & Privacy

- Runs fully locally — no external servers used  
- No personal data is collected or transmitted  
- All downloads use publicly available YouTube URLs  
- You maintain full control of your files at all times  

---

## 📝 License

Copyright (c) 2026 **[MoreKronos](https://github.com/MoreKronos)**

All rights reserved.

Permission is granted to use this software **only** in its original form and for its intended purpose.  

No part of this software may be copied, modified, distributed, sublicensed, or incorporated into derivative works without express written permission from the copyright holder.

This license does **not** grant rights to reverse engineer, decompile, or disassemble the software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

The copyright holder shall not be liable for any damages arising from use of this software.

---

## 📬 Contact

Discord: **itskronosyt**  
https://discordapp.com/users/589826883596713998
