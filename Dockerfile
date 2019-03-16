# docker run $DOCKER_ENV_VARS \
#         --device /dev/snd \
#         --net host \
#         --user $(id -u):$(id -g) -v $HOME:$HOME \
#         -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
#         -v /tmp/.X11-unix:/tmp/.X11-unix \
#         -v /dev/shm:/dev/shm \
#         -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
#         vace117/spotify-connect-server
#
# Don't run this image manually! Use 'control_scripts/start-spotify-connect-server.sh' script.
#
FROM ubuntu:bionic

LABEL org.label-schema.version="1.0"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="Spotify Connect Server"
LABEL org.label-schema.description="This Docker image runs a Spotify Connect server that will appear in the Device List of any Spotify client connected to the same network. This allows the client to play music through the local ALSA device of the host where this Docker image is installed."
LABEL org.label-schema.url="https://github.com/vace117/spotify-connect-server"
LABEL org.label-schema.docker.cmd="docker run --device /dev/snd --net host --user $(id -u):$(id -g) -v $HOME:$HOME -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/shm:/dev/shm -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native vace117/spotify-connect-server"
LABEL org.label-schema.vendor="vace117"


RUN apt-get update && apt-get install -y --no-install-recommends \
        libasound2-dev \
        libpulse-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y

COPY spotifyd /root
COPY docker-entrypoint.sh /root
COPY spotifyd.conf /etc

WORKDIR /root
RUN chmod -R 777 /root
CMD /root/docker-entrypoint.sh
