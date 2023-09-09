--- Initialization script for the security database: Development ONLY !!!
-- Sets up Schema, db, table 
-- Prepares seeded data that can be used for testing

-- Prepare the ULID generation function in the DB
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE OR REPLACE FUNCTION generate_ulid() RETURNS uuid
    AS $$
        SELECT (lpad(to_hex(floor(extract(epoch FROM clock_timestamp()) * 1000)::bigint), 12, '0') || encode(gen_random_bytes(10), 'hex'))::uuid;
    $$ LANGUAGE SQL;

SELECT generate_ulid();

-- Use this function to generate static value uuids. For testing
CREATE OR REPLACE FUNCTION generate_dummy_ulid(text) returns uuid AS $$
    SELECT cast($1 as uuid)
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION generate_passwd() RETURNS VARCHAR
    AS $$
        SELECT (lpad(to_hex(floor(extract(epoch FROM clock_timestamp()) * 1000)::bigint), 12, '0') || encode(gen_random_bytes(10), 'hex'))::VARCHAR;
    $$ LANGUAGE SQL;

SELECT generate_passwd();


-- Set up our own schema
CREATE SCHEMA IF NOT EXISTS DemoSchema
    AUTHORIZATION demoadmin;

GRANT ALL ON SCHEMA DemoSchema TO demoadmin WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES FOR ROLE demoadmin IN SCHEMA  DemoSchema 
GRANT ALL ON TABLES TO  demoadmin WITH GRANT OPTION;

-- Create the user table
CREATE TABLE DemoSchema.users(
    uuid UUID NOT NULL DEFAULT generate_ulid(),
    username VARCHAR(200) NOT NULL,
    userpassword VARCHAR(200) NOT NULL,
    useremail VARCHAR(200) NOT NULL,              
    PRIMARY KEY (uuid));

-- Example User creation - leave uuid on default so that a ULID is generated
-- INSERT INTO  MpathSchema.users (username, userpassword, useremail) VALUES (crypt('demo@demo.com', gen_salt('bf')), crypt('demo-test-654',gen_salt('bf')), crypt('demo@demo.com', gen_salt('bf')));


-- Seed initial users - DEV ONLY -- use constant uuid 
INSERT INTO  DemoSchema.users (uuid, username, userpassword, useremail) VALUES (generate_dummy_ulid('01865b6c-5208-a860-cb7f-69c66b0a4315'),crypt('demotest@demo.com', gen_salt('bf')), crypt('demotest',gen_salt('bf')), crypt('demotest', gen_salt('bf')));