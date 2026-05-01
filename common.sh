#!/bin/bash

# Common definitions

#################
# ############# #
# # Functions # #
# ############# #
#################

#############
# Date Time #
#############

# Output now's data and time
now() {
    date +"%Y-%m-%d %H:%M:%S"
}

###########
# Logging #
###########

# Log at INFO level to stdout
log_info() {
    echo "[$(now)][INFO] $@"
}

# Log at ERROR level to stderr and exit
log_error() {
    echo "[$(now)][ERROR] $@" >&2
    exit 1
}

###################
# JSON Management #
###################

# Get the JSON file corresponding to the present challenge.
get_present_challenge() {
    ls present/LMC*.json
}

# Get submission artist names of a given challenge, given its JSON
# file.
get_submission_artists() {
    jq -r '.submissions[] | "\(.artist)"' "$1"
}

# Get submission track titles of a given challenge, given its JSON
# file.
get_submission_tracks() {
    jq -r '.submissions[] | "\(.track)"' "$1"
}

# Extract LMC round index of a challenge given its file path
get_lmc_round() {
    jq ".round" "$1"
}

# Extract title of a challenge given its file path
get_lmc_title() {
    jq -r ".title" "$1"
}

# Extract url of a challenge given its file path
get_lmc_url() {
    jq -r ".url" "$1"
}

# Extract start date of a challenge given its file path
get_lmc_start_date() {
    jq -r ".start_date" "$1"
}

# Extract end date of a challenge given its file path
get_lmc_end_date() {
    jq -r ".end_date" "$1"
}

# NEXT: compare with get_lmc_round
# Extract LMC INDEX of a challenge given its filename.
get_lmc_idx() {
    sed 's/LMC\([0-9]\+\).*/\1/g' <<< "$1"
}

# Get submission filenames of a given challenge (given its JSON file)
get_submission_filenames() {
    jq -r '.submissions[] | "\(.artist) - \(.track).flac"' "$1"
}
