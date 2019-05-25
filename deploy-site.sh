#!/usr/bin/sh

nikola build && ghp-import --cname="gpir.es" output && git push git@github.com:colobas/colobas.github.io.git gh-pages:master

