-- 1.

CREATE SEQUENCE counter;

-- 2.

SELECT nextval('counter');

-- 3. 

DROP SEQUENCE counter;

-- 4.
-- You can create a sequence that only returns even numbers:
CREATE SEQUENCE even
INCREMENT BY 2
START WITH 2;

-- 5.

CREATE TABLE regions (
  id serial PRIMARY KEY,
  name text,
  area int
);

-- This will create a sequence called regions_id_seq

-- 6.

ALTER TABLE films
ADD COLUMN id serial PRIMARY KEY;

-- 7.

UPDATE films
SET id = 3
WHERE title = 'Die Hard';

ERROR:  duplicate key value violates unique constraint "films_pkey"
DETAIL:  Key (id)=(3) already exists.

-- 8.

ALTER TABLE films
ADD COLUMN id_2 serial PRIMARY KEY;

ERROR:  multiple primary keys for table "films" are not allowed
