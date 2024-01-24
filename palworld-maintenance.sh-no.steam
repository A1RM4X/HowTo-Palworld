#!/bin/bash

/usr/games/steamcmd +login anonymous +app_update 2394010 validate +quit && tar -czvf /home/steam/Palworld_backups/"Palworld_$(date '+%Y-%m-%d_%H-%M-%S').tar.gz" /home/steam/Steam/steamapps/common/PalServer/Pal/Saved && find /home/steam/Palworld_backups/ -mtime +10 -type f -delete
