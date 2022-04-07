-- 1.
-- The result of using an operator on a NULL value is NULL which is the absense of value.

-- 2.
ALTER TABLE employees
ALTER COLUMN department
SET DEFAULT 'unassigned';

UPDATE employees
SET department = 'unassigned'
WHERE department IS NULL;

ALTER TABLE employees
ALTER COLUMN department
SET NOT NULL;

-- 3.

CREATE TABLE temperatures (
  date date NOT NULL,
  low int,
  high int
);

-- 4. 

INSERT INTO temperatures (date, low, high)                                                
VALUES ('2016-03-01', 34, 43),
       ('2016-03-02', 32, 44),                                                                         
       ('2016-03-03', 31, 47),                                                                                
       ('2016-03-04', 33, 42),                                                                                
       ('2016-03-05', 39, 46),                                                                                
       ('2016-03-06', 32, 43),                                                                                
       ('2016-03-07', 29, 32),                                                                                
       ('2016-03-08', 23, 31),                                                                                
       ('2016-03-09', 17, 27);

-- 5.

SELECT date, ROUND((high + low) / 2.0, 1) AS avg
FROM temperatures
WHERE date > '2016-03-01' AND date < '2016-03-09';

-- 6.

ALTER TABLE temperatures
ADD COLUMN rainfall int DEFAULT 0;

-- 7.

UPDATE temperatures
SET rainfall = ROUND((high + low) / 2, 1) - 35
WHERE ROUND((high + low) / 2, 1) > 35;

-- 8.

ALTER TABLE temperatures
ALTER COLUMN rainfall TYPE decimal(4, 3);

UPDATE temperatures
SET rainfall = (rainfall / 25.4);

-- 9.

ALTER TABLE temperatures
RENAME TO weather;

-- 10.

\d weather