# Furroke

Furroke is a "KTV"-style karaoke song search and queueing system, based on the PiKaraoke open source project, customized for the Brasil Furfest event (https://brasilfurfest.com.br/) and the Patas event (https://patas.site).

It connects to your TV, and shows a QR code for computers and smartphones to connect to a web interface. From there, multiple users can seamlessly search your local track library, queue up songs, add an endless selection of new karaoke tracks from YouTube, and more. Works on Raspberry Pi, OSX, Windows, and Linux!

## Features

- Web interface for multiple users to queue tracks
- Player/splash screen with connection QR code and "Next up" display
- Searching/browsing a local song library
- Adding new songs from Youtube
- mp3 + cdg support, including compressed .zip bundles
- Pause/Skip/Restart and volume control
- Advanced editing of downloaded file names
- Queue management
- Key Change / Pitch shifting
- Lock down features with admin mode

## Screenshots

### TV

<p float="left">
  <img width="400" alt="Furroke-tv1" src="https://user-images.githubusercontent.com/4107190/95813571-06645600-0ccd-11eb-8341-021a20813990.png">
<img width="400" alt="Furroke-tv2" src="https://user-images.githubusercontent.com/4107190/95813564-019fa200-0ccd-11eb-95e1-57a002c357a3.png">
  </p>

### Web interface

<div style="display: flex">
<img width="250" alt="Furroke-nowplaying" src="https://user-images.githubusercontent.com/4107190/95813193-2cd5c180-0ccc-11eb-89f4-11a69676dc6f.png">
<img width="250" alt="Furroke-queue" src="https://user-images.githubusercontent.com/4107190/95813195-2d6e5800-0ccc-11eb-8f00-1369350a8a1c.png">
<img width="250"  alt="Furroke-browse" src="https://user-images.githubusercontent.com/4107190/95813182-27787700-0ccc-11eb-82c8-fde7f0a631c1.png">
<img width="250"  alt="Furroke-search1" src="https://user-images.githubusercontent.com/4107190/95813197-2e06ee80-0ccc-11eb-9bf9-ddb24d988332.png">
<img width="250"  alt="Furroke-search2" src="https://user-images.githubusercontent.com/4107190/95813190-2ba49480-0ccc-11eb-84e3-f902cbd489a2.png">
</div>

## Supported Devices / OS

Raspberry Pi 3 and above. Anything else will likely be too slow.

Other pi considerations:

- Should be running Raspberry pi desktop OS if running headed, since it requires a browser
- 32-bit version of the OS is recommended. 64-bit seemed slower in my testing, but pi4 and above can probably handle it.
- Disable "screen blanking" in raspi-config if you want to prevent the display from turning off when idle
- Pi3 might struggle a bit with high-res video playback. Overclocking seems to help

Works fine on modern Mac, PCs, and Linux!

## Installation

### General dependencies installation

Install git, if you haven't already.
(on raspberry pi: `sudo apt-get update; sudo apt-get install git`)

Install python3/pip3
(usually raspberry pi OS already has it, run `python3 --version` to check): https://www.python.org/downloads/
Python >= 3.8 is necessary

Clone this repo:

```
git clone https://github.com/MekhyW/Furroke
cd Furroke
```

If you plan to run the splash screen in auto-launch headed mode, you also need to install Chrome browser. On raspberry pi, Chromium should be installed already, which also works fine.

### Raspberry pi / Linux / OSX

Run the setup script to install dependencies and set up the python env:

```
./setup.sh
```

If you're on a raspberry pi or debian system the setup script should have handled installing ffmpeg via apt.

If you're on OSX or another Linux distro, manually install FFMPEG 6.0 or greater from here: https://ffmpeg.org/download.html

On Ubuntu, apt seemed to keep installing an old 4.X version of ffmpeg. I found better luck grabbing a pre-built version of ffmpeg 6.0+ and manually copying it to /usr/bin/. Pre-built releases were obtained from this repo: https://github.com/BtbN/FFmpeg-Builds/releases

### Windows

Manually install ffmpeg 6.0 or greater https://ffmpeg.org/download.html

Run the setup script to install python dependencies:

```
setup-windows.bat
```

Windows firewall may initially block connections to port 5555 and 5556. Be sure to allow these. It should prompt the first time you run Furroke and launch a song. Otherwise, configure it manually in the security settings.

## Launch

cd to the Furroke directory and run:

`./Furroke.sh` (linux/osx/pi) or `./Furroke.bat` (windows)

The app should launch and show the Furroke splash screen and a QR code and a URL. Using a device connected to the same wifi network as the Pi, scan this QR code or enter the URL into a browser. You are now connected! You can start exploring the UI and adding/queuing new songs directly from YouTube.

If you'd like to manually open the splash screen/player or open it on a separate computer's web browser, run `./Furroke.sh --headless` to suppress the launch of the splash screen. Then point your browser the the URL it tells you.

For more options, run `./Furroke.sh --help`

## Auto-start Furroke

This is optional, but you may want to make your raspberry pi a dedicated karaoke device.

```
mkdir /home/pi/.config/autostart
nano /home/pi/.config/autostart/Furroke.desktop
```

Add this to the file, assuming you installed to /home/pi/Furroke, change the Exec path accordingly if not

```
[Desktop Entry]
Type=Application
Name=Furroke
Exec=/home/pi/Furroke/Furroke.sh
```

Restart and it should auto-launch on your next boot.

If you want to kill the Furroke process, you can do so from the Furroke Web UI under: `Info > Quit Furroke`. Or you can ssh in and run `sudo killall python` or something similar.

Note that if your wifi/network is inactive Furroke will error out 10 seconds after being launched. This is to prevent the app from hijacking your ability to login to repair the connection.

## Usage

May not be up to date, run `python3 app.py --help` for the latest:

```
usage: app.py [-h] [-p PORT] [-f FFMPEG_PORT] [-d DOWNLOAD_PATH] [-y YOUTUBEDL_PATH] [-v VOLUME] [-s SPLASH_DELAY] [-t SCREENSAVER_TIMEOUT]
              [-l LOG_LEVEL] [--hide-url] [--prefer-ip] [--hide-raspiwifi-instructions] [--hide-splash-screen] [--dual-screen] [--high-quality]
              [--logo-path LOGO_PATH] [-u URL] [--hide-overlay] [--admin-password ADMIN_PASSWORD] [--window-size WIDTH,HEIGHT]

options:
  -h, --help            show this help message and exit
  -p PORT, --port PORT  Desired http port (default: 5555)
  -f FFMPEG_PORT, --ffmpeg-port FFMPEG_PORT
                        Desired ffmpeg port. This is where video stream URLs will be pointed (default: 5556)
  -d DOWNLOAD_PATH, --download-path DOWNLOAD_PATH
                        Desired path for downloaded songs. (default: ~/Furroke-songs)
  -y YOUTUBEDL_PATH, --youtubedl-path YOUTUBEDL_PATH
                        Path of youtube-dl. (default: /Users/vic/coding/Furroke/.venv/bin/yt-dlp)
  -v VOLUME, --volume VOLUME
                        Set initial player volume. A value between 0 and 1. (default: 0.85)
  -s SPLASH_DELAY, --splash-delay SPLASH_DELAY
                        Delay during splash screen between songs (in secs). (default: 3 )
  -t SCREENSAVER_TIMEOUT, --screensaver-timeout SCREENSAVER_TIMEOUT
                        Delay before the screensaver begins (in secs). (default: 300 )
  -l LOG_LEVEL, --log-level LOG_LEVEL
                        Logging level int value (DEBUG: 10, INFO: 20, WARNING: 30, ERROR: 40, CRITICAL: 50). (default: 20 )
  --hide-url            Hide URL and QR code from the splash screen.
  --prefer-hostname     Use the local hostname instead of the IP as the connection URL. Use at your discretion: mDNS is not guaranteed to work on all
                        LAN configurations. Defaults to False
  --hide-raspiwifi-instructions
                        Hide RaspiWiFi setup instructions from the splash screen.
  --hide-splash-screen, --headless
                        Headless mode. Don't launch the splash screen/player on the Furroke server
  --high-quality        Download higher quality video. Note: requires ffmpeg and may cause CPU, download speed, and other performance issues
  --logo-path LOGO_PATH
                        Path to a custom logo image file for the splash screen. Recommended dimensions ~ 2048x1024px
  -u URL, --url URL     Override the displayed IP address with a supplied URL. This argument should include port, if necessary
  --hide-overlay        Hide overlay that shows on top of video with Furroke QR code and IP
  --admin-password ADMIN_PASSWORD
                        Administrator password, for locking down certain features of the web UI such as queue editing, player controls, song editing,
                        and system shutdown. If unspecified, everyone is an admin.
  --window-size WIDTH,HEIGHT
                        Explicitly set the width and height of the splash screen, where the WIDTH and HEIGHT values are specified in pixels.
```
