    #!/usr/bin/env bash
gclear(){
    set -euo pipefail

    echo "Fetching and pruning remote refs..."
    git fetch --prune

    gone=$(git branch -vv | awk '/: gone]/ && $1 != "*" {print $1}')

    if [[ -z "$gone" ]]; then
        echo "No local branches with deleted remotes."
        return 0
    fi

    echo
    echo "The following local branches track deleted remotes:"
    echo "$gone" | sed 's/^/  /'
    echo

    read -r -p "Delete these branches? [y/N] " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        failed=()
        while IFS= read -r branch; do
            if git branch -d "$branch" 2>/dev/null; then
                echo "Deleted: $branch"
            else
                echo "Skipped (unmerged commits): $branch"
                failed+=("$branch")
            fi
        done <<< "$gone"

        if [[ ${#failed[@]} -gt 0 ]]; then
            echo
            echo "The following branches could not be safely deleted (unmerged commits):"
            printf '  %s\n' "${failed[@]}"
            echo
            read -r -p "Force-delete these branches? [y/N] " force_response
            if [[ "$force_response" =~ ^[Yy]$ ]]; then
                for branch in "${failed[@]}"; do
                    git branch -D "$branch"
                    echo "Force-deleted: $branch"
                done
            else
                echo "Skipped force-delete."
            fi
        fi

        echo "Done."
    else
        echo "Aborted."
    fi
}