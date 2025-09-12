#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name:    git-remote-setup.sh
# Description:    This script automates the process of creating a bare Git 
#                 repository on a remote server, adding the remote repository 
#                 to the current local Git repository, and pushing the contents 
#                 of the local repository to the remote.
#
#
# Features:
#
# - Creates a bare Git repository on the specified remote server using SSH.
# - Adds the newly created remote repository to the local repository.
# - Pushes the current local repository to the remote repository.
# - Provides usage information if no arguments are provided.
# - Validates the number of arguments and displays an error message if incorrect.
# - Supports verbose output to display execution steps.

#
# Optional:
# - Checks if the remote repository already exists before creation.
# - Optionally specify the remote name (defaults to 'origin').
# - Provides error handling for connection issues or invalid inputs.
# - Supports verbose output to display execution steps.
#
# Dependencies:
# - The script assumes the user has SSH access to the remote server.
# - The script assumes that the current directory is a valid Git repository.
#
#
# -----------------------------------------------------------------------------

DEFAULT_REMOTE_REPO_PATH="/srv/git"

# Check if current directory is a Git repository:
# A utility to verify that the script is being executed inside a valid Git repository. If not, the script should exit with an error.
is_git_repo() {
  git rev-parse --is-inside-work-tree > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "Error: This is not a Git repository. Please run the script inside a valid Git repository."
    exit 1
  fi
}

# Check SSH connection to the remote:
# A function to verify if the remote server is reachable via SSH.
check_ssh_connection() {
  ssh -q "$1" exit
  if [ $? -ne 0 ]; then
    echo "Error: Cannot connect to remote server $1. Please check your SSH credentials."
    exit 1
  fi
}

# Create the remote bare repository:
# This function creates a bare repository on the remote server.
create_remote_bare_repo() {
  ssh "$1" "mkdir -p '$2' && git init --bare '$2'"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create the bare repository on the remote server."
    exit 1
  fi
  echo "Bare repository created at $2 on $1."
}

check_remote_exists() {
  git remote get-url "$1" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Error: Remote '$1' already exists"
    return 1
  fi
  return 0
}
#  Add the remote repository locally:
# A utility to add the new remote repository to the local Git repository.
add_remote() {
  # check if remote already exists
  if check_remote_exists "$1"; then
    echo "Remote '$1' already exists"
    git remote rm "$1"
  fi
  git remote add "$1" "$2"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to add the remote repository to the local Git repository."
    exit 1
  fi
  echo "Remote '$1' added as $2."
}

push_to_remote() {
  git push "$1" "$(git rev-parse --abbrev-ref HEAD)"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to push the repository to the remote."
    exit 1
  fi
  echo "Repository successfully pushed to remote '$1'."
}

print_usage() {
  echo "Usage: $0 [-n REMOTE_NAME] [-v] REMOTE_ADDRESS REMOTE_REPO_PATH"
    echo "Options:"
    echo "  -n REMOTE_NAME   Specify the name of the remote (default: 'origin')."
    echo "  -v               Enable verbose mode to display detailed output."
    echo "Arguments:"
    echo "  REMOTE_ADDRESS    The SSH address of the remote server."
    echo "  REMOTE_REPO_PATH  The path where the remote repository will be created."
  exit 1
}




verbose_mode=false

log() {
  if [ "$verbose_mode" = true ]; then
    echo "$1"
  fi
}

make_repo_name() {
  local path="$1"
  # remove home directory from path
  path=$(echo "$path" | sed "s|$HOME/||")
  # remove ~/workspace from path
  # if path has workspace in it, then remove everything before workspace
  if [[ "$path" == *workspace* ]]; then
    path=$(echo "$path" | sed 's/.*workspace\///')
  fi
  # remove trailing slash
  if [[ "$path" == *\/ ]]; then
    path=$(echo "$path" | sed 's/.$//')
  fi
  # repo_name=$(echo "$path" | sed 's/\//-/g')
  repo_name=$(echo "$path")
  if [ "$repo_name" = "/" ]; then
    repo_name="root"
  fi
  echo "$repo_name.git"
}



parse_arguments() {
  # Default values
  remote_name="gitsrv"
  verbose_mode=false

  # Parse options
  while getopts ":n:v" opt; do
    case $opt in
      n) remote_name="$OPTARG" ;;   # Set remote name if provided with -n option
      v) verbose_mode=true ;;       # Enable verbose mode with -v option
      \?) 
        echo "Invalid option: -$OPTARG" >&2
        print_usage
        ;;
      :) 
        echo "Option -$OPTARG requires an argument." >&2
        print_usage
        ;;
    esac
  done

  # Shift the processed options to get to the positional arguments
  shift $((OPTIND -1))

  # Check if required positional arguments are provided
  if [ $# -lt 1 ]; then
    echo "Error: Missing required arguments."
    print_usage
  fi

  # Positional arguments
  remote_address="$1"        # First argument: Remote address

  if [ $# -lt 2 ]; then
    remote_repo_path="."
  else
    remote_repo_path="$2"      # Second argument: Path to the remote repo
  fi
  


}

# Main script execution
main() {
  # Parse command line arguments
  parse_arguments "$@"

  # Ensure we're in a Git repository
  is_git_repo

  if [ "$remote_repo_path" = "." ]; then
    remote_repo_path=$(make_repo_name "$(pwd)")
    remote_repo_path="$DEFAULT_REMOTE_REPO_PATH/$remote_repo_path"
  fi

  # Final summary (optional in verbose mode)
  log "Remote address: $remote_address"
  log "Remote repo path: $remote_repo_path"
  log "Remote name: $remote_name"
  log "Verbose mode: $verbose_mode"
  # Check SSH connection to the remote server
  check_ssh_connection "$remote_address"

  # Create bare repository on the remote
  create_remote_bare_repo "$remote_address" "$remote_repo_path"

  # Add the remote repository locally
  add_remote "$remote_name" "ssh://$remote_address/$remote_repo_path"

  # Push the local repository to the new remote
  push_to_remote "$remote_name"
}

# Run the script
main "$@"