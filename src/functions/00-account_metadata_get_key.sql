--------------------------------------------------------------------------------
-- Gets the account metadata value for the given account and key
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION account_metadata_get_key(account_id INTEGER, key VARCHAR(255))
RETURNS VARCHAR(255) AS $$
#variable_conflict use_column
DECLARE value VARCHAR(255);
BEGIN
	SELECT md.value INTO value
	FROM account_metadata md
	WHERE md.account_id = $1
	AND md.key = $2;
	RETURN value;
END;
$$ language plpgsql;
