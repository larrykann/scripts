#!/bin/bash
#
# This script updates the Libraries directory across multiple project directories.
# It is designed to synchronize shared libraries or helper functions stored in a
# central 'Libraries' directory with individual project directories. The script
# supports updating a specific target project directory or all eligible project
# directories within the current working directory.
#
# Usage:
#   ./update_libraries.sh [target_directory]
#
# Arguments:
#   target_directory (optional) - Specifies a single project directory to update.
#                                 If not provided, the script updates all projects.
#
# Behavior:
#   - Without a target_directory argument, the script iterates through all
#     directories in the current working directory, excluding those named
#     'Libraries', 'data', 'storage', and any 'lean.json' files.
#   - For each eligible project directory, the script checks for an existing
#     'Libraries' directory. If found, it deletes this directory to ensure no
#     outdated or conflicting files remain.
#   - The script then copies the master 'Libraries' directory into the project
#     directory. The path to the master 'Libraries' directory is defined by the
#     'LIBRARIES_SOURCE_PATH' environment variable, which should be set in a .env
#     file located in the same directory as this script or in a parent directory.
#   - If a target_directory argument is provided, the script performs the update
#     process only for that specified directory.
#
# Requirements:
#   - The 'cp' and 'rm' commands must be available in the environment. This script
#     is intended for Unix-like systems.
#   - The .env file containing 'LEAN_LIBRARIES_PATH' must be correctly formatted
#     and accessible to the script.
#
# Notes:
#   - This script is intended to be used in development environments where multiple
#     projects share common libraries or functions.
#   - Care should be taken when specifying the target_directory to avoid unintended
#     deletion of files or directories.

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Directories and files to exclude
exclusions=("Libraries" "data" "storage" "lean.json")

function isExcluded {
    for exclude in "${exclusions[@]}"; do
        [[ "$1" == "$exclude" ]] && return 0
    done
    return 1
}

function copyLibraries {
    local targetDir=$1
    [[ -d "$targetDir/Libraries" ]] && rm -rf "$targetDir/Libraries"
    cp -r "$LEAN_LIBRARIES_PATH" "$targetDir"
}

# Main logic
if [[ $1 ]]; then
    copyLibraries $1
else
    for dir in */ ; do
        if ! isExcluded "${dir%/}"; then
            copyLibraries "${dir%/}"
        fi
    done
fi

