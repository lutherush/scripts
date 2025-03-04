#!/bin/bash
# File: hook.sh
# Usage: ./hook.sh -m "run-ci | Your commit message here"

# Parse command-line options
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
  ["run-grpc"]="grpc.txt"
  ["run-repo"]="repo.txt"
  ["run-upload"]="upload.txt"
  ["run-avscanner"]="av.txt"
  ["run-crm"]="crm.txt"
  ["run-platform"]="platform.txt"
  ["run-websdk"]="websdk.txt"
)

# Check for trigger keyword in the commit message.
trigger_found=""
for trigger in "${!trigger_to_file[@]}"; do
  if echo "$COMMIT_MSG" | grep -q "$trigger"; then
    trigger_found="$trigger"
    break
  fi
done

if [ -n "$trigger_found" ]; then
  echo "Trigger keyword '$trigger_found' found in commit message."
  # Interactive prompt for version bump type.
  echo "Select version bump type for '$trigger_found':"
  echo "  1. Patch (e.g., 1.2.3 -> 1.2.4)"
  echo "  2. Minor (e.g., 1.2.3 -> 1.3.0)"
  echo "  3. Major (e.g., 1.2.3 -> 2.0.0)"
  read -p "Enter your choice (1/2/3): " bump_choice

  case $bump_choice in
    1)
      bump="patch"
      ;;
    2)
      bump="minor"
      ;;
    3)
      bump="major"
      ;;
    *)
      echo "Invalid choice; defaulting to patch bump."
      bump="patch"
      ;;
  esac

  # Define the directory where version files are stored.
  VERSION_DIR=".ci/versions"
  version_file="${trigger_to_file[$trigger_found]}"
  full_path="${VERSION_DIR}/${version_file}"

  echo "Updating version file: $full_path"

  # Ensure the version file exists; if not, create it with an initial version.
  if [ ! -f "$full_path" ]; then
    echo "Version file not found for '$trigger_found'. Creating with initial version 0.0.1."
    mkdir -p "$VERSION_DIR"
    echo "0.0.1" > "$full_path"
  fi

  # Read the current version.
  version=$(cat "$full_path")
  IFS='.' read -r major minor patch <<< "$version"
  old_version="$version"

  # Calculate the new version based on bump type.
  case $bump in
    "patch")
      patch=$((patch + 1))
      ;;
    "minor")
      minor=$((minor + 1))
      patch=0
      ;;
    "major")
      major=$((major + 1))
      minor=0
      patch=0
      ;;
  esac

  new_version="${major}.${minor}.${patch}"
  echo "$new_version" > "$full_path"
  echo "Version bumped for '$trigger_found': $old_version -> $new_version"

  # Stage the updated version file and commit the version bump.
  git add "$full_path"
  git commit -m "Version bumped for '$trigger_found': $old_version -> $new_version"
else
  echo "No trigger keyword found in commit message. No version bump performed."
fi

# Finally, push all commits.
git push

