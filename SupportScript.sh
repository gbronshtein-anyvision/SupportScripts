#!/bin/bash

echo "
  ______                                                ______                _              
 / _____)                                      _       / _____)              (_)         _   
( (____   _   _  ____   ____    ___    ____  _| |_    ( (____    ____   ____  _  ____  _| |_ 
 \____ \ | | | ||  _ \ |  _ \  / _ \  / ___)(_   _)    \____ \  / ___) / ___)| ||  _ \(_   _)
 _____) )| |_| || |_| || |_| || |_| || |      | |_     _____) )( (___ | |    | || |_| | | |_ 
(______/ |____/ |  __/ |  __/  \___/ |_|       \__)   (______/  \____)|_|    |_||  __/   \__)
                |_|    |_|                                                      |_|          
 
Support Script version-1.1 - created by Gilad Bronshtein

"


#############################################################################################
########################################## METHODS ##########################################
#############################################################################################

function .moveOnMessage()
{
	echo -e ""
	echo -e "\e[45mDONE Moving on..\e[0m"
	echo -e ""
}

function apps_Install()
{
echo "======================================================================="
echo "==         Updates / SSH Server / htop / vim / curl / Aria2          =="
echo "======================================================================="

echo -e "\e[93m>>>>> Installing Updates <<<<<\e[0m"
echo -e ""
sudo apt-get update
echo -e "\e[93m>>>>> Installing SSH SERVER <<<<<\e[0m"
echo -e ""
sudo apt-get install ssh -y
echo -e ""
echo -e "\e[93m>>>>> Installing HTOP <<<<<\e[0m"
echo -e ""
sudo apt install htop -y
echo -e ""
echo -e "\e[93m>>>>> Installing VIM <<<<<\e[0m"
echo -e ""
sudo apt install vim -y
echo -e ""
echo -e "\e[93m>>>>> Installing CURL <<<<<\e[0m"
echo -e ""
sudo apt install curl -y
echo -e ""
echo -e "\e[93m>>>>> Installaing Aria2 <<<<<\e[0m"
echo -e ""
sudo apt-get install -y aria2
echo -e ""
echo -e "\e[93m>>>>> dpkg configure -a <<<<<\e[0m"
echo -e ""
sudo dpkg --configure -a

.moveOnMessage
}

function chrome()
{
echo "======================================================================="
echo "==                     Download & Install Chrome                     =="
echo "======================================================================="

cd /home/user/Downloads/
if [ ! -f /home/user/Downloads/google-chrome-stable_current_amd64.deb ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo apt install ./google-chrome-stable_current_amd64.deb -y 
fi

.moveOnMessage
}

function teamViewer()
{
echo "======================================================================="
echo "==                   Download & Install TeamViewer                   =="
echo "======================================================================="
cd /home/user/Downloads/
if [ ! -f /home/user/Downloads/teamviewer_amd64.deb ]; then
    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb && sudo apt install ./teamviewer_amd64.deb -y
fi	

.moveOnMessage
}

function openvpn()
{
echo "======================================================================="
echo "==                       Installing OpenVPN                          =="
echo "======================================================================="

sudo apt install -y openvpn
echo -e ""
echo -e ""
echo -e "\e[41m Once done - Navigate to: https://office.anyvision.co:8443 \e[0m"
echo -e "\e[41m Login -> Click 'Yourself (user locked profile)' at the bottom of the page \e[0m"
echo -e "\e[41m RUN: sudo cp ~/Downloads/client.ovpn /etc/openvpn/ \e[0m"
echo -e ""

.moveOnMessage
}

function bashrc()
{
echo "======================================================================="
echo "==             Adding 'vpn' running option to bashrc                 =="
echo "======================================================================="

cd ~
echo "Once deployed - run vpn by typing vpn in terminal with Sudo permissions"
echo "alias vpn='sudo openvpn --config /etc/openvpn/client.ovpn --auth-user-pass --auth-retry interact'" >> ~/.bashrc
source ~/.bashrc

.moveOnMessage
}

function system_Diagnostic()
{
echo "======================================================================="
echo "==                      System Information                           =="
echo "======================================================================="

echo -e "\e[44m>>>>> CPU <<<<<\e[0m"
cat /proc/cpuinfo | grep -m1 'model name'
echo -e ""

echo -e "\e[44m>>>>> RAM <<<<<\e[0m"
free | grep -m1 'Mem'
echo -e ""

echo -e "\e[44m>>>>> GPU <<<<<\e[0m"
lspci -v | grep 'VGA'
echo -e ""

echo -e "\e[44m>>>> System <<<\e[0m"
echo sudo grep | dmidecode | grep -A3 '^System Information'
echo -e ""

echo -e "\e[44m>>>> Disks <<<<\e[0m"
echo sudo grep | lsblk -o SIZE,TYPE,KNAME | grep disk
echo -e ""

echo -e "\e[44m>>>> Release <<<<\e[0m"
echo sudo grep | lsb_release -a
echo -e ""

echo -e "\e[44m>>>> Storage <<<<\e[0m"
echo sudo grep | mount | grep storage
echo -e ""

echo -e "\e[44m>>>> Storage Space <<<<\e[0m"
echo sudo grep | df -T -h /
echo sudo grep | df -T -h /storage
echo -e ""

.moveOnMessage
}

function z_mailerInstructions()
{
echo "======================================================================="
echo "==             Creating a steps file for Mailer Deploying            =="
echo "======================================================================="

cd /home/user/Desktop
txtMailer="mailer.txt"
touch $txtMailer
echo "1. Open Terminal (CTRL+ALT+T)

2. Run following Command (Enter consul pod)
   kubectl exec -it consul-server-0 sh

3.BEFORE You continue - Change the parameters at the end of each command from line 3-7 and run following commands:
	consul kv put broadcaster-env/BCAST_MAILER_SERVICE_NAME gmail
	consul kv put broadcaster-env/BCAST_MAILER_IS_ENABLED true
	consul kv put broadcaster-env/BCAST_MAILER_USERNAME xxxx@yyyy.com
	consul kv put broadcaster-env/BCAST_MAILER_PASS xxxxxxxxxxxxxxxxxx
	consul kv put broadcaster-env/BCAST_MAILER_RECIPIENTS xxxx@yyyy.com,xxxx2@yyyy2.com
	consul kv put broadcaster-env/BCAST_MAILER_FROM_EMAIL xxxx@yyyy.com
	consul kv put broadcaster-env/BCAST_MAILER_SENDER_NAME CompanyName

4.Time Zone
Use followig site to choose your time zone: http://manpages.ubuntu.com/manpages/bionic/man3/DateTime::TimeZone::Catalog.3pm.html
	consul kv put broadcaster-env/TZ Asia/Jerusalem
 
5.NOT Mandatory
	consul kv put broadcaster-env/BCAST_MAILER_SUBJECT

5.Exit -> Type exit

	" > ${txtMailer}

.moveOnMessage
}

function z_btrInstructions()
{
echo "======================================================================="
echo "==             Creating a steps file for BTR Deploying               =="
echo "======================================================================="

cd /home/user/Desktop
txtBTR="BTR.txt"
touch $txtBTR
echo "1. Open Terminal (CTRL+ALT+T)

2. Run following Command (Enter consul pod)
   kubectl exec -it consul-server-0 sh

3.Run following commands
	consul kv put push-notification/RMQ_API_HOST rabbitmq.default.svc.cluster.local
	consul kv put push-notification/FIREBASE_ADMIN_TOKEN key=AIzaSyApjUyvlbCJRQnIV0JnHKb2Fs2tUCIJopg
	consul kv put broadcaster-env/BCAST_RMQ_IS_ENABLED true 
	consul kv put backend/misc_image_allowed_rotation true 
	consul kv put api-gateway/EXTERNAL_SUPPORTED_VERSIONS 1.6
	consul kv put api-gateway/JWT_EXPIRY_DURATION 604800

4.Exit -> Type exit

	" > ${txtBTR}

.moveOnMessage
}

function z_WebRTCInstructions()
{
echo "======================================================================="
echo "==             Creating a steps file for webRTC Fixing               =="
echo "======================================================================="

cd /home/user/Desktop
txtWebRTC="webRTC.txt"
touch $txtWebRTC
echo "1. Open Terminal (CTRL+ALT+T)

2. Run following Command (Enter consul pod)
   kubectl exec -it consul-server-0 sh

3.Run following commands
	consul kv put webrtc-streamer/WEBRTC_HOST [BT_SERVER_IP]
	consul kv put webrtc-streamer/APIGATEWAY_IP [BT_SERVER_IP]
	consul kv put webrtc-streamer/HOST_IP [BT_SERVER_IP]


4.Exit -> Type exit

	" > ${txtWebRTC}

.moveOnMessage
}


function endMessage()
{
echo "======================================================================="
echo -e "==                             \e[5mEnd of Script\e[0m                         =="
echo "======================================================================="
}



##################################################################################
#### "======================================================================="####
#### "==                                RUN                                =="####
#### "======================================================================="####
##################################################################################

function .showhelp()
{
echo ""
echo "OPTIONS:"
echo "[-h|--help]               Help menu"
echo "[-p|--preinstallation]    Pre installation apps: Updates / SSH Server / htop / vim / curl / Aria2 / Chrome / TeamViewer / OpenVPN"
echo "[-c1|--clean1]             Clean.sh 1.24.2"
echo "[-i1|--install1]           Install.sh 1.24.2 (Online Installation)" 
echo "[-d1|--dashbaord1]         Dashboard download to Desktop and grant execution permission - 1.24.2"
echo "[-pd|--pdiagnostics]      Pre-Installation HW / SW Diagnostics"
echo "[-in|--instructions]      Add instructions of BTR / WebRTC Fix / Mailer on desktop"
}

function preInstallation()
{
	apps_Install
	openvpn
	bashrc
	chrome
	teamViewer
}

function v1_clean()
{
	cd ~
	wget -qO- http://1-24-2.a-v.io/clean.sh | bash -s -- -a | tee -a /root/.gravity/clean.log
	echo -e "\e[48m Before you proceed - verify your /storage set properly e[0m"
}

function v1_install_v1()
{
	 cd ~
	 wget -qO- http://1-24-2.a-v.io/install.sh | bash -s -- --advertise-ip 172.17.255.254 --auto-install-product -p bettertomorrow
}

function v1_dashboard_v1()
{
	cd /home/user/Desktop
	wget https://s3.eu-central-1.amazonaws.com/anyvision-dashboard/1.24.2/AnyVision-1.24.2-linux-x86_64.AppImage
	chmod +x AnyVision-1.24.2-linux-x86_64.AppImage
}

function preDiagnostics()
{
	system_Diagnostic
}


function instructions()
{
	z_btrInstructions
	z_mailerInstructions
	z_WebRTCInstructions
}

##################################################################################
#### "======================================================================="####
#### "==                               FLAGS                               =="####
#### "======================================================================="####
##################################################################################


POSITIONAL=()
while test $# -gt 0; do
    key="$1"
    case $key in
        -h|--help)
        .showhelp
        exit 0
        ;;
		 -p|--preinstallation)
        preInstallation
        exit 0
        ;;
		 -c1|--clean1)
        clean
        exit 0
        ;;
		 -i1|--install1)
        install
        exit 0
        ;;
		-d1|--dashboard1)
        dashboard
        exit 0
        ;;
		-pd|--pdiagnostics)
        preDiagnostics
        exit 0
        ;;
		-in|--instructions)
        instructions
        exit 0
        ;;
    esac
    break
done