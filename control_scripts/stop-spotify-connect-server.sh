docker container stop  -t0 `docker ps | grep spotify-connect-server | awk '{print $1}'`