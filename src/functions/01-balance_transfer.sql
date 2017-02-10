--------------------------------------------------------------------------------
-- Transfer uots between accounts, returns true if the transfer was successful
-- or false otherwise
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION balance_transfer(source_account_id INTEGER, destination_account_id INTEGER, uot VARCHAR(255), amount DECIMAL)
RETURNS BOOLEAN AS $$
DECLARE source_balance DECIMAL;
BEGIN
	SELECT balance_get(source_account_id, uot) INTO source_balance;

	IF source_balance >= amount THEN
		INSERT INTO transactions (source_account_id, destination_account_id, amount, uot)
			VALUES (source_account_id, destination_account_id, amount, uot);
		INSERT INTO transactions (destination_account_id, source_account_id, amount, uot)
			VALUES (source_account_id, destination_account_id, amount * -1, uot);
		RETURN TRUE;
	END IF;

	RETURN FALSE;
END;
$$ language plpgsql;
