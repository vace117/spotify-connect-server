FROM ubuntu:bionic

LABEL org.label-schema.name="Spotify Connect Server"
LABEL org.label-schema.description="This Docker image runs a Spotify Connect server that will appear in the Device List of any Spotify client connected to the same network. This allows the client to play music through the local ALSA device of the host where this Docker image is installed."
LABEL org.label-schema.usage="docker run --device /dev/snd --net host vace117/spotify-connect-server"
LABEL org.label-schema.url="Spotify Connect Server"

RUN apt-get update && apt-get install -y --no-install-recommends \
        libasound2-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y

WORKDIR /root
COPY spotifyd /root
COPY docker-entrypoint.sh /root

CMD /root/docker-entrypoint.sh