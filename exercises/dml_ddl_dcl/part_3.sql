-- The statement below uses the Data Definition Language (DDL) component of SQL

CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);