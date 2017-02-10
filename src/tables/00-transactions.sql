--------------------------------------------------------------------------------
-- Transactions
--------------------------------------------------------------------------------

CREATE TABLE transactions (
	id SERIAL PRIMARY KEY NOT NULL,
	destination_account_id INTEGER REFERENCES accounts(id) NOT NULL,
	source_account_id INTEGER REFERENCES accounts(id) NOT NULL,
	amount DECIMAL NOT NULL DEFAULT 0.0,
	uot VARCHAR(255) NOT NULL DEFAULT '',
	created TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
	modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Auto-update the modified column on transactions update
CREATE TRIGGER transactions_update_modified_column
	BEFORE UPDATE ON transactions
	FOR EACH ROW
	EXECUTE PROCEDURE update_modified_column();
