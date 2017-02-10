#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $DIR/_base.sh

run_tests \
	$DIR/account_create.sh \
	$DIR/account_metadata_get_key.sh \
	$DIR/account_metadata_set_key.sh \
	$DIR/balance_get.sh \
	$DIR/balance_grant.sh \
	$DIR/balance_revoke.sh \
	$DIR/balance_transfer.sh \
	$DIR/transaction_metadata_get_key.sh \
	$DIR/transaction_metadata_set_key.sh
