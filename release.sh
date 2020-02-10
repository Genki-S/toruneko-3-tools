#!/bin/bash

set -euxo pipefail

git branch -D tmp
git checkout -b tmp

PUBLIC_URL="https://genki-s.github.io/shiren-5plus-tools/" elm-app build

git add -f build
git commit -m "Release"
git subtree push --prefix build origin gh-pages

git checkout -
