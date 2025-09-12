
function checkout_last_branch() {
  # Check if in detached HEAD state
  if [[ $(git symbolic-ref HEAD 2>/dev/null) = "" ]]; then
    current_sha=$(git rev-parse HEAD)
    local_target_branches=$(git branch --contains "$current_sha" | grep -v "\*")

    # if local_target_branches is empty, check remote branches
    if [[ -z "$local_target_branches" ]]; then
      remote_target_branches=$(git branch -r --contains "$current_sha" | grep -v "\*")
      target_branches="$remote_target_branches"
    else
      target_branches="$local_target_branches"
    fi
    # get last branch
    target_branch=$(echo "$target_branches" | tail -n 1)
    # strip remote name
    target_branch=$(echo "$target_branch" | sed 's/.*\///g')
    if [[ -n "$target_branch" ]]; then
      git checkout "$target_branch"
      # echo "Checked out branch: $target_branch"
    else
      echo "No branch found matching HEAD reference."
    fi
  else
    echo "Not in detached HEAD state."
  fi
}

function sync_remote_refs() {
  
  # If no argument is provided, throw an error
  if [ -z "$1" ]; then
    echo "No remote specified."
    return 1
  fi
  remote_target="$1"
  # Fetch all remote branches
  git fetch --all

  # Check that $remote_target is a valid remote
  if ! git remote get-url "$remote_target" &>/dev/null; then
    echo "Invalid remote: $remote_target"
    return 1
  fi

  # Push all remote branches to the specified remote
  git push "$1" refs/remotes/origin/*:refs/heads/*
}

function show_latest_commits() {
  # If no argument is provided, throw an error
  if [ -z "$1" ]; then
    echo "No number of commits specified."
    return 1
  fi

  # Get the latest $1 commits from the current branch
  git log -n "$1" --oneline
}

function update_local_branches() {
  # If no argument is provided, throw an error
  if [ -z "$1" ]; then
    echo "No remote specified."
    return 1
  fi

  remote_target="$1"
  # Fetch all remote branches
  git fetch --all

  # Check that $remote_target is a valid remote
  if ! git remote get-url "$remote_target" &>/dev/null; then
    echo "Invalid remote: $remote_target"
    return 1
  fi

  # Get all remote branches
  remote_branches=$(git branch -r | grep "$remote_target" | sed "s/$remote_target\///g")

  # Loop through each remote branch and update the local branch if it exists
  for branch in $remote_branches; do
    if git show-ref --verify --quiet refs/heads/"$branch"; then
      git checkout "$branch"
      git pull "$remote_target" "$branch"
    fi
  done

  # Checkout the main branch and pull the latest changes
  git checkout main
  git pull "$remote_target" main
}

function remove_redundant_branches() {
  # If no argument is provided, throw an error
  if [ -z "$1" ]; then
    echo "No remote specified."
    return 1
  fi

  remote_target="$1"
  # Fetch all remote branches
  git fetch --all

  # Check that $remote_target is a valid remote
  if ! git remote get-url "$remote_target" &>/dev/null; then
    echo "Invalid remote: $remote_target"
    return 1
  fi

  # Get all remote branches
  remote_branches=$(git branch -r | grep "$remote_target" | sed "s/$remote_target\///g")

  # Loop through each remote branch and delete it if it doesn't exist locally
  for branch in $remote_branches; do
    if ! git show-ref --verify --quiet refs/heads/"$branch"; then
      echo "Deleting remote branch: $branch"
      echo "Deleting local branch: $branch"

      # git push "$remote_target" --delete "$branch"
    fi
  done
}

function remove_branches_merged_to_master() {
  # If no argument is provided, throw an error
  if [ -z "$1" ]; then
    echo "No remote specified."
    return 1
  fi

  remote_target="$1"
  # Fetch all remote branches
  git fetch --all

  # Check that $remote_target is a valid remote
  if ! git remote get-url "$remote_target" &>/dev/null; then
    echo "Invalid remote: $remote_target"
    return 1
  fi

  # Get all remote branches
  remote_branches=$(git branch -r | grep "$remote_target" | sed "s/$remote_target\///g")

  # Loop through each remote branch and delete it if it doesn't exist locally
  for branch in $remote_branches; do
    if [ "$branch" != "master" ]; then
      git checkout "$branch"
      if git merge-base --is-ancestor master HEAD; then
        echo "Deleting local branch: $branch"
        # git branch -d "$branch"
      fi
    fi
  done

  # Checkout the master branch and pull the latest changes
  git checkout master
  git pull "$remote_target" master

}

# if git merge-base --is-ancestor master feature/pr_bias_fix; then
#   echo "master is an ancestor of feature/pr_bias_fix"
# else
#   echo "master is not an ancestor of feature/pr_bias_fix"
# fi