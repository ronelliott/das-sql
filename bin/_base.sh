#!/bin/bash

BASE_DIR=$(pwd)/src

exec_query_file_superuser() {
	echo "Executing as superuser: $1"
	psql \
		-h $ACCOUNTS_DB_HOST \
		-p $ACCOUNTS_DB_PORT \
		-U $ACCOUNTS_DB_SUPERUSER_USER \
		-d $ACCOUNTS_DB_SUPERUSER_DB \
		-v db=$ACCOUNTS_DB_DB \
		-v user=$ACCOUNTS_DB_USER \
		-v userquoted="'$ACCOUNTS_DB_USER'" \
		-v passquoted="'$ACCOUNTS_DB_PASS'" \
		-f "$1"
}

exec_query_files_superuser() {
	for q in ${@}; do
		exec_query_file_superuser ${q}
	done
}

exec_query_file() {
	echo "Executing: $1"
	psql \
		-h $ACCOUNTS_DB_HOST \
		-p $ACCOUNTS_DB_PORT \
		-U $ACCOUNTS_DB_USER \
		-d $ACCOUNTS_DB_DB \
		-f "$1"
}

exec_query_files() {
	for q in ${@}; do
		exec_query_file ${q}
	done
}

create() {
	exec_query_files_superuser $(find $BASE_DIR/base -type f -name "create-*.sql")
	exec_query_files $(find $BASE_DIR/triggers -type f -name "*.sql")
	exec_query_files $(find $BASE_DIR/tables -type f -name "*.sql")
	exec_query_files $(find $BASE_DIR/functions -type f -name "*.sql")
}

drop() {
	exec_query_files_superuser $(find $BASE_DIR/base -type f -name "drop-*.sql")
}
