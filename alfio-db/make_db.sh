gosu postgres postgres --single <<- EOSQL
    CREATE USER postgres;
    CREATE DATABASE alfio;
    GRANT ALL PRIVILEGES ON DATABASE alfio TO postgres;
EOSQL
