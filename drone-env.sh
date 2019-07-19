#!/bin/bash

# DRONE and DOCKER ENV

BASE_DIR=$(basename "$(PWD)")
#echo ${BASE_DIR}_default

#HOSTIP=$(ipconfig getifaddr en0)
#echo $HOSTIP

# ALT
HOSTIP=$(/sbin/ifconfig en0 | grep 'inet ' | cut -d: -f2 | xargs | awk '{print $2}')

#echo "Is this your IP address? " $HOSTIP
#read -p  "Please enter Y/y or N/n " -n 1 -r answer
#if [[ $answer =~ ^[Nn]$ ]] 
#  then
#    echo
#    read -p "What is your IP address? " HOSTIP
#  else
#    echo
#fi

echo "Is this your IP address? " ${HOSTIP}
while true; do
    echo
    read -p  "Please enter Y/y or N/n, (CTRL-C to quit) " -n 1 -r answer
    if [[ $answer =~ ^[Yy]$ ]];
      then
        echo
        echo "Okay. thanks"
        break
    fi
    if [[ $answer =~ ^[Nn]$ ]];
      then
        echo
        read -p "What is your IP address? " HOSTIP
        echo "Okay. thanks"
        break
    else
      echo
      echo "-- bad entry, pleaser try again, (CTRL-C to quit)"
    fi
done 
   

export DRONE_GOGS_SERVER=http://dc-gogs:3000
export DRONE_SERVER_HOST=dc-drone-server
export DRONE_SERVER_PROTO=http
export CI_NET=${BASE_DIR}_default

export HOSTIP
echo
echo "Your IP is: " ${HOSTIP}
echo "If this isn't correct, pleaser re-run this script"
echo
