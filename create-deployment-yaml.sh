#!/bin/bash

# Setting up K8's deployment yaml file with registry IP address in image name
#./cicd-app/deployment-tmpl/hello.sh
#echo
#./cicd-app/deployment-tmpl/create-deployment-yaml.sh

echo
sed -e "s/\${HOSTIP}/${HOSTIP}/" ./cicd-app/deployment-tmpl/deployment-app.tmpl > ./cicd-app/deployment-app.yaml
echo
