#!/bin/bash

# Add submissions to present challenge

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

# Initialize arrays
artists=()
tracks=()

# Iteratively ask for artists and track names
while true; do
    read -rp "Artist (leave empty to finish): " artist
    # finish if empty artist
    [[ -z "$artist" ]] && break

    read -rp "Track for \"$artist\": " track
    # if track empty, skip adding this artist
    if [[ -z "$track" ]]; then
        echo "Skipped \"$artist\"."
        continue
    fi

    artists+=("$artist")
    tracks+=("$track")
done

# Add this information in present challenge JSON file
present_challenge=$(ls present/LMC*.json)
for i in "${!artists[@]}"; do
    a="${artists[i]}"
    t="${tracks[i]:-}"
    # Append to submissions
    jq --arg a "$a" --arg t "$t" '.submissions += [{artist: $a, track: $t}]' "$present_challenge" > "${present_challenge}.$$" && mv "${present_challenge}.$$" "$present_challenge"
done
