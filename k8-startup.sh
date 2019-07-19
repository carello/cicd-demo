#! /bin/bash

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
echo "    CLEAN INSTALL. This script will delete minikube and install a fresh copy "
echo "    EXIT this script if you don't want to delete your installed copy of minikube"
echo "###################################################################################"
read -p "Press enter to continue. "
echo -e ${DEFAULT}

echo
echo -e ${YELLOW}"--> STEP 1: Clean up house first"
read -p "Press enter to continue. "
echo -e ${DEFAULT}
minikube stop
minikube delete
sudo rm -rf ~/.minikube
sudo rm -rf ~/.kub

echo
echo -e ${YELLOW}"--> STEP 2: Start up minikube"
read -p "Press enter to continue. "
echo -e ${DEFAULT}
minikube start --memory 4000 --cpus 2 --insecure-registry $HOSTIP:5001

echo
echo -e ${YELLOW}"--> STEP 3: Enable some addons"
read -p "Press enter to continue. "
echo -e ${DEFAULT}
minikube addons enable heapster; minikube addons enable ingress

echo
echo -e ${YELLOW}"--> STEP 4: Checking things"
read -p "Press enter to continue. "
echo -e ${DEFAULT}
kubectl get pods --all-namespaces

echo
echo -e ${YELLOW}"--> STEP 5: Start K8's Dashboard"
read -p "Press enter to continue. "
echo -e ${WHITE}"--> Opening minikub dashboard in another term window"
# For MAC terminals only
osascript  <<EOF
tell app "Terminal"
  do script "minikube dashboard"
end tell
EOF

echo
docker images
echo
echo -e ${YELLOW}"--> Step 6: Enabling 'kubectl proxy'"
echo -e ${DEFAULT}
# For MAC terminals only
osascript  <<EOF
tell app "Terminal"
  do script "kubectl proxy --address='0.0.0.0' --disable-filter=true"
end tell
EOF

echo
echo -e ${YELLOW}"--> Step 7: Setting up registry..."
read -p "Press enter to continue. "
docker run -d -e REGISTRY_HTTP_ADDR=0.0.0.0:5001 -p 5001:5001 \
-e REGISTRY_STORAGE_DELETE_ENABLED=true --restart=always \
--name registry1 registry:2
echo
echo -e ${DEFAULT}

echo
#docker network connect cicd-demo_default registry1

echo
docker pull carello/pythonbase:latest
docker tag carello/pythonbase:latest localhost:5001/pythonbase:latest
docker push localhost:5001/pythonbase:latest

echo
echo -e ${YELLOW}"--> Step 8: Setting up deployment yaml files"
read -p "Press enter to continue. "
echo -e ${DEFAULT}
echo
./create-deployment-yaml.sh

echo
echo -e ${WHITE}
echo "*** K8's and Registry base setup completed ***"
echo -e ${DEFAULT}
echo
# Set background back to default
echo -e "\033[49"
echo

