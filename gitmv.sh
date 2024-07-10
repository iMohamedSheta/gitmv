#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the destination directory relative to the current directory
DEST_DIR="./updatedfiles"

# Print start information
echo -e "${YELLOW}Starting the script to move modified and untracked files.${NC}"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Create a list of modified and untracked files
git ls-files --modified --others --exclude-standard > files-to-move.txt

# Loop through each file and move it to the destination directory with full path
while IFS= read -r file; do
    # Create the full path directory in the destination
    mkdir -p "$DEST_DIR/$(dirname "$file")"

    # Move the file to the destination directory
    cp --parents "$file" "$DEST_DIR"

    # Print feedback message for each file moved
    echo -e "${GREEN}Moved: ${file}${NC}"
done < files-to-move.txt

# Clean up
rm files-to-move.txt

# Print colored success messages
echo -e "${GREEN}All modified and untracked files have been moved to $DEST_DIR${NC}"
echo -e "${YELLOW}The list of files has been archived in $DEST_DIR/mvfiles/${NC}"

exit 0
