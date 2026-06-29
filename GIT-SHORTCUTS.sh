#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/git-shortcuts.conf"
source "$SCRIPT_DIR/get-checkout-ticket-number.sh"
source "$SCRIPT_DIR/git-commit-ticket-number"
source "$SCRIPT_DIR/git-pull-current.sh"
source "$SCRIPT_DIR/git-push-current.sh"
source "$SCRIPT_DIR/git-remove-closed-branches.sh"

alias gcm="git commit -m "
alias gch="git checkout "