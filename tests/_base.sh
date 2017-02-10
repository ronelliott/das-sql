#!/bin/bash

assert_eq() {
	name=$1
	is=$(echo $2 | tr -d '\n')
	should_be=$3

	if [[ "$should_be" == "$is" ]]; then
		echo -e "\033[92m[$name]\tPassed.\033[0m"
	else
		echo -e "\033[31m[$name]\tFailed. Should be $should_be, is $is\033[0m"
	fi
}

exec_query() {
	psql \
		-h $ACCOUNTS_DB_HOST \
		-p $ACCOUNTS_DB_PORT \
		-U $ACCOUNTS_DB_USER \
		-d $ACCOUNTS_DB_DB \
		-v db=$ACCOUNTS_DB_DB \
		-v user=$ACCOUNTS_DB_USER \
		-v userquoted="'$ACCOUNTS_DB_USER'" \
		-v passquoted="'$ACCOUNTS_DB_PASS'" \
		-Aqtc "$1"
}

run_test() {
	$1
}

run_tests() {
	for t in ${@}; do
		run_test ${t}
	done
}
