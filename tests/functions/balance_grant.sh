#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

NAME=$(date +%s)
ACCOUNT=$(exec_query "SELECT account_create('$NAME');")
AMOUNT=$(date +%s)
UOT=$(date +%s)

assert_eq \
	"Balance -- Grant -- Is Empty" \
	$(exec_query "SELECT balance_get($ACCOUNT, '$UOT');") \
	0.0

exec_query "SELECT balance_grant($ACCOUNT, '$UOT', $AMOUNT);"

assert_eq \
	"Balance -- Grant -- Is Correct" \
	$(exec_query "SELECT balance_get($ACCOUNT, '$UOT');") \
	$AMOUNT
