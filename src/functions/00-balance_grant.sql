--------------------------------------------------------------------------------
-- Gives an account a uot balance
--------------------------------------------------------------------------------

-- !!!!!! HERE BE DRAGONS
CREATE OR REPLACE FUNCTION balance_grant(account_id INTEGER, uot VARCHAR(255), amount DECIMAL)
RETURNS BOOLEAN AS $$
BEGIN
	INSERT INTO transactions (source_account_id, destination_account_id, uot, amount)
	VALUES (account_id, account_id, uot, amount);
	RETURN TRUE;
END;
$$ language plpgsql;
