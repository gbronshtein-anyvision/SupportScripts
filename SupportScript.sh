#!/bin/bash

echo "
  ______                                                ______                _              
 / _____)                                      _       / _____)              (_)         _   
( (____   _   _  ____   ____    ___    ____  _| |_    ( (____    ____   ____  _  ____  _| |_ 
 \____ \ | | | ||  _ \ |  _ \  / _ \  / ___)(_   _)    \____ \  / ___) / ___)| ||  _ \(_   _)
 _____) )| |_| || |_| || |_| || |_| || |      | |_     _____) )( (___ | |    | || |_| | | |_ 
(______/ |____/ |  __/ |  __/  \___/ |_|       \__)   (______/  \____)|_|    |_||  __/   \__)
                |_|    |_|                                                      |_|          
 
Support Script v1.2 - created by Gilad Bronshtein - wget -qO- https://git.io/JfvAs | bash -s -- -h
"
if [[ $EUID -ne 0 ]]; then 
   echo -e "\e[41mThis script must be run as root\e[0m"
   echo -e "\e[42mThis script must be run as root\e[0m"
   echo -e "\e[43mThis script must be run as root\e[0m"
   echo -e "\e[44mThis script must be run as root\e[0m"
   echo -e "\e[45mThis script must be run as root\e[0m"
   exit 1 
	fi

function .showhelp
	{
	echo ""
	echo "OPTIONS:"
	echo ""
	echo "[-h|--help]                     Help menu"
	echo "[-ap|--apps]                    Pre installation apps: Updates / SSH / htop / vim / curl / Aria2 / Chrome / TV"
	echo "[-lo|--livelogs]                Deploy live logs alias commands" 
	echo "[-c1|--clean_v1]                Clean.sh 1.24.2" 
	echo "[-f1|--startfromfresh_bt_v1]    BT V1 Start From Fresh - Run only after Clean"
	echo "[-i1|--install_v1]              Install.sh 1.24.2 (Online Installation)" 
	echo "[-d1|--dashbaord_v1]            Dashboard download to Desktop and grant execution permission - 1.24.2"
	echo "[-r1|--rule_engine_v1]          Download and install rule engine 1.24.2"
	echo "[-di|--diagnostics]             Pre-Installation HW / SW Diagnostics"
	echo "[-in|--instructions]            Add instructions of BTR / WebRTC Fix / Mailer on desktop"
	echo "[-f|--forensic]                 Download forensic video [Berlin]"
	echo "[-o|--openVPN]                  Install OpenVPN and Deploy aliasn in .bashrc"
	}	


#############################################################################################
########################################## METHODS ##########################################
#############################################################################################


function .moveOnMessage
	{
		echo -e ""
		echo -e "\e[45mDONE\e[0m"
		echo -e ""
	}

function deploy_Apps_Install
	{
		echo "======================================================================="
		echo "==    Updates / SSH Server / htop / vim / curl / Aria2 / DevTools    =="
		echo "======================================================================="
		echo -e "\e[93m>>>>> Installing Updates <<<<<\e[0m"
		echo -e ""
		sudo apt-get update
		echo -e ""
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
		echo -e "\e[93m>>>>> Installing Aria2 <<<<<\e[0m"
		echo -e ""
		sudo apt-get install -y aria2
		echo -e ""
		echo -e "\e[93m>>>>> Installing Net-tools <<<<<\e[0m"
		echo -e ""
		sudo apt-get install net-tools -y

		.moveOnMessage
	}

function deploy_Chrome
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

function deploy_TeamViewer
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

function deploy_OpenVPN
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
		cd ~
		echo "Once deployed - run vpn by typing vpn in terminal with Sudo permissions"
		echo "alias vpn='sudo openvpn --config /etc/openvpn/client.ovpn --auth-user-pass --auth-retry interact'" >> ~/.bashrc
		source ~/.bashrc
		.moveOnMessage
	}


function run_System_Diagnostic
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

	3.BEFORE You continue - 
	Change the parameters at the end of each command from line 3-7 and run following commands:

		consul kv put broadcaster-env/BCAST_MAILER_SERVICE_NAME gmail
		consul kv put broadcaster-env/BCAST_MAILER_IS_ENABLED true
		consul kv put broadcaster-env/BCAST_MAILER_USERNAME xxxx@yyyy.com
		consul kv put broadcaster-env/BCAST_MAILER_PASS xxxxxxxxxxxxxxxxxx
		consul kv put broadcaster-env/BCAST_MAILER_RECIPIENTS xxxx@yyyy.com,xxxx2@yyyy2.com
		consul kv put broadcaster-env/BCAST_MAILER_FROM_EMAIL xxxx@yyyy.com
		consul kv put broadcaster-env/BCAST_MAILER_SENDER_NAME CompanyName

	4.Time Zone
	Use followig site to choose your time zone: 
	http://manpages.ubuntu.com/manpages/bionic/man3/DateTime::TimeZone::Catalog.3pm.html
		
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

##################################################################################
#### "======================================================================="####
#### "==                                RUN                                =="####
#### "======================================================================="####
##################################################################################

function v1_Clean
	{
		cd ~
		wget -qO- http://1-24-2.a-v.io/clean.sh | bash -s -- -a | tee -a /root/.gravity/clean.log \
		&& echo -e "\e[48m Before you proceed - verify your /storage set properly e[0m"
	}

