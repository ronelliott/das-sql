--------------------------------------------------------------------------------
-- Accounts
--------------------------------------------------------------------------------

CREATE TABLE accounts(
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(255) NOT NULL DEFAULT '',
	created TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
	modified TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Auto-update the modified column on account update
CREATE TRIGGER accounts_update_modified_column
	BEFORE UPDATE ON accounts
	FOR EACH ROW
	EXECUTE PROCEDURE update_modified_column();
