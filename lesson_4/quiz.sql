CREATE TABLE users (
  id serial PRIMARY KEY,
  name varchar(25) NOT NULL
);

CREATE TABLE user_roles (
  id serial PRIMARY KEY,
  role varchar(25) NOT NULL,
  user_id int NOT NULL REFERENCES users(id)
);

INSERT INTO users (name)
VALUES ('Alex'), ('Jess'), ('Jin'), ('Paulo'), ('Sarah');

INSERT INTO user_roles (role, user_id)
VALUES ('Admin', 2), ('Member', 3), ('Admin', 1), ('Member', 4), ('Editor', 5);