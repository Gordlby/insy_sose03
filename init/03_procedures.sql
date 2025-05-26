CREATE OR REPLACE PROCEDURE transfer_direct(sender INTEGER, recipient INTEGER, howmuch DECIMAL)
AS $$
DECLARE
    sender_balance DECIMAL;
BEGIN
    SELECT amount INTO sender_balance FROM accounts WHERE id = sender;

    IF sender_balance IS NULL THEN
        RAISE EXCEPTION 'Sender-Konto existiert nicht';
    END IF;

    IF sender_balance < howmuch THEN
        RAISE EXCEPTION 'Nicht genügend Guthaben';
    END IF;

    UPDATE accounts SET amount = amount - howmuch WHERE id = sender;
    UPDATE accounts SET amount = amount + howmuch WHERE id = recipient;

    COMMIT;
END;
$$ LANGUAGE plpgsql;