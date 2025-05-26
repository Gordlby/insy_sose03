CREATE OR REPLACE FUNCTION update_accounts()
RETURNS TRIGGER AS $$
DECLARE
    sender_balance DECIMAL;
BEGIN
    SELECT amount INTO sender_balance FROM accounts WHERE id = NEW.from_client_id;

    IF sender_balance < NEW.amount THEN
        RAISE NOTICE 'Überweisung abgelehnt: Konto überzogen';
        RETURN NULL;
    END IF;

    UPDATE accounts SET amount = amount - NEW.amount WHERE id = NEW.from_client_id;
    UPDATE accounts SET amount = amount + NEW.amount WHERE id = NEW.to_client_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger anlegen
CREATE TRIGGER new_transfer
BEFORE INSERT ON transfers
FOR EACH ROW
EXECUTE FUNCTION update_accounts();