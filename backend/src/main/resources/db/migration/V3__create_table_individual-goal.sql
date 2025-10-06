CREATE TABLE individual_goal (
    id uuid PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    term TIMESTAMP NOT NULL,
    completed BOOLEAN DEFAULT FALSE,
    score INTEGER DEFAULT 20,
    user_id uuid NOT NULL,
    created_date TIMESTAMP,
    last_modified_date TIMESTAMP,

    CONSTRAINT fk_individual_goal_user FOREIGN KEY (user_id) REFERENCES app_user(id) ON DELETE CASCADE
);