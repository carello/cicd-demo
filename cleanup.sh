#! /bin/bash

echo
echo "###################################################################################"
echo "CAUTION! Cleaning up Drone-Gogs CICD deployment"
echo "Run this script when you need to wipe out the config and start a new fresh deployment."
echo "The script isn't very robust, and you could delete unintended files if not careful!"
echo "If unsure, don't run this script; delete files manually instead."
echo "###################################################################################"
echo
echo "You are here:" $(PWD)
echo -e "\033[97m"
read -p "Press 'enter' to continue, or Q/q to exit: " -n 1 -r answer
if [[ $answer =~ ^[Qq]$ ]]
     then
       echo -e "\033[39m"
       exit
     else:
       continue
fi

echo -e "\033[39m"
echo
echo -e "\033[33m 1) Shutting down docker-compose. This will stop services..."
echo "Note that the network is NOT deleted; you can choose to delete manually."

docker-compose stop
echo
echo -e "\033[33m 2) Stopping and removing containers..."
echo -e "\033[39m"
docker stop dc-gogs
docker stop dc-drone-server
docker rm -f dc-gogs
docker rm -f dc-drone-server
echo

echo -e "\033[33m \033[1m 3) DELETING GOGS DB! -- NOTE: comment out script if you want to keep the repo!"
echo -e "\033[0m \033[39m" 
ls -l
echo
echo "CAUTION!!! You are about to delete directories 'gogs' and 'drone'."
echo -e "\033[97m"
read -p "Press 'enter' to continue, or Q/q to exit: " -n 1 -r answer
if [[ $answer =~ ^[Qq]$ ]]
     then
       echo -e "\033[39m"
       exit
     else:
       continue
fi
echo

rm -rf gogs
rm -rf drone
echo -e "\033[0m \033[39m" 
ls -l
echo
echo -e "\033[33m 4) Removing .git directory..."
cd cicd-app
rm -rf .git
echo
echo -e "\033[0m \033[39m"
echo "docker ps...."
docker ps
echo
echo "docker ps -a..."
docker ps -a
echo
echo "Stopping minikube...."
minikube stop
echo
echo "Completed"
