#!/bin/bash

cd /root

DEVICE_NAME=${DEVICE_NAME:-"Dockerized-Spotify-Device"}
BACKEND=${BACKEND:-"alsa"} # Valid values are 'alsa' or 'pulseaudio'

#
# Note: There's a bug in spotifyd, where specifying '--backend pulseaudio' in CLI does not work.
#   https://github.com/Spotifyd/spotifyd/issues/170
#
# There's a workaround though. We can specify 'backend = pulseaudio' in spotifyd.conf,
# which does work. If we want ALSA, we specify '--backend alsa', which correctly overrides
# 'pulseaudio' in the config file.
# 

./spotifyd --no-daemon --device_name $DEVICE_NAME --backend $BACKEND