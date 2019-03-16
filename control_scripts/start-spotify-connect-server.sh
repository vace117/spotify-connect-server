#!/bin/bash

usage() {
    echo
	echo "  Usage: $0 [--device-name|-d <Desired_Spotify_Device_Name_No_Spaces>] [--backend|-b <alsa|pulseaudio>] "
    echo
	exit 1
}

consume_arguments() {
	while [[ $# -gt 0 ]]; do
	case $1 in
	    --help)
            usage
            exit 0
	    ;;

	    -d|--device-name)
		    DEVICE_NAME="$2"
		    shift # consume argument
		    shift # consume value
	    ;;

        -b|--backend)
            BACKEND="$2"
            shift # consume argument
            shift # consume value
        ;;

		*)    # unknown option
			echo "Error: Unknown option $1"
			exit 2
    	;;

	esac
	done
}


consume_arguments $*

DOCKER_ENV_VARS=""
VALID_BACKENDS=("alsa" "pulseaudio")

if [[ ! -z $DEVICE_NAME ]]; then
    echo " - Setting your Spotify Device Name to: '$DEVICE_NAME'"
    DOCKER_ENV_VARS="-e DEVICE_NAME=$DEVICE_NAME"
fi

if [[ -z $BACKEND ]]; then
    BACKEND="alsa"
else
    if [[ ! " ${VALID_BACKENDS[@]} " =~ " ${BACKEND} " ]]; then
        echo "  Error: Invalid backend. Valid backends are 'alsa' or 'pulseaudio'."
        exit 1
    fi
    DOCKER_ENV_VARS="$DOCKER_ENV_VARS -e BACKEND=$BACKEND"
fi


echo " - Using sound backend: $BACKEND"
if [ "$BACKEND" = "alsa" ]; then
    DOCKER_PARAMS="--device /dev/snd"
elif [ "$BACKEND" = "pulseaudio" ]; then
    DOCKER_PARAMS="--user $(id -u):$(id -g) -v $HOME:$HOME \
        -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /dev/shm:/dev/shm \
        -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native"
else
    echo "Error: Unknown backend $BACKEND"
    exit 1
fi

docker pull vace117/spotify-connect-server
docker run $DOCKER_ENV_VARS $DOCKER_PARAMS --net host vace117/spotify-connect-server