#!/bin/bash
# source: https://github.com/koalaman/shellcheck/wiki/SC2045
scriptdir=$(dirname "$0")
origdir=$(pwd)
cd "$scriptdir" &&
    if [ -d "./setup" ]; then
        echo "Running SQL files to set up"
        for f in ./setup/*.sql; do
            [[ -e "$f" ]] || break # handle the case of no *.sql files
            echo "Running SQL file $f"
            psql service=tracking-analysis -f "$f" >/dev/null
            if [ $? != 0 ]; then
                echo "SQL file run failed, please address errors above and try again."
                exit $?
            fi
        done

    else
        echo "Error: \`setup\` directory not found"
    fi
cd "$origdir" || exit
