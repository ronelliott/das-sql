--------------------------------------------------------------------------------
-- Returns the balance for the given uots and account
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION balance_get(account_id INTEGER, uot VARCHAR(255))
RETURNS DECIMAL AS $$
#variable_conflict use_variable
DECLARE balance DECIMAL;
BEGIN
	SELECT SUM(t.amount) INTO balance
	FROM transactions t
	WHERE t.destination_account_id = account_id
	AND t.uot = uot;
	RETURN COALESCE(balance, 0.0);
END;
$$ language plpgsql;
