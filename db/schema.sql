-- Cleaned and Optimized for PostgreSQL
CREATE TABLE users (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name varchar NOT NULL,
    email varchar UNIQUE NOT NULL,
    password_hash text NOT NULL,
    account_type_id int NOT NULL,
    target_role_id int NULL, -- Changed to NULL so new users can sign up
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    
    -- Admin Specific Fields
    clearance_level int NULL,
    academy_region varchar NULL,
    can_edit_global_skills boolean DEFAULT false,
    audit_access_expiry date NULL
);

CREATE TABLE account_types (
    id int PRIMARY KEY,
    type_name varchar NOT NULL -- 'Admin', 'Consultant'
);

CREATE TABLE permissions (
    id int PRIMARY KEY,
    account_type_id int NOT NULL,
    permission_name varchar NOT NULL
);

CREATE TABLE roles (
    id int PRIMARY KEY,
    title varchar NOT NULL,
    description text NOT NULL
);

CREATE TABLE skills (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar NOT NULL,
    category varchar NOT NULL
);

CREATE TABLE user_skills (
    user_id uuid NOT NULL,
    skill_id uuid NOT NULL,
    current_level int NOT NULL,
    status varchar NOT NULL, -- 'Not Started', 'In Progress', 'Complete'
    updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, skill_id)
);

CREATE TABLE certifications (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar NOT NULL,
    issuing_body varchar NOT NULL,
    learning_url text NOT NULL
);

CREATE TABLE smart_targets (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL,
    skill_id uuid NOT NULL,
    certification_id uuid NULL,
    goal_text text NOT NULL,
    target_date date NOT NULL,
    is_completed boolean DEFAULT false,
    admin_feedback text NULL -- Changed to NULL because new targets have no feedback yet
);

-- Foreign Key Constraints
ALTER TABLE users ADD CONSTRAINT fk_users_account_type FOREIGN KEY(account_type_id) REFERENCES account_types (id);
ALTER TABLE users ADD CONSTRAINT fk_users_target_role FOREIGN KEY(target_role_id) REFERENCES roles (id);

ALTER TABLE permissions ADD CONSTRAINT fk_permissions_account_type FOREIGN KEY(account_type_id) REFERENCES account_types (id);

ALTER TABLE user_skills ADD CONSTRAINT fk_user_skills_user FOREIGN KEY(user_id) REFERENCES users (id);
ALTER TABLE user_skills ADD CONSTRAINT fk_user_skills_skill FOREIGN KEY(skill_id) REFERENCES skills (id);

ALTER TABLE smart_targets ADD CONSTRAINT fk_smart_targets_user FOREIGN KEY(user_id) REFERENCES users (id);
ALTER TABLE smart_targets ADD CONSTRAINT fk_smart_targets_skill FOREIGN KEY(skill_id) REFERENCES skills (id);
ALTER TABLE smart_targets ADD CONSTRAINT fk_smart_targets_cert FOREIGN KEY(certification_id) REFERENCES certifications (id);