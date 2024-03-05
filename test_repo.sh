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

# Download the tar
curl -L "$param1" | tar -xz --strip-components=1 -C "$repo_folder"


# Write a new row to logtest.log 
echo "$timestamp_download - $param1 downloaded" >> "$repo_folder/logtest.log"


# Print all files in the repository folder to logtest.log
echo "Files in the repository folder ($param2):" >> "$repo_folder/logtest.log"
ls -la "$repo_folder" >> "$repo_folder/logtest.log"



# Commit all changes
cd "$repo_folder" || exit
git init
git add .
git commit -m "i do q8 commit"



#  Create a new branch named BR_IMAGES and move into it
git checkout -b BR_IMAGES




# Copy all JPEG and PNG files to the Repo folder
find . -name '.jpg' -o -name '.jpeg' -o -name '*.png' -exec cp {} "$repo_folder" \;
# Add the copied files to the staging area
git add .
# Commit the changes to the BR_IMAGES branch
git commit -m "Add JPEG and PNG files to Repo folder in BR_IMAGES branch"
# Create a new branch named BR_TEXT and move into it
git checkout -b BR_TEXT

# Copy all text and log files to the Repo folder
find . -name '.txt' -o -name '.log' -exec cp {} "$repo_folder" \;

# Add the copied files to the staging area
git add .

# Commit the changes to the BR_TEXT branch
git commit -m "Add text and log files to Repo folder in BR_TEXT branch"

# Move back to the master branch and delete the extracted folder
git checkout master
rm -rf "$repo_folder"

# Commit the changes
git add .
git commit -m "Delete extracted folder"

# Merge BR_IMAGES and BR_TEXT into master
git merge BR_IMAGES
git merge BR_TEXT

# Print the history list for BR_IMAGES, BR_TEXT, and master into logtest.log
echo "History list for BR_IMAGES branch:" >> logtest.log
git log --oneline BR_IMAGES >> logtest.log

echo "History list for BR_TEXT branch:" >> logtest.log
git log --oneline BR_TEXT >> logtest.log

echo "History list for master branch:" >> logtest.log
git log --oneline master >> logtest.log



# Commit all changes
cd "$repo_folder" || exit
git init
git add .
git commit -m "i do THA ALL  "




