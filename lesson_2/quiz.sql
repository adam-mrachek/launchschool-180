-- 5.

CREATE TABLE names (
  id serial,
  name varchar(25)
);

INSERT INTO names (name)
VALUES ('Abebi'), ('Allysa'), ('amy'), ('ben'), ('Becky'), ('Christophe'),
       ('Camilla'), ('david'), ('Elsa'), ('frank'), ('Felips');

-- 6.

CREATE TABLE users (
  id serial,
  name varchar(25),
  email varchar(50),
  admin boolean,
  last_login timestamp
);

INSERT INTO users (name, email, admin, last_login)
VALUES ('Mike', 'mikeym@example.com', false, '2017-12-30 08:43:12'),
       ('Gustavo', 'gus@example.com', true, '2018-01-12 22:17:34'),
       ('Tamara', 'tammy@example.com', true, '2018-01-15 09:22:22'),
       ('Arron', 'arronrose@example.com', NULL, '2018-01-29 21:37:46'),
       ('Jane', 'jane@example.com', false, '2017-11-28 15:17:21');

-- 10.

CREATE TABLE class_ice_cream_survey (
  id serial,
  name varchar(25),
  age int,
  favorite_flavor varchar(25)
);

INSERT INTO class_ice_cream_survey (name, age, favorite_flavor)
VALUES ('Afia', 6, 'Strawberry'),
       ('Ben', 6, 'Chocolate'),
       ('Clara', 6, 'Strawberry'),
       ('David', 7, 'Rocky Road'),
       ('Emma', 6, 'Vanilla'),
       ('Jian', 7, 'Chocolate'),
       ('Juana', 6, 'Chocolate'),
       ('Kayla', 7, 'Vanilla'),
       ('Michael', 6, 'Chocolate'),
       ('Sofia', 7, 'Chocolate'),
       ('Taylor', 6, 'Strawberry'),
       ('Zoe', 7, 'Chocolate');
