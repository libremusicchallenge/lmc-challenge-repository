#!/bin/bash

# Aggregates the votes of the participants to calculate their scores.

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

# Log at DEBUG level to stdout
log_debug() {
    echo "[$(now)][DEBUG] $@"
}

# Log at ERROR level to stderr and exit
log_error() {
    echo "[$(now)][ERROR] $@" >&2
    exit 1
}

########
# Main #
########

# Declare associative array mapping entries to scores
declare -A entry_to_score

present_challenge=$(ls present/LMC*.json)
jq '.votes' "${present_challenge}"

# NEXT: have this being automatically filled by jq
lst_1st=("amberdrake" "A-Lin" "MyLoFy" "A-Lin")
lst_2nd=("MyLoFy" "MyLoFy" "A-Lin" "amberdrake")
lst_3rd=("Nick The Sic" "amberdrake" "Nick The Sic" "Nick The Sic")
lst_4th=()
lst_5th=()

# Populate entry_to_score
for i in ${!lst_1st[@]}; do
    s=entry_to_score["${lst_1st[${i}]}"]
    entry_to_score["${lst_1st[${i}]}"]=$((s + 5))
done
for i in ${!lst_2nd[@]}; do
    s=entry_to_score["${lst_2nd[${i}]}"]
    entry_to_score["${lst_2nd[${i}]}"]=$((s + 4))
done
for i in ${!lst_3rd[@]}; do
    s=entry_to_score["${lst_3rd[${i}]}"]
    entry_to_score["${lst_3rd[${i}]}"]=$((s + 3))
done
for i in ${!lst_4th[@]}; do
    s=entry_to_score["${lst_4th[${i}]}"]
    entry_to_score["${lst_4th[${i}]}"]=$((s + 2))
done
for i in ${!lst_5th[@]}; do
    s=entry_to_score["${lst_5th[${i}]}"]
    entry_to_score["${lst_5th[${i}]}"]=$((s + 1))
done
echo "${entry_to_score[@]}"
echo "${!entry_to_score[@]}"

# NEXT: automatically populate present json file with scores
