#!/usr/bin/env bash

# to ensure the script terminate immediately it encounters an error
set -e pipefail

BLUE=`tput setaf 4`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

source .env
source ./deployment-scripts/display_message.sh

function delete_resources () {
    cd k8s
    display_message $BLUE "DELETING GKE CLUSTER - $CLUSTER_NAME"

    gcloud container clusters delete $CLUSTER_NAME --quiet
    gcloud compute disks delete timmy-lms-pg-data-disk --zone $REGION --quiet

    display_success_message "GKE CLUSTER - $CLUSTER_NAME DELETION COMPLETE"
}



# the script starting point
function main () {
    delete_resources   
}


main
