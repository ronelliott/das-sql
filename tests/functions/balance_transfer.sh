#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

NAME=$(date +%s)
DESINTATION_ACCOUNT=$(exec_query "SELECT account_create('desintation_$NAME');")
SOURCE_ACCOUNT=$(exec_query "SELECT account_create('source_$NAME');")
AMOUNT=$(date +%s)
UOT=$(date +%s)

exec_query "SELECT balance_grant($SOURCE_ACCOUNT, '$UOT', $AMOUNT);"

assert_eq \
	"Balance -- Transfer -- Source Has Balance" \
	$(exec_query "SELECT balance_get($SOURCE_ACCOUNT, '$UOT');") \
	$AMOUNT

assert_eq \
	"Balance -- Transfer -- Destination Is Empty" \
	$(exec_query "SELECT balance_get($DESINTATION_ACCOUNT, '$UOT');") \
	0.0

exec_query "SELECT balance_transfer($SOURCE_ACCOUNT, $DESINTATION_ACCOUNT, '$UOT', $AMOUNT);"

assert_eq \
	"Balance -- Transfer -- Source Is Empty" \
	$(exec_query "SELECT balance_get($SOURCE_ACCOUNT, '$UOT');") \
	0

assert_eq \
	"Balance -- Transfer -- Destination Has Balance" \
	$(exec_query "SELECT balance_get($DESINTATION_ACCOUNT, '$UOT');") \
	$AMOUNT
