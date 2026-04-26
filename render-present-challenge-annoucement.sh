#!/bin/bash

# Render present challenge annoucement in text format.

source common.sh

#############
# Functions #
#############

# Remove the outer quotes of a string if any
remove_outer_quotes() {
    local str=$1
    str="${str#\"}"
    str="${str%\"}"
    echo "${str}"
}

# Extract LMC round index of a challenge given its file path
get_lmc_idx() {
    jq ".round" "$1"
}

# Extract title of a challenge given its file path
get_lmc_title() {
    jq -r ".title" "$1"
}

# Extract start date of a challenge given its file path
get_lmc_start_date() {
    jq -r ".start_date" "$1"
}

# Extract end date of a challenge given its file path
get_lmc_end_date() {
    jq -r ".end_date" "$1"
}

########
# Main #
########

present_challenge=$(ls present/LMC*.json)
lmc_idx=$(get_lmc_idx "${present_challenge}")
lmc_title=$(get_lmc_title "${present_challenge}")
lmc_start_date=$(get_lmc_start_date "${present_challenge}")
lmc_end_date=$(get_lmc_end_date "${present_challenge}")

echo "Title:"
echo "Libre Music Challenge #${lmc_idx} ${lmc_title}"
echo
echo "Body:"
echo "Welcome to the Libre Music Challenge #${lmc_idx}!"
#NEXT
