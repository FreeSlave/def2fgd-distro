#!/bin/sh

set -e

PROJECT_NAME=def2fgd
PROJECT_PATH="../$PROJECT_NAME"
TREE=HEAD
VERSION="$(cat $PROJECT_PATH/version)"
ORIG="deb/${PROJECT_NAME}_${VERSION}.orig.tar.gz"
git --git-dir="$PROJECT_PATH/.git" archive --prefix="$PROJECT_NAME/" --output="$ORIG" "$TREE"
tar xf "$ORIG" --directory ./deb
