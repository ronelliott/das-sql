#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

NAME=$(date +%s)
ACCOUNT=$(exec_query "SELECT account_create('$NAME');")
KEY=$(date +%s)
VALUE=$(date +%s)

assert_eq \
	"Account Metadata -- Set -- Is Empty" \
	$(exec_query "SELECT COUNT(*) FROM account_metadata WHERE account_id = $ACCOUNT AND key = '$KEY';") \
	0

exec_query "SELECT account_metadata_set_key($ACCOUNT, '$KEY', '$VALUE');"

assert_eq \
	"Account Metadata -- Set -- Did Create" \
	$(exec_query "SELECT COUNT(*) FROM account_metadata WHERE account_id = $ACCOUNT AND key = '$KEY';") \
	1

exec_query "SELECT account_metadata_set_key($ACCOUNT, '$KEY', '$VALUE $VALUE');"

assert_eq \
	"Account Metadata -- Set -- Did Update" \
	$(exec_query "SELECT value FROM account_metadata WHERE account_id = $ACCOUNT AND key = '$KEY';") \
	"$VALUE $VALUE"
