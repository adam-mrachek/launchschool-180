-- 1.

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) UNIQUE NOT NULL,
  CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token)
VALUES ('Pat Johnson', 'XHGOAHEQ'),
       ('Nancy Monreal', 'JKWQPJKL'),
       ('Lynn Blake', 'KLZXWEEE'),
       ('Chen Ke-Hua', 'KWETYCVX'),
       ('Scott Lakso', 'UUEAPQPS'),
       ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services (description, price)
VALUES ('Unix Hosting', 5.95),
       ('DNS', 4.94),
       ('Whois Registration', 1.95),
       ('High Bandwidth', 15.00),
       ('Business Support', 250.00),
       ('Dedicated Hosting', 50.00),
       ('Bulk Email', 250.00),
       ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id int REFERENCES customers(id) ON DELETE CASCADE,
  service_id int REFERENCES services(id),
  UNIQUE (customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id)
VALUES (1, 1), (1, 2), (1, 3),
       (3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
       (4, 1), (4, 4),
       (5, 1), (5, 2), (5, 6),
       (6, 1), (6, 6), (6, 7);

-- 2.

SELECT DISTINCT customers.*
FROM customers
  INNER JOIN customers_services 
          ON customers.id = customers_services.customer_id;

-- 3.

SELECT customers.*, customers_services.service_id
FROM customers
  LEFT OUTER JOIN customers_services
               ON customer_id = customers.id
WHERE service_id IS NULL;

SELECT customers.*, services.*
FROM customers
  LEFT OUTER JOIN customers_services
               ON customer_id = customers.id
  FULL OUTER JOIN services
                ON services.id = customers_services.service_id
WHERE service_id IS NULL;

-- 4.

SELECT services.description
FROM customers_services
RIGHT OUTER JOIN services
              ON services.id = customers_services.service_id
WHERE customers_services.service_id IS NULL;

-- 5.

SELECT customers.name, string_agg(services.description, ', ') AS services
FROM customers
LEFT OUTER JOIN customers_services
             ON customers_services.customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = customers_services.service_id
GROUP BY customers.name;

-- 6.

SELECT services.description, COUNT(customers_services.customer_id)
FROM services
JOIN customers_services
  ON services.id = service_id
GROUP BY services.description
HAVING COUNT(customers_services.customer_id) >= 3;

-- 7.

SELECT SUM(services.price) AS gross
FROM services
JOIN customers_services
  ON service_id = services.id;

-- 8.

INSERT INTO customers (name, payment_token)
VALUES ('John Doe', 'EYODHLCN');

INSERT INTO customers_services (customer_id, service_id)
VALUES (7, 1), (7, 2), (7, 3);

-- 9.

SELECT * FROM services
WHERE price > 100;

SELECT customers.name, services.*
FROM customers
JOIN customers_services
  ON customers.id = customer_id
JOIN services
  ON service_id = services.id
WHERE services.price > 100;

SELECT SUM(services.price)
FROM services
JOIN customers_services
  ON services.id = service_id
WHERE price > 100;

SELECT SUM(services.price)
FROM customers
CROSS JOIN services
WHERE price > 100;

-- 10.

DELETE FROM customers
WHERE id = 4;

DELETE FROM customers_services
WHERE service_id = 7;

DELETE FROM services
WHERE id = 7;