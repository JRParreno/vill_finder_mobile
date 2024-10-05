#!/bin/bash

# Load environment variables from the .env file
set -o allexport
source .env
set +o allexport

# Build the --dart-define parameters
DART_DEFINES=""

while read -r line || [ -n "$line" ]; do
    if [[ $line == \#* || -z $line ]]; then
        # Skip comments and empty lines
        continue
    fi
    IFS='=' read -r key value <<< "$line"
    DART_DEFINES+="--dart-define=${key}=${value} "
done < .env

# Run the flutter build command with the dart-define arguments
flutter build apk $DART_DEFINES
