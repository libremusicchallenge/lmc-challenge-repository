#!/bin/bash

# NEXT: complete fields that must be completed

# Randomly select a challenge file from the future folder.  Move it to
# the present folder and move the existing challenge in the present
# folder to the past folder.

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

# Extract LMC INDEX of present challenge given its filename.
get_previous_lmcidx() {
    sed 's/LMC\([0-9]\+\).*/\1/g' <<< "$1"
}

########
# Main #
########

# Randomly select next challenge
nbr_challenges=$(ls -1 future | wc -l)
if [[ 0 -eq ${nbr_challenges} ]]; then
    log_error "No more challenge.  Please populate the future folder with challenges."
fi
rnd_challenge=$((RANDOM % ${nbr_challenges}))

# Retrieve today's date
today_date=$(date +%F)

# Calculate next round index
present_challenge=$(ls present/LMC*.json)
present_challenge_base=$(basename "${present_challenge}")
previous_lmcidx=$(get_previous_lmcidx "${present_challenge_base}")
lmcidx=$((previous_lmcidx + 1))

# Move existing present challenge to past
log_info "Move previous challenge \"${present_challenge}\" to the past folder"
mv "${present_challenge}" past

# Move selected challenge from future to present.
i=0
for f in future/*; do
    f_base=$(basename "${f}")
    if [[ $i -eq $rnd_challenge ]]; then
        dst="present/LMC${lmcidx} - ${today_date} - ${f_base}"
        mv "${f}" "${dst}"
        iplusone=$((i + 1))
        log_info "Select challenge \"${f}\" and move it to \"${dst}\""
    fi
    i=$((i + 1))
done
