#!/bin/bash
scriptdir=$(dirname "$0")
origdir=$(pwd)
cd "$scriptdir" &&
    bash ../../util/copy.sh ./code/analysis.sql &&
    cd "$origdir" || exit 1
