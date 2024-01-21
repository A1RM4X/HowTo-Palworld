Set up a Palworld dedicated server on Linux - For extra clarity watch my YouTube video below.
---

## YouTube Overview

[![A1RM4X on YouTube](http://img.youtube.com/vi/0TjFLk_lP6c/0.jpg)](https://youtu.be/0TjFLk_lP6c "Setup a dedicated Palworld server with A1RM4X - Part 1")
[![A1RM4X on YouTube](http://img.youtube.com/vi/bjC081ERYcQ/0.jpg)](https://youtu.be/bjC081ERYcQ "Setup a dedicated Palworld server with A1RM4X - Part 2")

### Tutorial
---

Make sure you have a fresh Debian server up and running with a SSH access.

Update and upgrade everything:
```bash
apt update && apt dist-upgrade
```

Install SteamCMD with all the dependencies:
```bash apt install software-properties-common
apt-add-repository non-free
dpkg --add-architecture i386
apt update
apt install steamcmd
```

Install sudo and create a new user steam:
```bash
apt install sudo

useradd -m steam
passwd steam
```

Log in as steam:
```bash
sudo -u steam -s
cd /home/steam
```

Install the Palworld dedicated server via SteamCMD:
```bash
/usr/games/steamcmd +login anonymous +app_update 2394010 validate +quit
```

Fix server log errors by creating symlinks:
```bash
cd ~/.steam
ln -s steam/steamcmd/linux32 sdk32
ln -s steam/steamcmd/linux64 sdk64
```

Launch server for creating configuration files:
```bash
cd ~/.steam/steam/steamapps/common/PalServer
./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
```

Copy server settings file in the right directory then edit the settings as you wish (details in YouTube video):
```bash
cp DefaultPalWorldSettings.ini Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
nano Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
```

#### Setup a service to automize the management of the server
Create a Palworld service file:
```bash
nano /etc/systemd/system/palworld.service
```

Edit the Palworld service file (watch the videos for more details):
```bash
[Unit]
Description=Palworld Dedicated Server by A1RM4X 0.1

[Service]
User=steam
Group=steam
Environment="templdpath=$LD_LIBRARY_PATH"
Environment="LD_LIBRARY_PATH=/home/steam/.steam/steam/steamapps/common/PalServer/linux64:$LD_LIBRARY_PATH"
Environment="SteamAppId=2394010"
ExecStartPre=/usr/games/steamcmd +login anonymous +app_update 2394010 validate +quit
ExecStart=/home/steam/.steam/steam/steamapps/common/PalServer/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS > /dev/null
Restart=always
RuntimeMaxSec=12h


[Install]
Wants=network-online.target
After=network-online.target
WantedBy=multi-user.target
```

Enable and start the service file (watch the videos for more details):
```bash
systemctl enable palworld.service
systemctl daemon-reload
service palworld start
```

### Extra
---
Restart & update the server by using this command `service palworld restart`

Stop the server by using this command `service palworld stop`
