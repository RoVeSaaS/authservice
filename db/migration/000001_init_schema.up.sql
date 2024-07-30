CREATE TABLE users (
  "user_id" UUID NOT NULL PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "tenant_id" varchar NOT NULL,
  "user_name" varchar,
  "user_email" varchar,
  "first_name" varchar,
  "last_name" varchar,
  "password" varchar,
  "is_active" bool
);

CREATE TABLE roles (
  "role_id" UUID NOT NULL PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "role_name" varchar,
  "tenant_id" varchar
);
                                   
CREATE TABLE groups (
  "group_id" UUID NOT NULL PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "group_name" varchar,
  "tenant_id" varchar
);

CREATE TABLE user_roles (
  "user_id" UUID,
  "role_id" UUID,
  "tenant_id" UUID
);

CREATE TABLE user_groups (
  "user_id" UUID,
  "group_id" UUID,
  "tenant_id" UUID
);


CREATE TABLE role_groups (
  "role_id" UUID,
  "group_id" UUID,
  "tenant_id" UUID
);

CREATE TABLE tenants (
  "tenant_id" UUID NOT NULL PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "tenant_name" varchar,
  "tenant_owner" varchar,
  "is_active" bool,
  "tenant_city" varchar,
  "tenant_state" varchar,
  "tenant_country" varchar
);

CREATE INDEX ON users ("tenant_id");

CREATE INDEX ON users ("user_email");

CREATE INDEX ON roles ("tenant_id");

CREATE INDEX ON roles ("user_id");

CREATE INDEX ON roles ("tenant_id");

CREATE INDEX ON roles ("user_id");
