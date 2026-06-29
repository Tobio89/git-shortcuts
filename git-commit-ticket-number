#!/bin/bash

gc() {
  local ticketNum
  local commitType="feat"
  local customTicket=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -t) customTicket="$2"; shift 2 ;;
      -f) commitType="feat"; shift ;;
      -x) commitType="fix"; shift ;;
      -c) commitType="chore"; shift ;;
      *) break ;;
    esac
  done

  local commitMsg="$1"

  if [[ -z "$commitMsg" ]]; then
    echo "Usage: gc [-t TICKET] [-f|-x|-c] <commit message>"
    return 1
  fi

  if [[ -n "$customTicket" ]]; then
    ticketNum="$customTicket"
  else
    local targetBranch
    targetBranch=$(git status | grep -oE "On branch .+" | cut -d " " -f 3)
    ticketNum=$(echo "$targetBranch" | cut -d'/' -f2- | grep -oE "[A-Za-z0-9]+-[0-9]+-?" | sed 's/-$//')
  fi

  if [[ -z "$ticketNum" ]]; then
    echo "Could not determine ticket number. Use -t TICKET to specify one."
    return 1
  fi

  echo "Commit message: $ticketNum $commitType: $commitMsg"
  read "reply?Proceed? [y/N] "
  [[ "$reply" =~ ^[Yy]$ ]] || { echo "Aborted."; return 1; }
  git commit -m "$ticketNum $commitType: $commitMsg"
}