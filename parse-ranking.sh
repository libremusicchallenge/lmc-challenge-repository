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

present_challenge="$(get_present_challenge)"
mapfile -t artists < <(get_submission_artists "$present_challenge")
mapfile -t tracks < <(get_submission_tracks "$present_challenge")
mapfile -t ranking < "$ranking_fp"

for i in "${!ranking[@]}"; do
    r="$((i+1))"
    # Check that each line starts with its proper ranking
    if [[ "${ranking[$i]}" == $r* ]]; then
        ranking_added=no
        # Check that each line corresponds to a submission
        for j in ${!artists[@]}; do
            a="${artists[$j]}"
            t="${tracks[$j]}"
            if [[ "${ranking[$i]}" == *"$a"* || "${ranking[$i]}" == *"$t"* ]]; then
                log_info "Found ranking: ${r}th: $a - $t"
                # NEXT: fix structure, see LMC38 for correct structure
                jq --arg r "$r" --arg a "$a" --arg t "$t" '.votes += [{$r: {artist: $a, track: $t}}]' "$present_challenge" > "${present_challenge}.$$" && mv "${present_challenge}.$$" "$present_challenge"
                ranking_added=yes
                break
            fi
        done
        if [[ $ranking_added == no ]]; then
            log_error "Cannot find ranking $r at line $i, within content \"${ranking[$i]}\".  Abort parsing, please fix the file."
        fi
    else
        log_error "Cannot find ranking $r at line $i, within content \"${ranking[$i]}\".  Abort parsing, please fix the file."
    fi
done
