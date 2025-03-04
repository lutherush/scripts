#!/bin/bash
# File: hook.sh
# Usage: ./hook.sh -m "Your commit message with trigger keywords, e.g., run-ci run-platform | Commit description"

# Parse the commit message option.
while getopts "m:" opt; do
  case $opt in
    m) COMMIT_MSG="$OPTARG";;
    *) echo "Usage: $0 -m 'commit message'" ; exit 1;;
  esac
done

if [ -z "$COMMIT_MSG" ]; then
  echo "Error: Commit message (-m) is required."
  exit 1
fi

# Stage all changes and commit with the provided message.
git add .
git commit -m "$COMMIT_MSG"
if [ $? -ne 0 ]; then
  echo "Git commit failed. Aborting."
  exit 1
fi

# Define mapping of trigger keywords to version file names.
declare -A trigger_to_file=(
  ["run-ci"]="backend.txt"
  ["run-platform"]="platform.txt"
  ["run-frontend"]="frontend.txt"
  # Add any other triggers as needed.
)

# Find all triggers present in the commit message.
found_triggers=()
for trigger in "${!trigger_to_file[@]}"; do
  if echo "$COMMIT_MSG" | grep -q "$trigger"; then
    found_triggers+=("$trigger")
  fi
done

if [ ${#found_triggers[@]} -eq 0 ]; then
  echo "No trigger keywords found in commit message. No version bump performed."
else
  for trigger in "${found_triggers[@]}"; do
    echo "-----------------------------"
    echo "Processing trigger: '$trigger'"
    # Define version file details.
    VERSION_DIR=".ci/versions"
    version_file="${trigger_to_file[$trigger]}"
    full_path="${VERSION_DIR}/${version_file}"

    echo "Updating version file: $full_path"

    # Ensure the version file exists; if not, create it with an initial version.
    if [ ! -f "$full_path" ]; then
      echo "Version file not found for '$trigger'. Creating with initial version 0.0.1."
      mkdir -p "$VERSION_DIR"
      echo "0.0.1" > "$full_path"
    fi

    # Read and parse the current version.
    version=$(cat "$full_path")
    IFS='.' read -r major minor patch <<< "$version"
    old_version="$version"

    echo "Current version for '$trigger': $old_version"
    echo "Select version bump type for '$trigger':"
    echo "  1. Patch (e.g., $version -> ${major}.${minor}.$((patch+1)))"
    echo "  2. Minor (e.g., $version -> ${major}.$((minor+1)).0)"
    echo "  3. Major (e.g., $version -> $((major+1)).0.0)"
    read -p "Enter your choice (1/2/3): " bump_choice

    # Calculate the new version.
    case $bump_choice in
      1)
        patch=$((patch + 1))
        ;;
      2)
        minor=$((minor + 1))
        patch=0
        ;;
      3)
        major=$((major + 1))
        minor=0
        patch=0
        ;;
      *)
        echo "Invalid choice; defaulting to patch bump."
        patch=$((patch + 1))
        ;;
    esac

    new_version="${major}.${minor}.${patch}"
    echo "$new_version" > "$full_path"
    echo "Version bumped for '$trigger': $old_version -> $new_version"

    # Stage and commit the version bump change.
    git add "$full_path"
    git commit -m "Version bumped for '$trigger': $old_version -> $new_version"
  done
fi

# Finally, push all commits.
git push

