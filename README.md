# Support Script

This script should be used on INTERNAL DEMO systems only!
[WIKI Page](https://anyvision.atlassian.net/wiki/spaces/SUPPORT/pages/1604159099/Support+Script+-+INTERNAL+ONLY)

## How to use

Copy following line and use it with root permissions:

```
wget -qO- https://git.io/JfvAs | bash -s -- -a

OPTIONS:
[-h|--help]              Help menu
[-p|--preinstallation]   Pre installation apps
[-c|--clean]             Clean.sh 1.24.2
[-i|--install]           Install.sh 1.24.2 (Online Installation)
[-d|--dashbaord]         Dashboard download to Desktop and grant execution permission - 1.24.2
[-pd|--pdiagnostics]     Pre-Installation HW / SW Diagnostics
[-in|--instructions]     Add instructions of BTR / WebRTC Fix / Mailer on desktop
```

### Getting Started

Support Script includes the following features:
* apt-get update
* Installing SSH Server / htop / vim / curl / dpkg
* Download & Install Chrome & TV
* Installing Open VPN + vpn alias (.bashrc)
* System Information: 
** CPU, RAM, GPU, System, Disks, Ubuntu Version, Storage, Disks Space
* Easy mailer instructions txt creation 
* Easy BTR instructions txt creation
* Easy webRTC instructions txt creation
* **WIP V2 - clean.sh | install.sh | dashboard download | flags structure - V2**

### Versioning

* Version 1.0 - April 12 2020

### Authors

* **Gilad Bronshtein** - *Initial work* - [Gilad Bronshtein](https://github.com/gbronshtein-anyvision)
