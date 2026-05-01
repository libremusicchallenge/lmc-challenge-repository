#!/bin/bash

# set -x

# Upload submissions to the Internet Archive assuming the
# corresponding files are in the current directory with the following
# format
#
# AUTHOR - TITLE.flac

source common.sh

#############
# Functions #
#############

# Get description for the Internet Archive of a given challenge (given
# its JSON file)
get_description() {
    local start_date=$(get_lmc_start_date "$1")
    local start_year=$(date -d "$start_date" +%Y)
    local start_month=$(date -d "$start_date" +%B)
    echo "Submission for the Libre Music Challenge #$(get_lmc_round "$1"): \"$(get_lmc_title "$1")\", $start_month $start_year.  More info about the challenge at: $(get_lmc_url "$1")"
}

########
# Main #
########

present_challenge=$(ls present/LMC*.json)
round=$(get_lmc_round "${present_challenge}")
mapfile -t submissions < <(get_submission_filenames "$present_challenge")
description=$(get_description "$present_challenge")
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
log_info "LMC#${round} uploaded to the Internet Archive.  See https://archive.org/details/libre-music-challenge-${round}"
