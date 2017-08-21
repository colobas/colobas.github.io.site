#!/usr/bin/sh

nikola build && ghp-import output && git push git@github.com:colobas/colobas.github.io.git gh-pages:master

