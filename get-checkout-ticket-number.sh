#!/bin/bash

gcht() {
  local ticketNum="$1"

  if [[ -z "$ticketNum" ]]; then
    echo "Usage: gchtgc <ticket-number>"
    return 1
  fi

  local matches
  matches=$(git branch -a | grep -iE "${TICKET_PREFIX}$ticketNum-" | sed 's/^\* //' | sed 's|remotes/[^/]*/||' | sort -u)

  local count
  count=$(echo "$matches" | grep -c .)

  if [[ $count -eq 0 ]]; then
    echo "No branch found matching ticket: $ticketNum"
    return 1
  fi

  if [[ $count -gt 1 ]]; then
    echo "Multiple branches found matching ticket: $ticketNum"
    local branch_array=()
    while IFS= read -r line; do
      branch_array+=("$line")
    done <<< "$matches"

    local i
    for i in "${!branch_array[@]}"; do
      echo "$((i+1))) ${branch_array[$i]}"
    done

    local choice
    read -rp "Select branch (1-$count): " choice

    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [[ $choice -lt 1 ]] || [[ $choice -gt $count ]]; then
      echo "Invalid selection"
      return 1
    fi

    local branch="${branch_array[$((choice-1))]}"
    git checkout "$branch"
    return
  fi

  local branch
  branch=$(echo "$matches" | tr -d ' ')
  git checkout "$branch"
}