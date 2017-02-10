#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

NAME=$(date +%s)
ACCOUNT=$(exec_query "SELECT account_create('$NAME');")
exec_query "INSERT INTO transactions (destination_account_id, source_account_id, amount, uot) VALUES ($ACCOUNT, $ACCOUNT, 1.0, 'foo');"
TRANSACTION=$(exec_query "SELECT COUNT(*) FROM transactions;")
KEY=$(date +%s)
VALUE=$(date +%s)

assert_eq \
	"Transaction Metadata -- Set -- Is Empty" \
	$(exec_query "SELECT COUNT(*) FROM transaction_metadata WHERE transaction_id = $TRANSACTION AND key = '$KEY';") \
	0

exec_query "SELECT transaction_metadata_set_key($TRANSACTION, '$KEY', '$VALUE');"

assert_eq \
	"Transaction Metadata -- Set -- Did Create" \
	$(exec_query "SELECT COUNT(*) FROM transaction_metadata WHERE transaction_id = $TRANSACTION AND key = '$KEY';") \
	1

exec_query "SELECT transaction_metadata_set_key($TRANSACTION, '$KEY', '$VALUE $VALUE');"

assert_eq \
	"Transaction Metadata -- Set -- Did Update" \
	$(exec_query "SELECT value FROM transaction_metadata WHERE transaction_id = $TRANSACTION AND key = '$KEY';") \
	"$VALUE $VALUE"
