#!/usr/bin/env bash

gplc() {
    targetBranch=$(git status | grep -oE "On branch .+" | cut -d " " -f 3)
    git pull origin $targetBranch
}
