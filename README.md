This Docker image runs a Spotify Connect server that will appear in the Device List of any Spotify client device connected to the same network. This allows the client to play music through the local sound device of the host where this image is installed. 

This image requires the host to have functional ALSA or PulseAudio.

The Spotify binary in this image is compiled from here: https://github.com/Spotifyd/spotifyd

Installation
============
```bash
git clone https://github.com/vace117/spotify-connect-server.git
```

Start Spotify Connect Server
=========
```bash
cd spotify-connect-server.git/control_scripts/

./start-spotify-connect-server.sh [--device-name|-d <Desired_Spotify_Device_Name_No_Spaces>] [--backend|-b <alsa|pulseaudio>]
```

`--device-name` is optional. If you do not specify it, the default is:   `"Dockerized-Spotify-Device"`.

`--backend` is optional. If you do not specify it, the default is: `alsa`.

Stop Spotify Connect Server
=========
```bash
cd spotify-connect-server.git/control_scripts/

./stop-spotify-connect-server.sh
```