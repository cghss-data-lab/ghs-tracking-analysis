#!/bin/bash
SERVICE_DB_NAME="tracking-analysis"
SQL_FILE_PATH=${1:?Provide SQL file path}
psql service=$SERVICE_DB_NAME -f "$SQL_FILE_PATH"
