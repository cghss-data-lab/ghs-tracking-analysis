fn=$(basename "$(dirname "$PWD"/..)")__$(date).csv
sql=$(cat $1)
echo $sql;
mkdir results;
psql service=tracking-analysis -c """\copy ($sql) to './results/$fn' csv header;""";