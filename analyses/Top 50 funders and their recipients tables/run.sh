#!/bin/bash
scriptdir=$(dirname "$0")
origdir=$(pwd)
bash ./code/build.sh &&
    cd "$scriptdir" &&
    bash ../../util/copy.sh ./code/analysis-funders.sql "Top 50 funders table" &&
    bash ../../util/copy.sh ./code/analysis-recipients.sql "Recipients of top 50 funders table" &&
    # bash ../../util/copy.sh ./code/analysis-both.sql "Top 50 funders and their recipients table" &&
    cd "$origdir" || exit
