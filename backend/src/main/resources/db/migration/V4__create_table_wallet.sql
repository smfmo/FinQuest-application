CREATE TABLE wallet(
    id uuid PRIMARY KEY,
    balance NUMERIC(19, 2) NOT NULL DEFAULT 0.00,
    user_id uuid NOT NULL UNIQUE,
    created_date TIMESTAMP,
    last_modified_date TIMESTAMP,

    CONSTRAINT fk_wallet_user FOREIGN KEY (user_id) REFERENCES app_user(id) ON DELETE CASCADE
);