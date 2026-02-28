#!/bin/bash

# Aggregates the votes of the participants to rank the top entries of
# the present challenge.

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

present_challenge=$(ls present/LMC*.json)
jq '.votes' "${present_challenge}"
