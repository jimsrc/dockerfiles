#!/bin/bash

DirDockerfile="$1"
[[ "$DirDockerfile" == "" ]] \
    || {
        echo -e " [-] ERROR: need the path to the Dockerfile!\n";
        exit 1;
    }

docker build \
    -t arch/vivaldi:latest \
    -t arch/vivaldi:`date +%d%b%Y` \
    --build-arg UID_HOST=$UID \
    --build-arg VERSION_DATE=`date +%d%b%Y` \
    "$DirDockerfile"

#EOF
