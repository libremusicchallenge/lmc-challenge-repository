#!/bin/bash

# Convert challenge in JSON format to Markdown format.

########
# Main #
########

src="$1"
echo "## Short Description"
jq -r '.short_description' "${src}"
echo
echo "## Long Description"
jq -r '.long_description' "${src}"
