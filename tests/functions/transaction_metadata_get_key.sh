#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

NAME=$(date +%s)
ACCOUNT=$(exec_query "SELECT account_create('$NAME');")
exec_query "INSERT INTO transactions (destination_account_id, source_account_id, amount, uot) VALUES ($ACCOUNT, $ACCOUNT, 1.0, 'foo');"
TRANSACTION=$(exec_query "SELECT COUNT(*) FROM transactions;")
KEY=$(date +%s)
VALUE=$(date +%s)
exec_query "INSERT INTO transaction_metadata (transaction_id, key, value) VALUES ($TRANSACTION, '$KEY', '$VALUE');"

assert_eq \
	"Transaction Metadata -- Get" \
	$(exec_query "SELECT transaction_metadata_get_key($TRANSACTION, '$KEY');") \
	$VALUE
