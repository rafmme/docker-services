#!/usr/bin/env bash

# to ensure the script terminate immediately it encounters an error
set -e pipefail

BLUE=`tput setaf 4`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

source ./deployment-scripts/display_message.sh

function create_backend_deployment () {
    cd k8s
    display_message $BLUE "CREATING BACKEND DEPLOYMENT"
    kubectl create -f ./backend-deployment.yml
    kubectl expose deployment timmy-lms-backend --type=LoadBalancer --port=80 --target-port=4000

    sleep 120s
    backend_ip_address=$(kubectl get service timmy-lms-backend | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | sed "1d")
    kubectl create configmap timmy-lms-config-map --from-literal=backend_ip="http://$backend_ip_address/api/v1"
    sleep 25s

    display_success_message "BACKEND DEPLOYMENT DONE"
}



# the script starting point
function main () {
    create_backend_deployment
}


main
