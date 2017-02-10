#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

COUNT=$(exec_query "SELECT COUNT(*) FROM accounts;")
INSERTED_COUNT=$((COUNT + 1))
NAME=$(date +%s)

exec_query "SELECT account_create('$NAME');"

assert_eq \
	"Account -- Create -- did create" \
	$(exec_query "SELECT COUNT(*) FROM accounts;") \
	$INSERTED_COUNT

assert_eq \
	"Account -- Create -- did set name" \
	$(exec_query "SELECT name FROM accounts WHERE id = $INSERTED_COUNT;") \
	$NAME
