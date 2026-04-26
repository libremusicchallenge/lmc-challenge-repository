#!/bin/bash

# Parse a file containing the ranking of a voter and write the result
# of the parsing in the JSON file of the present challenge.

# Source common.sh
source common.sh

########
# Main #
########

if [[ $# -eq 1 ]]; then
    ranking_fp="$1"
else
    echo "Error: expect submission.  Usage is"
    echo "$0 RANKING_FILEPATH"
    exit 1
fi

mapfile -t ranking < "$ranking_fp"

for i in "${!ranking[@]}"; do
    if [[ ${ranking[$i]} == *$((i + 1))* ]]; then
        echo "i=$i, ranking[$i]=${ranking[$i]}"
    else
        log_error "Cannot find ranking $((i + 1)) at line $i, within content \"${ranking[$i]}\".  Abort parsing, please fix the file."
    fi
done
