#!/bin/sh

mkdir -p logs/
cd logs/

LOGFILE="$(date +'%Y_%m_%d_%H_%M_%S')_terraria.log"

ln -sf "$LOGFILE" current.log
sleep 1;

# add timestamp and tee logs to logfile
docker logs -f terraria-server 2>&1 | \
	awk '{ print strftime("%Y-%m-%dT%H:%M:%S%z"), $0; fflush() }' | \
	tee "$LOGFILE"
