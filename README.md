Set up a Palworld dedicated server on Linux
For extra clarity watch my YouTube video below.
---

## YouTube Overview

[![A1RM4X on YouTube](http://img.youtube.com/vi/0TjFLk_lP6c/0.jpg)](https://youtu.be/0TjFLk_lP6c "Setup a dedicated Palworld server wit A1RM4X")

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

Launch server and profit:
```bash
./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
```
