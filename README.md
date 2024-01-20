Set up a Palworld dedicated server on Linux

---

## YouTube Overview

[![A1RM4X on YouTube](http://img.youtube.com/vi/0TjFLk_lP6c/0.jpg)](https://youtu.be/0TjFLk_lP6c "Setup a dedicated Palworld server wit A1RM4X")

### Tutorial
---

Make sure you have a fresh Debian server up and running with a SSH access.

Update and upgrade everything:
```bash apt update && apt dist-upgrade```

Install SteamCMD with all the dependencies
```bash apt install software-properties-common
apt-add-repository non-free
dpkg --add-architecture i386
apt update
apt install steamcmd```
