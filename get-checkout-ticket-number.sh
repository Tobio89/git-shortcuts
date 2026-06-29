#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=git-shortcuts.conf
source "$SCRIPT_DIR/git-shortcuts.conf"

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
    echo "$matches"
    return 1
  fi

  local branch
  branch=$(echo "$matches" | tr -d ' ')
  git checkout "$branch"
}