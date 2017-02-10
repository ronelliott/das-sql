# DAC SQL

A double-entry accounting system in pure PostgreSQL. Note that this is only part
of the accounting system, you will still need something calling `balance_grant`
and `balance_revoke` (like a worker for a particular payment processor) to
maintain zero-sum. Other services using this service should not use the tables
directly, and instead should use the available functions. Database credentials
should be created in such a manner as to only give access to the minimal amount
of functions needed to perform their tasking.

_**NOTE: THERE ARE 2 "DANGEROUS" FUNCTIONS, `balance_grant` AND `balance_revoke`.
THESE FUNCTIONS IGNORE BALANCES WHEN CREATING/REVOKING BALANCES. THEY SHOULD BE
DROPPED IF NOT NEEDED, OR PROTECTED IF THEY ARE.**_

Table of Contents
=================

1. [Definitions](#definitions)
2. [Functions](#functions)
3. [Tables](#tables)
4. [Triggers](#triggers)

## Definitions

### Account
A collection of transactions, usually attached (externally) to some entity, such
as a customer or business.

### Transaction
A transfer between two accounts.

### Unit of Trade (UOT)
A unit representing value, such as a currency, energy drinks, chickens, etc.

## Functions

### `account_create`
Create an account with the given name

### `account_metadata_get_key`
Get the given account metadata value for the given key and account id.

### `account_metadata_set_key`
Set the given account metadata key to the given value for the given
account id.

### `balance_get`
Get the balance for the given account id and uot

### `balance_grant`
Give the given account id the given balance in the given uot.

### `balance_revoke`
Remove the given balance in the given uot from the given account id.

### `balance_transfer`
Transfer the given balance in the given uot from the given source account id to
the given destination account id.

### `transaction_metadata_get_key`
Get the given transaction metadata value for the given key and transaction id.

### `transaction_metadata_set_key`
Set the given transaction metadata key to the given value for the given
transaction id.

## Tables

### `accounts`
Holds accounts and their names that have been created.

### `accounts_metadata`
A key value store for attaching data to accounts.

### `transactions`
Holds transactions and their source and destination account, uot and amount.

### `transactions_metadata`
A key value store for attaching data to transactions.

## Triggers

### `update_modified_column`

Updates the row's modified timestamp. Attached to:

* `accounts`
* `accounts_metadata`
* `transactions`
* `transactions_metadata`
