-- 2.

ALTER TABLE films
ALTER COLUMN title SET NOT NULL;

ALTER TABLE films
ALTER COLUMN year SET NOT NULL;

ALTER TABLE films
ALTER COLUMN genre SET NOT NULL;

ALTER TABLE films
ALTER COLUMN director SET NOT NULL;

ALTER TABLE films
ALTER COLUMN duration SET NOT NULL;

-- 4.

ALTER TABLE films
ADD CONSTRAINT unique_title
UNIQUE(title);

-- 6.

ALTER TABLE films
DROP CONSTRAINT unique_title;

-- 7.

ALTER TABLE films
ADD CONSTRAINT title_length
CHECK (length(title) >= 1);

-- 8.
-- ERROR:  new row for relation "films" violates check constraint "title_length"

-- 9.
-- Check constraints:
--     "title_length" CHECK (length(title::text) >= 1)

-- 10.

ALTER TABLE films
DROP CONSTRAINT title_length;

-- 11.

ALTER TABLE films
ADD CONSTRAINT year_range
CHECK (year BETWEEN 1900 AND 2100);

-- 12.
-- Check constraints:
--     "year_range" CHECK (year >= 1900 AND year <= 2100)

-- 13.

ALTER TABLE films
ADD CONSTRAINT director_length
CHECK (length(director) >= 3 AND position(' ' IN director) > 0);

-- 14.
-- Check constraints:
--     "director_length" CHECK (length(director::text) >= 3 AND POSITION((' '::text) IN (director)) > 0)
--     "year_range" CHECK (year >= 1900 AND year <= 2100)

-- 15.

UPDATE films
SET director = 'Johnny'
WHERE title = 'Die Hard';

ERROR:  new row for relation "films" violates check constraint "director_length"
DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).

-- 16.
-- List three ways to use the schema to restrict what values can be stored in a column.
NOT NULL
CHECK
Data type such as length limitations

-- 17.

ALTER TABLE films
ADD COLUMN revenue int CHECK (revenue > 0);

ALTER TABLE films
ALTER COLUMN revenue
SET DEFAULT 0;

UPDATE films
SET revenue = 0
WHERE title = 'Die Hard';

ERROR:  new row for relation "films" violates check constraint "films_revenue_check"
DETAIL:  Failing row contains (Die Hard, 1988, action, John McTiernan, 132, 0).

-- 18.


