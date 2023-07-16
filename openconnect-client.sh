#!/bin/bash

function start() {
  echo "<pass>" | sudo openconnect "<ip>" --user="<user-name>"  -b --no-dtls --passwd-on-stdin --servercert "<servercert>" >> /dev/null 2>& 1
}


function stop() {
  sudo kill -9 `ps aux | grep openconnect | awk '{print $2}'` >> /dev/null 2>& 1
}


if [[ $1 = "start" ]]
then
	start
elif [[ $1 = "stop" ]]
then
	stop
else
    echo "Usage: opc start          start openconnect"
    echo "   or: opc stop           stop openconnect"
    exit -1
fi
