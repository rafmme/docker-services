function configure_GCP_project() {
    display_message $BLUE "SETTING GCP PROJECT"
    gcloud config set project $PROJECT_NAME
    gcloud config set compute/zone $COMPUTE_ZONE
    display_success_message "GCP PROJECT HAS BEEN SET"
}

function create_GKE_cluster () {
    display_message $BLUE "CREATING GKE CLUSTER - $CLUSTER_NAME"
    gcloud container clusters create $CLUSTER_NAME  --num-nodes=$NUM_OF_NODES --zone $COMPUTE_ZONE --machine-type $MACHINE_TYPE
    gcloud container clusters get-credentials $CLUSTER_NAME
    display_success_message "GKE CLUSTER - $CLUSTER_NAME HAS BEEN CREATED"
}

function create_GCP_disk () {
    display_message $BLUE "CREATING GCP Disk timmy-lms-pg-data-disk"
    gcloud compute disks create timmy-lms-pg-data-disk --size $DISK_CAPACITY --zone $REGION
    display_success_message "GCP Disk HAS BEEN CREATED"
}

function setup_GKE_GCP () {
    configure_GCP_project
    create_GKE_cluster
    create_GCP_disk
}

