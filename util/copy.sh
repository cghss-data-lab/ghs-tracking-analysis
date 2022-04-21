#!/bin/bash
fn_prefix_tmp=$(basename "$(dirname "$PWD"/..)")
fn_prefix=${2:-$fn_prefix_tmp}
fn="$fn_prefix""__$(date).csv"
fn_latest="$fn_prefix""__latest.csv"
sql=$(cat "$1")
echo "$sql"
mkdir -p results/by-date
psql service=tracking-analysis -c """\copy ($sql) to './results/by-date/$fn' csv header;""" &&
    cp "./results/by-date/$fn" "./results/$fn_latest"
