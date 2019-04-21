#!/usr/bin/env bash

# to ensure the script terminate immediately it encounters an error
set -e pipefail

BLUE=`tput setaf 4`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

# load the variables declared in the .env file into the shell
source .env
source ./deployment-scripts/display_message.sh 
source ./deployment-scripts/setup_gke.sh

function create_db_deployment () {
    cd k8s
    display_message $BLUE "CREATING POSTGRES DB DEPLOYMENT"
    kubectl create -f ./volume.yml
    kubectl create -f ./volume-claim.yml
    kubectl create -f ./secrets.yml
    kubectl create -f ./postgres-deployment.yml
    kubectl expose deployment timmy-lms-postgres --type=NodePort --port=6000 --target-port=5432

    db_ip_address=$(kubectl get service timmy-lms-postgres | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
    db_connection_url="postgresql://postgres:''@$db_ip_address:6000/haven_db"
    db_conn_url_hash=$(echo -n $db_connection_url | base64)

    sed -ie '/database_url:/d' ./secrets.yml
    echo "  database_url: $db_conn_url_hash" >> ./secrets.yml
    kubectl apply -f ./secrets.yml
    display_success_message "POSTGRES DB DEPLOYMENT DONE"
}



# the script starting point
function main () {
    setup_GKE_GCP
    create_db_deployment   
}


main
