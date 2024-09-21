#! /bin/bash
#GolemSP systemd installer v1.3
#Now with automatic daily service restarts
#
#User is added to kvm group, without it service will not start without user login.
      sudo usermod -a -G kvm $USER
#writes the service
      sudo bash -c "cat << 'EOF' > /usr/lib/systemd/system/golemsp.service
#Installed by golemsp-systemd.updater.sh v1.3
[Unit]
 Description=Start GolemSP
 After=network-online.target
#Makes sure GolemSP isn't started before KVM
 Requires=open-vm-tools.service
 After=open-vm-tools.service
[Service]
 Type=simple
 Restart=on-failure
#RuntimeMaxSec sets the service restart period, Takes a unit-less value in seconds, or a time span value such as 1day 1hour 5min 20s
 RuntimeMaxSec=1day
#Environment defines the ip and port golemsp should listen on
#Environment=YA_NET_BIND_URL=udp://0.0.0.0:11503
#Default RestartSec is 100ms and can take up measurable system resources
 RestartSec=10
#Fix for no file descriptors errors for hosts with more than 104 threads
LimitNOFILE=65536
#Keeps service from timing out.
 TimeoutSec=600
 User=$USER
 ExecStart=$HOME/.local/bin/golemsp run
 Environment=PATH=$HOME/.local/bin/
 #KillSignal=SIGINT sends keyboard ctrl+c to active golemsp session for a graceful shutdown.
 KillSignal=SIGINT
[Install]
  WantedBy=multi-user.target
EOF"

                 sudo systemctl daemon-reload
                 sudo systemctl enable golemsp
                   echo " "
                   echo -e "\033[0;32mSystemd Service successfuly installed for GolemSP.\033[0m"
                   echo " "
                   echo "You can now enable or disable GolemSP on system startup using command."
                   echo " "
                   echo "       systemctl [enable|disable] golemsp"
                   echo " "
                   echo " "
                   echo " "
                   echo "Start or stop the golemsp service for the current session using command."
                   echo " "
                   echo "       systemctl [start|stop] golemsp"
                   echo " "
                   echo " "
                   echo " "
                   echo "More useful commands."
                   echo " "
                   echo "       systemctl --help"
                   echo " "
                   echo "       golemsp --help"
                   echo " "
                   echo "       journalctl -u golemsp --lines=20 --follow"
                   echo " "
                   echo " "
