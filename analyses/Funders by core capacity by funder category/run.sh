#!/bin/bash
scriptdir=$(dirname "$0")
origdir=$(pwd)

# run build SQL file if it exists, using `run_sql_file_with_service.sh` to run on the
# database defined in `run_sql_file_with_service`
[[ -f ./code/build.sql ]] &&
    (bash ../../util/run_sql_file_with_service.sh ./code/build.sql || exit 1)

# run analysis SQL file, using `copy.sh` to write CSV outputs
cd "$scriptdir" &&
    bash ../../util/copy.sh ./code/analysis.sql &&
    cd "$origdir" || exit 1
