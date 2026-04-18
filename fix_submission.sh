#!/bin/bash

# Fix submission, like properly rename it, encode it in the FLAC, etc.

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

# Get submission filenames of a given challenge, given its JSON file
get_submission_filenames() {
    jq -r '.submissions[] | "\(.artist) - \(.track).flac"' "$1"
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

########
# Main #
########

if [[ $# -eq 1 ]]; then
    src="$1"
else
    echo "Error: expect submission.  Usage is"
    echo "$0 SUBMISSION"
fi

# Split into name and extension
src_ext="${src##*.}"
src_name="$(basename "$src" ".$src_ext")"

# Fix name
present_challenge=$(ls present/LMC*.json)
mapfile -t artists < <(get_submission_artists "$present_challenge")
mapfile -t tracks < <(get_submission_tracks "$present_challenge")
mapfile -t submissions < <(get_submission_filenames "$present_challenge")
for i in "${!artists[@]}"; do
    if [[ "$src_name" == *"${artists[$i]}"* || "$src_name" == *"${tracks[$i]}"* ]]; then
        dst="${submissions[$i]}"
    fi
done
if [[ -z "$dst" ]]; then
    echo "Could not fix the name of the submission, please fix manually"
    exit 1
fi

# Convert to FLAC if needed
if [[ "$src_ext" != flac ]]; then
    log_info "Convert \"$src\" into \"$dst\""
    ffmpeg -i "$src" "$dst" &> /dev/null
    rm "$src"
else
    log_info "Rename \"$src\" into \"$dst\""
    mv "$src" "$dst"
fi
