CREATE TABLE statistics (
    date DATE PRIMARY KEY,
    sum_amount DECIMAL,
    avg_amount DECIMAL,
    max_amount DECIMAL,
    taxes DECIMAL
);

CREATE OR REPLACE PROCEDURE calc_statistics()
AS $$
DECLARE
    t_date DATE;
    cur CURSOR FOR SELECT DISTINCT date FROM transfers;
    sum_amt DECIMAL;
    avg_amt DECIMAL;
    max_amt DECIMAL;
    tax DECIMAL;
BEGIN
    DELETE FROM statistics;

    OPEN cur;
    LOOP
        FETCH cur INTO t_date;
        EXIT WHEN NOT FOUND;

        SELECT SUM(amount), AVG(amount), MAX(amount)
        INTO sum_amt, avg_amt, max_amt
        FROM transfers
        WHERE date = t_date;

        SELECT SUM(
            CASE
                WHEN DATE_PART('year', date) <= 2019 THEN amount * 0.02
                ELSE amount * 0.01
            END)
        INTO tax
        FROM transfers
        WHERE date = t_date;

        INSERT INTO statistics (date, sum_amount, avg_amount, max_amount, taxes)
        VALUES (t_date, sum_amt, avg_amt, max_amt, tax);
    END LOOP;

    CLOSE cur;
END;
$$ LANGUAGE plpgsql;