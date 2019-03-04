This Docker image runs a Spotify Connect server that will appear in the Device List of any Spotify client device connected to the same network. This allows the client to play music through the local ALSA device of the host where this image is installed. 

This image requires the host to have a functional ALSA device, accessible by the root user.

Installation
============
```bash
docker pull vace117/spotify-connect-server
```

Execution
=========
```bash
docker run -e DEVICE_NAME=<Device_Name_No_Spaces> --device /dev/snd --net host vace117/spotify-connect-server
```

`DEVICE_NAME` is optional. If you do not specify it, the default is:   `"Dockerized-Spotify-Device"`.