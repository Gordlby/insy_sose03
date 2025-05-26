INSERT INTO accounts (id, amount) VALUES
(1, 1000.00),  -- Kunde 1
(2, 500.00),   -- Kunde 2
(3, 300.00);   -- Kunde 3

INSERT INTO transfers (from_client_id, to_client_id, date, amount) VALUES
(1, 2, '2018-03-01', 100.00),   -- Steuer: 2%
(2, 3, '2018-03-01', 50.00);    -- Steuer: 2%

INSERT INTO transfers (from_client_id, to_client_id, date, amount) VALUES
(1, 2, '2021-06-15', 200.00),   -- Steuer: 1%
(3, 1, '2021-06-15', 50.00);    -- Steuer: 1%

INSERT INTO transfers (from_client_id, to_client_id, date, amount)
VALUES (3, 2, '2021-12-01', 9999.00);  -- Konto 3 hat nicht genug Geld