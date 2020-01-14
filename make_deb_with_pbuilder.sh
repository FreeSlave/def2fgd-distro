#!/bin/sh

set -e

PROJECT_NAME=def2fgd

if [ -z "$1" ]; then
    echo "Must specify a path to pbuilder basetgz"
    exit 1
fi

BASETGZ="$1"
OUTPUTDIR="../$(basename "$BASETGZ" .tgz)"

if [ -n "$2" ]; then
    OUTPUTDIR=$(readlink -f -- "$2")
fi

(cd "deb/$PROJECT_NAME" && mkdir -p "$OUTPUTDIR" && pdebuild --buildresult $OUTPUTDIR -- --basetgz "$BASETGZ")
