#!/bin/bash

set -euxo pipefail

git branch -D tmp || :
git checkout -b tmp

PUBLIC_URL="https://genki-s.github.io/toruneko-3-tools/" elm-app build

git add -f build
git commit -m "Release"
git push origin --delete gh-pages
git subtree push --prefix build origin gh-pages

git checkout -
