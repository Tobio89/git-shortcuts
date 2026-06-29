#!/usr/bin/env bash

gpc(){
    targetBranch=$(git status | grep -oE "On branch .+" | cut -d " " -f 3)
    git push origin $targetBranch
}
