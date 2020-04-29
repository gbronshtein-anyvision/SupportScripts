# Support Script

This script should be used on INTERNAL DEMO systems only!
[WIKI Page](https://anyvision.atlassian.net/wiki/spaces/SUPPORT/pages/1604159099/Support+Script+-+INTERNAL+ONLY)

## How to use

Copy following line and use it with root permissions:

```
wget -qO- https://git.io/JfvAs | bash -s -- -h

OPTIONS:
[-h|--help]              Help menu
[-p|--preinstallation]   Pre installation apps: Updates / SSH / htop / vim / curl / Aria2 / Chrome / TV / VPN
[-c|--clean]             Clean.sh 1.24.2
[-i|--install]           Install.sh 1.24.2 (Gravity with Advertised IP)
[-d|--dashbaord]         1.24.2 Dashboard download to Desktop & grant execution permission
[-pd|--pdiagnostics]     Pre-Installation HW / SW Diagnostics
[-in|--instructions]     Add instructions of BTR / WebRTC Fix / Mailer on desktop
```

### Getting Started

Support Script includes the following features:
* Update, Installing SSH Server / htop / vim / curl / dpkg / Chrome / TeamViewer / VPN
* Add VPN alias (.bashrc)
* System Information: 
** CPU, RAM, GPU, System, Disks, Ubuntu Version, Storage, Disks Space
* Easy mailer instructions txt creation 
* Easy BTR instructions txt creation
* Easy webRTC instructions txt creation
* BT V1 - Clean / Install / Download Dashboard (1.24.2-X)
* **WIP V2 - clean.sh | install.sh | dashboard download | flags structure - V2**

### Versioning

* Version 1.0 - April 12 2020 - Linear script
* Version 1.1 - April 29 2020 - Methods, Cases control (flags), Clean BT, Install BT, Install Dashboard

### Authors

* **Gilad Bronshtein** - *Initial work* - [Gilad Bronshtein](https://github.com/gbronshtein-anyvision)
