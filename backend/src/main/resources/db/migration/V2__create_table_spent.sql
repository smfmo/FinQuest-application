CREATE TABLE spent (
    id uuid PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    date TIMESTAMP,
    category VARCHAR(50) NOT NULL,
    amount_spent NUMERIC(19, 2) NOT NULL,
    user_id uuid NOT NULL,
    created_date TIMESTAMP,
    last_modified_date TIMESTAMP,

    CONSTRAINT fk_spent_app_user FOREIGN KEY (user_id) REFERENCES app_user(id) ON DELETE CASCADE,
    CONSTRAINT chk_category CHECK ( category in ('SAUDE', 'LAZER', 'ESTUDO', 'OUTROS') )
);