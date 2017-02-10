--------------------------------------------------------------------------------
-- Update the modified timestamp for the row if the row was updated.
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
	IF row(NEW.*) IS DISTINCT FROM row(OLD.*) THEN
		NEW.modified = now();
		RETURN NEW;
	ELSE
		RETURN OLD;
	END IF;
END;
$$ language plpgsql;
