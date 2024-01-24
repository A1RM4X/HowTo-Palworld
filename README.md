# Set up a Palworld dedicated server on Linux 
More details videos below:
---
[![A1RM4X on YouTube](http://img.youtube.com/vi/0TjFLk_lP6c/0.jpg)](https://youtu.be/0TjFLk_lP6c "Setup a dedicated Palworld server with A1RM4X - Part 1")
[![A1RM4X on YouTube](http://img.youtube.com/vi/bjC081ERYcQ/0.jpg)](https://youtu.be/bjC081ERYcQ "Setup a dedicated Palworld server with A1RM4X - Part 2")

> [!IMPORTANT]
> This script is going to be updated, make sure to watch the youtube videos above to be up to date to the last scripts / tutorial.

> [!CAUTION]
> - This script is based on Debian 12, it might work with other distros it might not, please don´t come to my discord for support, I won´t have time to adapt this script for all the distro out there.
> - The game is in ealry access, this script will help you install your own dedicated server on Linux but it will not solve all the problems related to the game itself.
> - I try to simplify the execution of the tasks / commands, however you might need to be a little bit familiar with Linux in general to run this script.
> - I also won´t cover any problems related to networking, you are on your own when it comes to open the ports of your router or make sure you don´t have any firewall blocking you to connect on your own server. Google is your friend for fixing those common issues.

# Tutorial
---

Make sure you have a fresh Debian 12 server up and running with a SSH access.

Update and upgrade everything:
```bash
apt update && apt dist-upgrade
```

Install SteamCMD with all the dependencies:
```bash
apt install software-properties-common && apt-add-repository non-free && dpkg --add-architecture i386 && apt update && apt install steamcmd
```

Install sudo and create a new user steam:
```bash
apt install sudo && useradd -m steam && passwd steam
```

Log in as steam:
```bash
sudo -u steam -s && cd /home/steam
```

Install the Palworld dedicated server via SteamCMD:
```bash
/usr/games/steamcmd +login anonymous +app_update 2394010 validate +quit
```

Fix server log errors by creating symlinks:
```bash
cd ~/.steam && ln -s steam/steamcmd/linux32 sdk32 && ln -s steam/steamcmd/linux64 sdk64
```
> [!CAUTION]
> - If you don´t have a .steam folder in /home/steam/, please switch to this specific (https://github.com/A1RM4X/HowTo-Palworld/blob/dev/README-no.steam.md)


Launch server for creating configuration files:
```bash
cd ~/.steam/steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
```

Copy server settings file in the right directory then edit the settings as you wish (details in YouTube video):
```bash
cp DefaultPalWorldSettings.ini Pal/Saved/Config/LinuxServer/PalWorldSettings.ini && nano Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
```

## Setup a service to automize the management of the server

Make sure all the command below are executed as root.

### 1. Setup the maintenance script for server backups and updates (watch the videos for more details).

Create the maintenance script, make it executable and give it the right user permissions:
```bash
wget https://raw.githubusercontent.com/A1RM4X/HowTo-Palworld/dev/palworld-maintenance.sh -P /home/steam/ && chmod +x /home/steam/palworld-maintenance.sh && chown steam:steam /home/steam/palworld-maintenance.sh
```

Create the backup folder and give it the right permissions:
```bash
mkdir -p /home/steam/Palworld_backups && chown steam:steam /home/steam/Palworld_backups
```

Download the Palworld service file:
```bash
wget https://raw.githubusercontent.com/A1RM4X/HowTo-Palworld/dev/palworld.service -P /etc/systemd/system/
```

Enable and start the service file (watch the videos for more details):
```bash
systemctl enable palworld.service && systemctl daemon-reload && systemctl start palworld.service
```

### 2. Backing up and restoring server data localy

Stop the palworld server before restoring the backup
```bash
systemctl stop palworld.service
```

Make sure the previous palworld server data is deleted 
```bash
test -d /home/steam/.steam/steam/steamapps/common/PalServer/Pal/Saved && rm -rf /home/steam/.steam/steam/steamapps/common/PalServer/Pal/Saved
```

Select the backup you want to restore (check video on YouTube for details) and extract it
```bash
tar -xzvf /home/steam/Palworld_backups/Palworld_MODIFY-DATE-HERE.tar.gz -C /
```

Verify all went well
```bash
test -d /home/steam/.steam/steam/steamapps/common/PalServer/Pal/Saved && echo RESTORATION SUCCESS!!!
```


## FAQ
---
### 1. Manual Restart / Backup / Stop the palworld server

Restart, backup & update the server by using this command `systemctl restart palworld.service`

Stop the server by using this command `systemctl stop palworld.service`


### 2. Transferring / copying server configuration files from a server to another server
Log in the new server and make sure you have executed the whole tutorial for having a server up and running.

Log in root in the old server, then SCP transfer the file in the new server (more details in the youTube video):
```bash
scp /home/steam/Palworld_backups/Palworld_MODIFY-DATE-HERE.tar.gz IP_ADRESS_NEW_SERVER:/home/steam/Palworld_backups/
```
Then follow the Backing up and restoring server data localy [here](https://github.com/A1RM4X/HowTo-Palworld/blob/dev/README.md#2-backing-up-and-restoring-server-data-localy).


### 3. No .steam folder on my debian server
Some users reported not having the same folder structure on their Debian installation. To fix the issue, use this [tutorial](https://github.com/A1RM4X/HowTo-Palworld/blob/dev/README-no.steam.md).
