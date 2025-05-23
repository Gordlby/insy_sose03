CREATE OR REPLACE FUNCTION bilanz_mit_steuer(client_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    einzahlungen DECIMAL := 0;
    auszahlungen DECIMAL := 0;
BEGIN
    SELECT COALESCE(SUM(
        CASE
            WHEN DATE_PART('year', date) <= 2019 THEN amount * 0.98
            ELSE amount * 0.99
        END), 0)
    INTO einzahlungen
    FROM transfers
    WHERE to_client_id = client_id;

    SELECT COALESCE(SUM(amount), 0)
    INTO auszahlungen
    FROM transfers
    WHERE from_client_id = client_id;

    RETURN einzahlungen - auszahlungen;
END;
$$ LANGUAGE plpgsql;