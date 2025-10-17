
























































































































#!/bin/bash
set -e

# Ask user for input
read -p "Enter desired folder name (e.g., dev-api-diagnostics.mryoda.com): " FOLDER_NAME
read -p "Enter original repo URL (e.g., git@github.com:YodaMr/api-diagnostics.mryoda.com.git): " ORIGINAL_REPO_URL
read -p "Enter branch to checkout (e.g., dev): " BRANCH

# Extract repo name from the URL
REPO_NAME=$(basename -s .git "$ORIGINAL_REPO_URL")   # → api-diagnostics.mryoda.com

# Construct custom SSH host alias
GITHUB_ALIAS="github-${REPO_NAME}"

# Transform the repo URL
CUSTOM_REPO_URL=$(echo "$ORIGINAL_REPO_URL" | sed "s|github.com|$GITHUB_ALIAS|")

# Clone the repository into the custom folder
if [ -d "$FOLDER_NAME" ]; then
    echo " Folder '$FOLDER_NAME' already exists. Skipping clone."
else
    echo " Cloning repo into folder '$FOLDER_NAME'..."
    git clone "$CUSTOM_REPO_URL" "$FOLDER_NAME"
fi

# Navigate into the folder
cd "$FOLDER_NAME"

# Checkout the specified branch
echo " Checking out branch: $BRANCH"
git checkout "$BRANCH"

echo "  Done. '$FOLDER_NAME' is on branch '$BRANCH'"
