-- drop roles and users if exists
DROP USER IF EXISTS readonly_user;

DROP USER IF EXISTS readwrite_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON TABLES FROM readonly;

REVOKE ALL ON DATABASE ai_3 FROM readonly;

REVOKE ALL ON DATABASE ai_3_staging FROM readonly;

REVOKE ALL ON SCHEMA public FROM readonly;

REVOKE ALL ON ALL TABLES IN SCHEMA public FROM readonly;

DROP ROLE IF EXISTS readonly;

ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON TABLES FROM readwrite;

ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL ON SEQUENCES FROM readwrite;

REVOKE ALL ON DATABASE ai_3 FROM readwrite;

REVOKE ALL ON DATABASE ai_3_staging FROM readwrite;

REVOKE ALL ON SCHEMA public FROM readwrite;

REVOKE ALL ON ALL TABLES IN SCHEMA public FROM readwrite;

DROP ROLE IF EXISTS readwrite;

-- revoke create and connect permissions from PUBLIC role
REVOKE CREATE ON SCHEMA public FROM PUBLIC;

REVOKE ALL ON DATABASE postgres FROM PUBLIC;

REVOKE ALL ON DATABASE ai_3 FROM PUBLIC;

REVOKE ALL ON DATABASE ai_3_staging FROM PUBLIC;

-- create roles
CREATE ROLE readonly;

CREATE ROLE readwrite;

-- Create user accounts
CREATE USER readonly_user WITH PASSWORD 'ai3_readonly' IN ROLE readonly;

CREATE USER readwrite_user WITH PASSWORD 'ai3_readwrite' IN ROLE readwrite;

