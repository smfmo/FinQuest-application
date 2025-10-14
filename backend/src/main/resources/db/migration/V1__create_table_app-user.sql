CREATE TABLE app_user ( -- system user --
    id uuid PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    created_date TIMESTAMP,
    last_modified_date TIMESTAMP,

    CONSTRAINT chk_roles CHECK ( role IN ('USER'))
);
