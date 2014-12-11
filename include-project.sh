#!/bin/bash

# Helper script to add specified repo as a subtree, if desired.

set -e

if [ -z "$1" -o -z "$2" ]; then
    echo "include-project.sh <projname> <giturl> [branch]"
    exit 1
fi

projname=$1
giturl=$2
branch="master"

if [ ! -z "$3" ]; then
    branch=$3
fi

git remote add -f $projname $giturl
git merge -s ours --no-commit $projname/$branch
mkdir $projname
git read-tree --prefix=src/$projname/ -u $projname/$branch
git commit -m "Subtree merged $projname branch $branch"
