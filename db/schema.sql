-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "Users" (
    "id" uuid   NOT NULL,
    "full_name" varchar   NOT NULL,
    "email" varchar   NOT NULL,
    "password_hash" text   NOT NULL,
    "account_type_id" int   NOT NULL,
    "target_role_id" int   NOT NULL,
    "created_at" timestamp   NOT NULL,
    -- --- Admin Specific Fields (Ignored for Generics) ---
    "clearance_level" int   NULL,
    -- e.g., 'London', 'Leeds'
    "academy_region" varchar   NULL,
    -- (false)
    "can_edit_global_skills" boolean   NOT NULL,
    "audit_access_expiry" date   NULL,
    CONSTRAINT "pk_Users" PRIMARY KEY (
        "id"
     ),
    CONSTRAINT "uc_Users_email" UNIQUE (
        "email"
    )
);

CREATE TABLE "AccountTypes" (
    "id" int   NOT NULL,
    -- 'Admin', 'Consultant'
    "type_name" varchar   NOT NULL,
    CONSTRAINT "pk_AccountTypes" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Permissions" (
    "id" int   NOT NULL,
    "account_type_id" int   NOT NULL,
    -- 'view_team_gap', 'review_targets'
    "permission_name" varchar   NOT NULL,
    CONSTRAINT "pk_Permissions" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Roles" (
    "id" int   NOT NULL,
    "title" varchar   NOT NULL,
    "description" text   NOT NULL,
    CONSTRAINT "pk_Roles" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Skills" (
    "id" uuid   NOT NULL,
    "name" varchar   NOT NULL,
    "category" varchar   NOT NULL,
    CONSTRAINT "pk_Skills" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "User_Skills" (
    "user_id" uuid   NOT NULL,
    "skill_id" uuid   NOT NULL,
    "current_level" int   NOT NULL,
    -- 'Not Started', 'In Progress', 'Complete'
    "status" varchar   NOT NULL,
    "updated_at" timestamp   NOT NULL,
    CONSTRAINT "pk_User_Skills" PRIMARY KEY (
        "user_id","skill_id"
     )
);

CREATE TABLE "Certifications" (
    "id" uuid   NOT NULL,
    "name" varchar   NOT NULL,
    "issuing_body" varchar   NOT NULL,
    "learning_url" text   NOT NULL,
    CONSTRAINT "pk_Certifications" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "SMART_Targets" (
    "id" uuid   NOT NULL,
    "user_id" uuid   NOT NULL,
    "skill_id" uuid   NOT NULL,
    "certification_id" uuid   NULL,
    "goal_text" text   NOT NULL,
    "target_date" date   NOT NULL,
    "is_completed" boolean   NOT NULL,
    "admin_feedback" text   NOT NULL,
    CONSTRAINT "pk_SMART_Targets" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "Users" ADD CONSTRAINT "fk_Users_account_type_id" FOREIGN KEY("account_type_id")
REFERENCES "AccountTypes" ("id");

ALTER TABLE "Users" ADD CONSTRAINT "fk_Users_target_role_id" FOREIGN KEY("target_role_id")
REFERENCES "Roles" ("id");

ALTER TABLE "Permissions" ADD CONSTRAINT "fk_Permissions_account_type_id" FOREIGN KEY("account_type_id")
REFERENCES "AccountTypes" ("id");

ALTER TABLE "User_Skills" ADD CONSTRAINT "fk_User_Skills_user_id" FOREIGN KEY("user_id")
REFERENCES "Users" ("id");

ALTER TABLE "User_Skills" ADD CONSTRAINT "fk_User_Skills_skill_id" FOREIGN KEY("skill_id")
REFERENCES "Skills" ("id");

ALTER TABLE "SMART_Targets" ADD CONSTRAINT "fk_SMART_Targets_user_id" FOREIGN KEY("user_id")
REFERENCES "Users" ("id");

ALTER TABLE "SMART_Targets" ADD CONSTRAINT "fk_SMART_Targets_skill_id" FOREIGN KEY("skill_id")
REFERENCES "Skills" ("id");

ALTER TABLE "SMART_Targets" ADD CONSTRAINT "fk_SMART_Targets_certification_id" FOREIGN KEY("certification_id")
REFERENCES "Certifications" ("id");

