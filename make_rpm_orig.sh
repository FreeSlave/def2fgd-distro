#!/bin/sh

set -e

PROJECT_NAME=def2fgd
PROJECT_PATH="../$PROJECT_NAME"
TREE=HEAD
VERSION="$(cat $PROJECT_PATH/version)"
mkdir -p rpm/SOURCES
ORIG="rpm/SOURCES/${PROJECT_NAME}-${VERSION}.tar.gz"
git --git-dir="$PROJECT_PATH/.git" archive --prefix="$PROJECT_NAME-$VERSION/" --output="$ORIG" "$TREE"
