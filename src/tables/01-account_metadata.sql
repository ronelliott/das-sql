--------------------------------------------------------------------------------
-- Accounts metadata
--------------------------------------------------------------------------------

CREATE TABLE account_metadata (
	id SERIAL PRIMARY KEY NOT NULL,
	account_id INTEGER REFERENCES accounts(id) NOT NULL,
	key VARCHAR(255) NOT NULL,
	value VARCHAR(255) NOT NULL,
	created TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
	modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
	UNIQUE (account_id, key)
);

-- Auto-update the modified column on account_metadata update
CREATE TRIGGER account_metadata_update_modified_column
	BEFORE UPDATE ON account_metadata
	FOR EACH ROW
	EXECUTE PROCEDURE update_modified_column();
