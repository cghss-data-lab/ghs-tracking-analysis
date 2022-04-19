fn=$(basename "$(dirname "$PWD"/..)")__$(date).csv
fn_latest=$(basename "$(dirname "$PWD"/..)")__latest.csv
sql=$(cat $1)
echo $sql;
mkdir -p results/by-date;
psql service=tracking-analysis -c """\copy ($sql) to './results/by-date/$fn' csv header;""" && \
cp "./results/by-date/$fn" "./results/$fn_latest";