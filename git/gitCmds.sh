#!/bin/bash

# Nifty way to check if there are any local diffs.
# --porcelain makes the ouptu script friendly
# -uno removes untracked files from the output
if [ -z $(git status -s --porcelain -uno) ]; then
   echo "There are untracked changes"
fi

# Or, perhaps a better solution:
if ! git diff --exit-code &>/dev/null; then
   echo "This command exits with 1 when there's differences."
fi


