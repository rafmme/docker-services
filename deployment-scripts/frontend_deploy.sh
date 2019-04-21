#!/usr/bin/env bash

# to ensure the script terminate immediately it encounters an error
set -e pipefail

BLUE=`tput setaf 4`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

source ./deployment-scripts/display_message.sh

function create_frontend_deployment () {
    cd k8s
    display_message $BLUE "CREATING FRONTEND DEPLOYMENT"
    kubectl create -f ./frontend-deployment.yml
    kubectl expose deployment timmy-lms-frontend --type "LoadBalancer" --port 80 --target-port=3110
    display_success_message "FRONTEND DEPLOYMENT DONE"
}



# the script starting point
function main () {
    create_frontend_deployment
}


main
