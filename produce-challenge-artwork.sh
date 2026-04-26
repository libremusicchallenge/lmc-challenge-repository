#!/bin/bash

# Produce challenge artwork, the LMC logo overlayed with the round
# number.  The logo is passed in argument of the command.

source common.sh

#############
# Functions #
#############

# Extract LMC INDEX of present challenge given its filename.
get_present_lmcidx() {
    sed 's/LMC\([0-9]\+\).*/\1/g' <<< "$1"
}

########
# Main #
########

nbr_present_challenges=$(ls present/LMC*.json | wc -l)
if [[ 1 -ne ${nbr_present_challenges} ]]; then
    log_error "There is not exactly one challenge in the present folder.  Please clean up the folder."
fi
present_challenge=$(ls present/LMC*.json)
present_challenge_base=$(basename "${present_challenge}")
lmcidx=$(get_present_lmcidx "${present_challenge_base}")
lmcidx_gif=lmc-round-${lmcidx}.gif
dst=lmc-round-${lmcidx}-artwork.gif
magick -background none -fill Gold -pointsize 384 label:${lmcidx} ${lmcidx_gif}
magick composite -gravity center "${lmcidx_gif}" "$1" "${dst}"
rm "${lmcidx_gif}"
