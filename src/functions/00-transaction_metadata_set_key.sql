--------------------------------------------------------------------------------
-- Sets the transaction metadata value for the given transaction and key
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION transaction_metadata_set_key(transaction_id INTEGER, key VARCHAR(255), value VARCHAR(255))
RETURNS VOID AS $$
#variable_conflict use_column
BEGIN
	INSERT INTO transaction_metadata (transaction_id, key, value)
	VALUES($1, $2, $3)
	ON CONFLICT (transaction_id, key) DO UPDATE
		SET
			key = EXCLUDED.key,
			value = EXCLUDED.value;
END;
$$ language plpgsql;
