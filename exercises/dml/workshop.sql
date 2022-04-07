-- 1. 

CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT(current_timestamp)
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number int UNIQUE NOT NULL,
  device_id int REFERENCES devices(id)
);

-- 2.

INSERT INTO devices (name)
VALUES ('Accelerometer'), ('Gyroscope');

INSERT INTO parts (part_number, device_id)
VALUES (100, 1), (101, 1), (102, 1);

INSERT INTO parts (part_number, device_id)
VALUES (200, 2), (201, 2), (202, 2), (203, 2), (204, 2);

INSERT INTO parts (part_number)
VALUES (900), (901), (902);

-- 3.

SELECT devices.name, parts.part_number
FROM devices
INNER JOIN parts
ON devices.id = parts.device_id;

-- 4.

SELECT part_number FROM parts
WHERE part_number::text LIKE '2%';

-- 5.

SELECT devices.name, COUNT(parts.part_number) AS number_of_parts
FROM devices
LEFT OUTER JOIN parts
ON devices.id = parts.device_id
GROUP BY devices.name;

-- 6.

SELECT devices.name, COUNT(parts.part_number) AS number_of_parts
FROM devices
LEFT OUTER JOIN parts
ON devices.id = parts.device_id
GROUP BY devices.name
ORDER BY devices.name DESC;

-- 7.

SELECT part_number, device_id FROM parts
WHERE device_id IS NOT NULL;

SELECT part_number, device_id FROM parts
WHERE device_id IS NULL;

-- 8.

INSERT INTO devices (name)
VALUES ('Magnetometer');

INSERT INTO parts (part_number, device_id)
VALUES (300, 3);

SELECT name FROM devices
ORDER BY created_at ASC
LIMIT 1;

-- 9.

UPDATE parts
SET device_id = 1
WHERE part_number = 203 OR part_number = 204;

-- 10.

DELETE FROM parts
WHERE device_id = 1;

DELETE FROM devices
WHERE id = 1;