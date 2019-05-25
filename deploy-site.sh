#!/usr/bin/sh

nikola build

# the final website code goes to the gh-pages branch in this repo
ghp-import --cname="gpir.es" output 

# push from the gh-pages branch of this repo
# to the master branch on the real website repo
git push git@github.com:colobas/colobas.github.io.git gh-pages:master

