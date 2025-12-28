#!/bin/bash

NEXT: help to create audio file as well

# Create a future challenge JSON file from prompting the user with
# relevant questions.

#############
# Functions #
#############

# Output now's data and time
now() {
    date +"%Y-%m-%d %H:%M:%S"
}

# Log at INFO level to stdout
log_info() {
    echo "[$(now)][INFO] $@"
}

########
# Main #
########

# Title
echo "Provide the title of the challenge (will be used as file basename):"
read -s title

# Short Description
echo "Provide a short (one sentence) description of the challenge:"
read -s short_description

# Long Description
echo "Provide a long (multiple sentences) description of the challenge:"
read -s long_description

jq . <<< "{ \"short_description\": \"${short_description}\", \"long_description\": \"${long_description}\" }" > future/"${title}.json"

log_info "New challenge file created under the future folder: \"${title}.json\""
