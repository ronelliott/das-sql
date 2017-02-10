--------------------------------------------------------------------------------
-- Sets the account metadata value for the given account and key
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION account_metadata_set_key(account_id INTEGER, key VARCHAR(255), value VARCHAR(255))
RETURNS VOID AS $$
#variable_conflict use_column
BEGIN
	INSERT INTO account_metadata (account_id, key, value)
	VALUES($1, $2, $3)
	ON CONFLICT (account_id, key) DO UPDATE
		SET
			key = EXCLUDED.key,
			value = EXCLUDED.value;
END;
$$ language plpgsql;
