-- 1. Create a database 
-- from psql console:
CREATE DATABASE animals;

-- or from terminal: createdb animals

-- 2. Create a table

CREATE TABLE birds (
  id serial PRIMARY KEY,
  name varchar(25),
  age integer,
  species varchar(15)
);

-- 3. Insert data into database.

INSERT INTO birds (name, age, species)
  VALUES ('Charlie', 3, 'Finch'),
         ('Allie', 5, 'Owl'),
         ('Jennifer', 3, 'Magpie'),
         ('Jamie', 4, 'Owl'),
         ('Roy', 8, 'Crow');

-- 4. Select Data

SELECT * FROM birds;

-- 5. WHERE clause

SELECT * FROM birds WHERE age < 5;

-- 6. Update data

UPDATE birds SET species = 'Raven' WHERE id = 5;

-- 7. Delete data

DELETE FROM birds WHERE species = 'Finch' AND age = 3;

-- 8. Add constraint

ALTER TABLE birds
  ADD CONSTRAINT positive_age
  CHECK (age > 0);

-- 9. Drop table

DROP TABLE birds;

-- 10. Drop database

DROP DATABASE animals; 

-- from terminal: dropdb animals