function v1_Install
	{
		#Here we check how many disks physically installed - if 1 - moving on to installation - it's probably a demo laptop with SSD only
		#IF 2 disks we check whether there /storage is set 

		cd ~
		# Variables #
		rowscount="$(lsblk | grep disk | wc -l)"
		storageCheck="$(lsblk | grep storage)"

		if [[ rowscount > 1 ]];then
			if [[ storageCheck != *"storage"* ]];then 
			echo "/storage was not configured"
			else
				wget -qO- http://1-24-2.a-v.io/install.sh | bash -s -- --advertise-ip 172.17.255.254 --auto-install-product -p bettertomorrow
			fi
		else
			wget -qO- http://1-24-2.a-v.io/install.sh | bash -s -- --advertise-ip 172.17.255.254 --auto-install-product -p bettertomorrow
		fi
		############# Reboot Section #############
		while true;	do
		read -r -p "Installation completed - would you like to reboot? [Y/n] " input
			case $input in
			[yY][eE][sS]|[yY])
				echo "Yes"
				reboot
				break
				;;
			[nN][oO]|[nN])
				echo "No"
				break
				;;
			*)
				echo "Invalid input..."
				;;
			esac
		done
	}

function v1_Dashboard
	{
		cd /home/user/Desktop
		wget https://s3.eu-central-1.amazonaws.com/anyvision-dashboard/1.24.2/AnyVision-1.24.2-linux-x86_64.AppImage \
		&& chmod +x AnyVision-1.24.2-linux-x86_64.AppImage
		.moveOnMessage
	}

function download_Forensics #version1.2
	{
		wget https://s3.eu-central-1.amazonaws.com/anyvision-open-bucket/Berlin_Street.mp4
		.moveOnMessage
	}

function v1_RuleEngine #version1.2
	{
		cd ~
		curl -O https://gravity-bundles.s3.eu-central-1.amazonaws.com/products/rule-engine/2.0.0/rule-engine-1.24.2-rule-engine.tar.gz \
		&& ./gravity_package_installer.sh rule-engine-1.24.2-rule-engine.tar.gz
		.moveOnMessage
	}

function pre_Diagnostics { 	run_System_Diagnostic; }

function deploy_Instructions { 	z_btrInstructions;	z_mailerInstructions; 	z_WebRTCInstructions; }

function pre_Installation { deploy_Apps_Install; deploy_Chrome; deploy_TeamViewer; }

function v1_Start_From_Fresh
	{
		#CLEAN SSD
		rm -rf /ssd/apigateway
		rm -rf /ssd/memsql
		rm -rf /ssd/mongo_db_data
		rm -rf /ssd/pipe_data
		rm -rf /ssd/rabbitmq
		rm -rf /ssd/redis_db_data
		rm -rf /ssd/reid_service_data
		rm -rf /ssd/seaweed-filer
		rm -rf /ssd/track_archive_service_data
		rm -rf /ssd/seaweed-master
		#CLEAN Storage
		rm -rf /storage/api-logs
		rm -rf /storage/frame_store
		rm -rf /storage/gateway-logs
		rm -rf /storage/memsql_backup
		rm -rf /storage/mongo_db_backup
		rm -rf /storage/object_store
		rm -rf /storage/pipe-logs
		rm -rf /storage/pipe_store
	}


function deploy_LiveLogs
	{
		echo "======================================================================="
		echo "==                        Live Logs Alias Line                       =="
		echo "======================================================================="
		cd ~
		
cat >> ~/.bashrc << 'EOF'
		api()
		{ 
		podname=$(kubectl get po | grep api- | awk '{print $1}') && kubectl logs -f --tail=10 ${podname}
		} 
		
		gateway()
		{ 
		podname=$(kubectl get po | grep apigateway | awk '{print $1}') && kubectl logs -f --tail=10 ${podname} apigateway 
		} 
		
		edge() 
		{ 
		podname=$(kubectl get po | grep edge- | awk '{print $1}') && kubectl logs -f --tail=10 ${podname} edge 
		} 
		
		collate() 
		{ 
		podname=$(kubectl get po | grep collate- | awk '{print $1}') && kubectl logs -f --tail=10 ${podname} 
		} 
		
		nginx() 
		{ 
		podname=$(kubectl get po | grep nginx- | awk '{print $1}') && kubectl logs -f --tail=10 ${podname} 
		}

		alias apilive=api
		alias gatewaylive=gateway
		alias edgelive=edge
		alias collatelive=collate 
		alias nginxlive=nginx
EOF
		source ~/.bashrc
		.moveOnMessage
	}



##################################################################################
#### "======================================================================="####
#### "==                               FLAGS                               =="####
#### "======================================================================="####
##################################################################################


POSITIONAL=()
while test $# -gt 0; do
    flag="$1"
    case $flag in
        -h|--help)
        .showhelp
        exit 0
        ;;
		 -ap|--apps)
        pre_Installation
        exit 0
        ;;
		-lo|--livelogs)
        deploy_LiveLogs
        exit 0
        ;;
		 -c1|--clean_bt_v1)
        v1_Clean
        exit 0
        ;;
		-f1|--startfromfresh_bt_v1)
        v1_Start_From_Fresh
        exit 0
        ;;
		 -i1|--install_bt_v1)
        v1_Install
        exit 0
        ;;
		-d1|--dashboard_bt_v1)
        v1_Dashboard
        exit 0
        ;;
		-r1|--rule_engine_v1)
        v1_RuleEngine
        exit 0
        ;;
		-di|--diagnostics)
        pre_Diagnostics
        exit 0
        ;;
		-in|--instructions)
        deploy_Instructions
        exit 0
        ;;
		-f|--forensic)
        download_Forensics
        exit 0
        ;;
		-o|--openvpn)
        deploy_OpenVPN
        exit 0
        ;;
    esac
    break
done