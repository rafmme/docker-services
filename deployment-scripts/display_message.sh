# a function to display a message of what action is going on
function display_message() {
    echo "        "
    echo -e "${1} ## ${2} ## ${RESET}"
    echo "        "
}

# a function to display completion message when an action is complete
function display_success_message() {
    echo "        "
    echo -e "${GREEN} *** ${1} *** ${RESET}"
    echo "        "
}
