#!/bin/bash

# Upload submissions to the Internet Archive assuming the
# corresponding files are in the current directory with the following
# format
#
# AUTHOR - TITLE.flac

#############
# Constants #
#############

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

# Extract LMC round index of a challenge given its file path
get_lmc_idx() {
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

# Get present submission filenames
get_submission_filenames() {
    NEXT
}

# Get present challenge description
get_description() {
    NEXT
}

########
# Main #
########

present_challenge=$(ls present/LMC*.json)
round=$(get_lmc_idx "${present_challenge}")
submissions=($(get_submission_filenames))
description=$(get_description)
date=$(now)
identifier=libre-music-challenge-${round}
ia upload ${identifier} "${submissions[@]}" \
   --metadata="collection:opensource_audio" \
   --metadata="description:${description}" \
   --metadata="licenseurl:https://creativecommons.org/licenses/by-sa/4.0/" \
   --metadata="mediatype:audio" \
   --metadata="subject:libre music challenge" \
   --metadata="title:Libre Music Challenge #${round}" \
   --metadata="date:${date}"
