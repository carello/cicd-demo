#!/bin/bash

# Color Template
RED="\033[31m"
WHITE="\033[97m"
BLUE="\033[34m"
YELLOW="\033[33m"
GREEN="\033[32m"
DEFAULT="\033[39m"

#${RED}
#${WHITE}
#${BLUE}
#${YELLOW}
#${GREEN}
#${DEFAULT}

# Set background to black
echo -e "\033[40"
echo -e ${WHITE}
echo "###################################################################################"
echo "CAUTION! Cleaning up Drone-Gogs CICD deployment"
echo "Run this script when you need to wipe out the config and start a new fresh deployment."
echo "The script isn't very robust, and you could delete unintended files if not careful!"
echo "If unsure, don't run this script; delete files manually instead."
echo "###################################################################################"
echo
echo -e ${DEFAULT}"You are here >> " $(PWD)
echo -e ${WHITE}
read -p "--> Press 'enter' to continue, or Q/q to exit: " -n 1 -r answer
if [[ $answer =~ ^[Qq]$ ]]
     then
       echo
       echo -e ${DEFAULT}"Exiting program..."
       echo
       exit
     else:
       continue
fi

echo
echo -e ${YELLOW}"--> 1) Shutting down docker-compose. This will stop services..."
read -p "Press 'enter to continue "
echo
docker-compose stop
echo
echo -e ${YELLOW}"--> 2) Stopping and removing containers..."
echo -e ${DEFAULT}
docker stop dc-gogs
docker stop dc-drone-server
docker rm -f dc-gogs
docker rm -f dc-drone-server
docker rm -f registry1
docker network rm cicd-demo_default
echo

echo -e ${RED}"--> 3) DELETING GOGS DB! -- NOTE: comment out script if you want to keep the repo!"
echo
echo -e ${YELLOW}"--> CAUTION!!! You are about to delete directories 'gogs' and 'drone'."
echo -e ${DEFAULT}
ls -l
echo -e ${WHITE}
read -p "Press 'enter' to continue, or Q/q to exit: " -n 1 -r answer
if [[ $answer =~ ^[Qq]$ ]]
     then
       echo -e ${DEFAULT}
       echo "Exiting program...."
       echo
       exit
     else:
       continue
fi
echo

rm -rf ./gogs
rm -rf ./drone
echo -e ${DEFAULT}
ls -l
echo
echo -e ${YELLOW}"--> 4) Removing .git directory..."
read -p "--> Press 'enter to continue "
echo
rm -rf ./cicd-app/.git
rm ./cicd-app/deployment-app.yaml

echo
echo -e ${DEFAULT}
echo -e ${WHITE}"docker ps"
echo -e ${DEFAULT}
docker ps
echo
echo -e ${WHITE}"docker ps -a"
echo -e ${DEFAULT}
docker ps -a
echo
echo -e ${YELLOW}"--> Stopping minikube...."
echo -e ${DEFAULT}
minikube stop
echo
echo -e ${WHITE}"--> Clean up completed"
echo -e ${DEFAULT}
# Set background back to default
echo -e "\033[49"
echo
