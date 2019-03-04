#!/bin/bash

cd /root

DEVICE_NAME=${DEVICE_NAME:-"Dockerized-Spotify-Device"}

./spotifyd --no-daemon --bitrate 320 --device_name $DEVICE_NAME