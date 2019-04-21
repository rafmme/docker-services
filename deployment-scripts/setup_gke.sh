function configure_GCP_project() {
    display_message $BLUE "SETTING GCP PROJECT"
    gcloud config set project $PROJECT_NAME
    gcloud config set compute/zone $COMPUTE_ZONE
    gcloud services enable container.googleapis.com
    gcloud alpha billing projects link $PROJECT_NAME --billing-account $BILLING_ACCOUNT
    display_success_message "GCP PROJECT HAS BEEN SET"
}

function create_GKE_cluster () {
    display_message $BLUE "CREATING GKE CLUSTER - $CLUSTER_NAME"
    gcloud container clusters create $CLUSTER_NAME  --num-nodes=$NUM_OF_NODES --zone $COMPUTE_ZONE --machine-type $MACHINE_TYPE
    gcloud container clusters get-credentials $CLUSTER_NAME
    display_success_message "GKE CLUSTER - $CLUSTER_NAME HAS BEEN CREATED"
}

function create_GCP_disk () {
    display_message $BLUE "CREATING GCP Disk - $CLUSTER_NAME"
    gcloud compute disks create pg-data-disk --size $DISK_CAPACITY --zone $REGION
    display_success_message "GCP Disk HAS BEEN CREATED"
}

function setup_GKE_GCP () {
    configure_GCP_project
    create_GKE_cluster
    create_GCP_disk
}

