--------------------------------------------------------------------------------
-- Revokes a uot balance in an account
--------------------------------------------------------------------------------

-- !!!!!! HERE BE DRAGONS
CREATE OR REPLACE FUNCTION balance_revoke(account_id INTEGER, uot VARCHAR(255), amount DECIMAL)
RETURNS BOOLEAN AS $$
BEGIN
	INSERT INTO transactions (source_account_id, destination_account_id, uot, amount)
	VALUES (account_id, account_id, uot, -1 * amount);
	RETURN TRUE;
END;
$$ language plpgsql;
