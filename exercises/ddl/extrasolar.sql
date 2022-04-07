-- 1.

CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance int NOT NULL CHECK (distance > 0),
  spectral_type char(1),
  companions int NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1) UNIQUE,
  mass int
);

-- 2.

ALTER TABLE planets
ADD COLUMN star_id int NOT NULL 
REFERENCES stars(id);

-- 3. 

ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);

-- 4. 

ALTER TABLE stars
ALTER distance TYPE decimal;

-- 5.

ALTER TABLE stars
ALTER spectral_type
SET NOT NULL;

ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M'));

-- 6.

ALTER TABLE stars
DROP CONSTRAINT stars_spectral_type_check;

CREATE TYPE spectral_type_enum AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ALTER spectral_type TYPE spectral_type_enum
USING spectral_type::spectral_type_enum;

-- 7.

ALTER TABLE planets
ALTER designation
SET NOT NULL;

ALTER TABLE planets
ALTER mass TYPE numeric,
ALTER mass SET NOT NULL,
ADD CHECK (mass > 0.0);

-- 8.

ALTER TABLE planets
ADD COLUMN semi_major_axis numeric;

UPDATE planets
SET semi_major_axis = 0.04
WHERE designation = 'b';

UPDATE planets
SET semi_major_axis = 40
WHERE designation = 'c';

ALTER TABLE planets
ALTER COLUMN semi_major_axis
SET NOT NULL;

-- 9. 

CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation int NOT NULL CHECK (designation > 0),
  semi_major_axis numeric CHECK (semi_major_axis > 0),
  mass numeric CHECK (mass > 0),
  planet_id int NOT NULL REFERENCES planets(id)
);

-- 10.

-- from terminal: dropdb extrasolar OR

\c other_database
DROP DATABASE extrasolar;