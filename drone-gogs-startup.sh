#!/bin/bash

# Starting up docker-compose and adding registry to proper network
echo

docker-compose up -d

echo
echo "--> Configuring Reigstry network settings"
docker network connect cicd-demo_default registry1
echo
