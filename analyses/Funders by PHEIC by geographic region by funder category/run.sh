#!/bin/bash
scriptdir=$(dirname "$0")
origdir=$(pwd)
bash ./code/build.sh &&
    cd "$scriptdir" &&
    bash ../../util/copy.sh ./code/analysis.sql "Funders by PHEIC by geographic region by funder category" &&
    bash ../../util/copy.sh ./code/analysis-agg_by_region.sql "Amount funded by PHEIC by WHO region" &&
    cd "$origdir" || exit
