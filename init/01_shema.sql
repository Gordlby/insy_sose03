CREATE TABLE accounts (
    id INTEGER PRIMARY KEY,
    amount DECIMAL,
    deactivated BOOLEAN DEFAULT FALSE
);

CREATE TABLE transfers (
    transfer_id SERIAL PRIMARY KEY,
    from_client_id INTEGER,
    to_client_id INTEGER,
    date DATE,
    amount DECIMAL
);