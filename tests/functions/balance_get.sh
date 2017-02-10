#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

NAME=$(date +%s)
DESINTATION_ACCOUNT=$(exec_query "SELECT account_create('desintation_$NAME');")
SOURCE_ACCOUNT=$(exec_query "SELECT account_create('source_$NAME');")
AMOUNT=$(date +%s)
UOT=$(date +%s)

assert_eq \
	"Balance -- Get -- Is Empty" \
	$(exec_query "SELECT balance_get($DESINTATION_ACCOUNT, '$UOT');") \
	0.0

exec_query "INSERT INTO transactions (destination_account_id, source_account_id, amount, uot) VALUES ($DESINTATION_ACCOUNT, $SOURCE_ACCOUNT, $AMOUNT, '$UOT');"

assert_eq \
	"Balance -- Get -- Has Balance" \
	$(exec_query "SELECT balance_get($DESINTATION_ACCOUNT, '$UOT');") \
	$AMOUNT
