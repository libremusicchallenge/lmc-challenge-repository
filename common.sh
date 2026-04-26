#!/bin/bash

# Common definitions

#################
# ############# #
# # Functions # #
# ############# #
#################

#############
# Date Time #
#############

# Output now's data and time
now() {
    date +"%Y-%m-%d %H:%M:%S"
}

###########
# Logging #
###########

# Log at INFO level to stdout
log_info() {
    echo "[$(now)][INFO] $@"
}

# Log at ERROR level to stderr and exit
log_error() {
    echo "[$(now)][ERROR] $@" >&2
    exit 1
}
