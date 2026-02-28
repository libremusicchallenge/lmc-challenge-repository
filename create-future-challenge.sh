#!/bin/bash

# Create a future challenge JSON file from prompting the user with
# relevant questions.  If you wish to enter unicode styles you use a
# tool such as https://crates.io/crates/markdown2unicode.

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

# Log at ERROR level to stderr and exit
log_error() {
    echo "[$(now)][ERROR] $@" >&2
    exit 1
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

# Stems
echo "Provide a path of stems (empty means none):"
read -s stems_path

stems_path_dst=""
if [ -n "${stems_path}" ]; then
    stems_path_dst="${title}"
    if cp -r "${stems_path}" "future/${stems_path_dst}"; then
        log_info "Stems folder created: \"future/${stems_path_dst}\""
    else
        log_error "Failed to create stems folder: \"future/${stems_path_dst}\""
    fi
fi

jq . <<< "{ \"short_description\": \"${short_description}\", \"long_description\": \"${long_description}\", \"stems_path\": \"${stems_path_dst}\"}" > future/"${title}.json"

log_info "New challenge file created: \"future/${title}.json\""
