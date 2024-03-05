#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <URL of tar.gz file> <Repository folder name>"
    exit 1
fi

param1="$1"
param2="$2"

# Create a new git repository folder
repo_folder="./$param2"
mkdir "$repo_folder"


# Add a new file to the repo folder and name it logtest.log
touch "$repo_folder/logtest.log"

# Get the current time with nanoseconds
timestamp=$(date "+%Y-%m-%d %H:%M:%S.%N")

# Write a new row to logtest.log
echo "$timestamp - $param2 Repository Created" >> "$repo_folder/logtest.log"
