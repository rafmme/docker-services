function init () {
    ./deployment-scripts/db_deploy.sh && ./deployment-scripts/backend_deploy.sh && ./deployment-scripts/frontend_deploy.sh
}

init
