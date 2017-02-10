--------------------------------------------------------------------------------
-- Gets the transaction metadata value for the given transaction and key
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION transaction_metadata_get_key(transaction_id INTEGER, key VARCHAR(255))
RETURNS VARCHAR(255) AS $$
#variable_conflict use_column
DECLARE value VARCHAR(255);
BEGIN
	SELECT md.value INTO value
	FROM transaction_metadata md
	WHERE md.transaction_id = $1
	AND md.key = $2;
	RETURN value;
END;
$$ language plpgsql;
