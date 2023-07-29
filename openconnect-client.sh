#!/bin/bash

function start() {
  echo "<pass>" | openconnect "<ip>" --user="<user-name>"  -b --no-dtls --passwd-on-stdin --servercert "<servercert>" >> /dev/null 2>& 1
}


function stop() {
  kill -9 `ps aux | grep openconnect | awk '{print $2}'` >> /dev/null 2>& 1
  dhclient 
}

function restart() {
	stop
	main_interface=$(ip route | grep default | awk '{print $5}')
	ip link set dev $main_interface down
	ip link set dev $main_interface up
	sleep 1
	start

}

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (or using sudo)." >&2
  exit 1
fi

if [[ $1 = "start" ]]
then
	start
elif [[ $1 = "stop" ]]
then
	stop
elif [[ $1 = "restart" ]]
then
	restart
else
    echo "Usage: sudo opc start          start openconnect"
    echo "   or: sudo opc stop           stop openconnect"
    echo "   or: sudo opc restart        restart openconnect"
    exit -1
fi
