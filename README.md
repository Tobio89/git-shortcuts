# Git Shortcuts

A selection of shortcuts that let you use git more quickly.

## Shortcuts

### Aliases

- `gcm` = `"git commit -m "` - Commit with an arbitrary message
- `gch` = `"git checkout "` - Checkout any branch. Add `-b` to checkout a new branch

### Functions

- `gpc` - uses grep to find current branch, and push. Works even if remote doesn't have the branch!
- `gplc` - uses grep to find current branch, and pull.
- `gclear`

##### The following require `TICKET_PREFIX` to be set in `git-shortcuts.conf`

- `gcht` - check out a branch by typing in its Jira ticket number

- `gc` - make a commit using a standard commit message format: `${TICKET} ${COMMIT_TYPE}: ${MESSAGE}`
  - `-f` to explicitly set `${COMMIT_TYPE}` to `feat` (default, can be omitted)
  - `-x` to explicitly set `${COMMIT_TYPE}` to `fix`
  - `-c` to explicitly set `${COMMIT_TYPE}` to `chore`
  - `-t TICKET_NUMBER` to set TICKET to `${TICKET_PREFIX}TICKET_NUMBER`
  - `-T CUSTOM_TICKET` to set TICKET to `${CUSTOM_TICKET}`
