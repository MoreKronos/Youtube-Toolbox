# YouTube Toolbox

> For an easier installation experience, it is **recommended** to download and use the Setup Wizard:  
> [Download Setup.Wizard.exe](https://github.com/MoreKronos/Youtube-Toolbox/raw/refs/heads/main/Setup%20Wizard.exe)

A Windows batch-powered toolset for downloading and organizing YouTube music, podcasts, playlists, and other audio content locally with minimal effort. This project leverages `yt-dlp`, `ffmpeg`, and a custom `Dupefinder` script to fetch, rename, clean, and deduplicate your MP3 audio library.

---

## 💡 Features

- 📥 Download YouTube videos, full playlists, and podcasts as high-quality MP3s  
- 🧠 Automatically rename files with clean, zero-padded numbering for perfect sorting  
- 🗃️ Detect and remove duplicate MP3s based on metadata tags such as title and artist  
- 🧰 Automatically installs and updates dependencies like `yt-dlp`, `7-Zip`, `ffmpeg`, and `dupefinder.ps1`  
- 🎛️ Supports batch downloads and handles various YouTube content types including music videos, podcasts, and audio playlists  

---

## ⚙️ Dependencies

The following tools are automatically downloaded or included with this program:

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) — YouTube downloader with extensive format and metadata support  
- [FFmpeg](https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z) — Audio and video processing  
- [7-Zip Portable](https://github.com/MoreKronos/7-zip-portable) — Archive extraction utility  
- [Dupefinder Script](https://github.com/MoreKronos/Dupefinder) — Custom duplicate MP3 detection and cleanup  

---

## 🚀 Usage

1. **Download or clone** this repository to your Windows machine.  
2. **Run the main batch script** (e.g., `YoutubeToolbox.exe`) as Administrator.  
3. Follow the on-screen prompts to:  
    - Download music, podcasts, or playlists by entering YouTube URLs.  
    - Automatically organize and rename your downloaded audio files.  
    - Remove duplicate tracks using metadata analysis.  
4. The tool will automatically detect and install any missing dependencies as needed.  
5. Your organized MP3 files will be saved inside the `music_files` folder in the base directory.

---

## 🔒 Security & Privacy

- This tool runs **entirely locally** — no data or files are sent to external servers.  
- No personal information, credentials, or download history is collected or shared.  
- Downloads are performed anonymously using publicly available YouTube URLs.

You remain in full control of your content at all times.

---

## 📝 License

Copyright (c) 2025 **[MoreKronos](https://github.com/MoreKronos)**

All rights reserved.

Permission is granted to use this software **only** in its original form and for its intended purpose.  

No part of this software may be copied, modified, distributed, sublicensed, or incorporated into derivative works without express written permission from the copyright holder.

This license does **not** grant rights to reverse engineer, decompile, or disassemble the software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT.

The copyright holder shall not be liable for any damages arising from use of this software.

---

## 📬 Contact

If you have questions or feature requests, reach out on Discord:  
**[itskronosyt](http://discordapp.com/users/589826883596713998)**
