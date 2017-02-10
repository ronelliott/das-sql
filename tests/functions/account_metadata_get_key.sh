#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

NAME=$(date +%s)
ACCOUNT=$(exec_query "SELECT account_create('$NAME');")
KEY=$(date +%s)
VALUE=$(date +%s)
exec_query "INSERT INTO account_metadata (account_id, key, value) VALUES ($ACCOUNT, '$KEY', '$VALUE');"

assert_eq \
	"Account Metadata -- Get" \
	$(exec_query "SELECT account_metadata_get_key($ACCOUNT, '$KEY');") \
	$VALUE
