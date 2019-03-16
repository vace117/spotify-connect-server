This Docker image runs a Spotify Connect server that will appear in the Device List of any Spotify client connected to the same network. This allows the client to play music through the local sound device of the host where this image is installed. 

This image requires a Linux host with functional ALSA or PulseAudio sound backend.

The Spotify binary in this image is compiled from here: https://github.com/Spotifyd/spotifyd

Installation
============
```bash
wget https://raw.githubusercontent.com/vace117/spotify-connect-server/master/control_scripts/start-spotify-connect-server.sh; chmod +x start-spotify-connect-server.sh

wget https://raw.githubusercontent.com/vace117/spotify-connect-server/master/control_scripts/stop-spotify-connect-server.sh; chmod +x stop-spotify-connect-server.sh
```

Start Spotify Connect Server
=========
```bash
./start-spotify-connect-server.sh \
    [--device-name|-d <Desired_Spotify_Device_Name_No_Spaces>] \
    [--backend|-b <alsa|pulseaudio>]
```

`--device-name` is optional. If you do not specify it, the default is:   `"Dockerized-Spotify-Device"`.

`--backend` is optional. If you do not specify it, the default is: `alsa`.

Stop Spotify Connect Server
=========
```bash
./stop-spotify-connect-server.sh
```