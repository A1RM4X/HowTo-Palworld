# Tutorial for Debian without .steam folder in /home/steam
---

Follow this part of the tutorial after starting on the main one because your folders structure is not the same.

Make sure you have a fresh Debian 12 server up and running with a SSH access.

Log in as steam:
```bash
sudo -u steam -s && cd /home/steam
```
Create the .steam folder and create the correct symlinks for the server to start:
```bash
mkdir /home/steam/.steam && cd /home/steam/.steam && ln -s /home/steam/.local/share/Steam/steamcmd/linux32 sdk32 && ln -s /home/steam/.local/share/Steam/steamcmd/linux64 sdk64
```

Launch server for creating configuration files:
```bash
cd ~/Steam/steamapps/common/PalServer && ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
```

If the server launch correctly (= no spam of steamclient.so missing), close the server. 

Continue the process by copying server settings file in the right directory then edit the settings as you wish (details in YouTube video):
```bash
cp DefaultPalWorldSettings.ini Pal/Saved/Config/LinuxServer/PalWorldSettings.ini && nano Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
```

## Setup a service to automize the management of the server

Make sure all the commands below are executed as root.

### 1. Setup the maintenance script for server backups and updates (watch the videos for more details).

Create the maintenance script, make it executable and give it the right user permissions:
```bash
wget https://raw.githubusercontent.com/A1RM4X/HowTo-Palworld/main/palworld-maintenance.sh-no.steam -P /home/steam/ && mv /home/steam/palworld-maintenance.sh-no.steam /home/steam/palworld-maintenance.sh && chmod +x /home/steam/palworld-maintenance.sh && chown steam:steam /home/steam/palworld-maintenance.sh
```

Create the backup folder and give it the right permissions:
```bash
mkdir -p /home/steam/Palworld_backups && chown steam:steam /home/steam/Palworld_backups
```

Download the Palworld service file:
```bash
wget https://raw.githubusercontent.com/A1RM4X/HowTo-Palworld/main/palworld.service-no.steam -P /etc/systemd/system/ && mv /etc/systemd/system/palworld.service-no.steam /etc/systemd/system/palworld.service 
```

Enable and start the service file (watch the videos for more details):
```bash
systemctl enable palworld.service && systemctl daemon-reload && systemctl start palworld.service
```
Stop the palworld server before restoring the backup
```bash
systemctl stop palworld.service
```

Delete the previous server data! ATTENTION! Make sure you have a backup before doing this! 
```bash
test -d /home/steam/Steam/steamapps/common/PalServer/Pal/Saved && rm -rf /home/steam/Steam/steamapps/common/PalServer/Pal/Saved
```

Select the backup you want to restore (check video on YouTube for details) and extract it
```bash
tar -xzvf /home/steam/Palworld_backups/Palworld_MODIFY-DATE-HERE.tar.gz -C /
```

Verify all went well
```bash
test -d /home/steam/Steam/steamapps/common/PalServer/Pal/Saved && echo "RESTORATION SUCCESS"
```
### [Back to the main Tutorial](https://github.com/A1RM4X/HowTo-Palworld/blob/main/README.md)


