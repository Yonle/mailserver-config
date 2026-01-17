CREATE TABLE virtuals (
    id SERIAL,
    email VARCHAR(255) NOT NULL DEFAULT '',
    destination VARCHAR(255) NOT NULL DEFAULT ''
);
CREATE TABLE credentials (
    id SERIAL,
    email VARCHAR(255) NOT NULL DEFAULT '',
    password VARCHAR(255) NOT NULL DEFAULT ''
);
CREATE TABLE users (
    id SERIAL,
    username VARCHAR(255) NOT NULL DEFAULT '',
    email VARCHAR(255) NOT NULL DEFAULT ''
);
