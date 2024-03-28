    CREATE USER "memgpt"
        WITH PASSWORD 'memgpt'
        NOCREATEDB
        NOCREATEROLE
        ;

    CREATE DATABASE "memgpt"
        WITH
        OWNER = "memgpt"
        ENCODING = 'UTF8'
        TEMPLATE = 'template0'
        LC_COLLATE = 'en_US.UTF-8'
        LC_CTYPE = 'en_US.UTF-8'
        LOCALE_PROVIDER = 'libc'
        TABLESPACE = pg_default
        CONNECTION LIMIT = -1;

    -- Set up our schema and extensions in our new database.
    \c "memgpt"

    CREATE SCHEMA "memgpt"
        AUTHORIZATION "memgpt";

    ALTER DATABASE "memgpt"
        SET search_path TO "memgpt";

    CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA "memgpt";

    DROP SCHEMA IF EXISTS public CASCADE;
