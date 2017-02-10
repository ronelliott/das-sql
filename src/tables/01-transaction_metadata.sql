--------------------------------------------------------------------------------
-- Transactions metadata
--------------------------------------------------------------------------------

CREATE TABLE transaction_metadata (
	id SERIAL PRIMARY KEY NOT NULL,
	transaction_id INTEGER REFERENCES transactions(id) NOT NULL,
	key VARCHAR(255) NOT NULL,
	value VARCHAR(255) NOT NULL,
	created TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
	modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
	UNIQUE (transaction_id, key)
);

-- Auto-update the modified column on transaction_metadata update
CREATE TRIGGER transaction_metadata_update_modified_column
	BEFORE UPDATE ON transaction_metadata
	FOR EACH ROW
	EXECUTE PROCEDURE update_modified_column();
