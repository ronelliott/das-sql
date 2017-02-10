--------------------------------------------------------------------------------
-- Creates an account with the given name
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION account_create(name VARCHAR(255))
RETURNS INTEGER AS $$
DECLARE account_id INTEGER;
BEGIN
	INSERT INTO accounts (name)
	VALUES (name) RETURNING id INTO account_id;
	RETURN account_id;
END;
$$ language plpgsql;
