CREATE TABLE books (
  id serial PRIMARY KEY,
  title text UNIQUE,
  date_published date,
  page_count int
);

ALTER TABLE books
  ALTER COLUMN title
  SET NOT NULL,
  ALTER COLUMN date_published
  SET NOT NULL,
  ALTER COLUMN page_count
  SET NOT NULL;

ALTER TABLE books
  ADD CHECK (title <> '');

INSERT INTO books (title, date_published, page_count)
  VALUES ('Foundation', '1951-06-01', 256),
         ('Hyperion', '1989-05-26', 482),
         ('I, Robot', '1950-12-02', 225),
         ('Ender''s Game', '1994-07-15', 324);

ALTER TABLE books
  ADD COLUMN stock_price numeric(5, 2) DEFAULT (10.99),
  ADD COLUMN promo_price numeric(5, 2) DEFAULT (9.99);

ALTER TABLE books
  ADD CHECK (promo_price < stock_price);

CREATE TABLE authors (
  id serial PRIMARY KEY,
  name text NOT NULL
);

-- Question 8

INSERT INTO authors (name)
  VALUES ('Dan Simmons'), ('Isaac Asimov'), ('Orson Scott Card');

ALTER TABLE books
  ADD COLUMN author_id int REFERENCES authors(id) ON DELETE CASCADE;

UPDATE books
SET author_id = 1
WHERE title = 'Hyperion';

UPDATE books
SET author_id = 2
WHERE title = 'Foundation' OR title = 'I, Robot';

UPDATE books
SET author_id = 3
WHERE title = 'Ender''s Game';

-- Question 9

UPDATE books
SET promo_price = (promo_price * 1.1),
    stock_price = (stock_price * 1.1)
WHERE author_id = 2;

-- Question 10

INSERT INTO authors (name)
VALUES ('Douglas Adams');

SELECT authors.name AS author, books.title, EXTRACT(year FROM books.date_published) AS year_published
FROM authors
LEFT OUTER JOIN books
             ON authors.id = author_id
ORDER BY year_published DESC;

-- Question 11

SELECT authors.name, COUNT(books.id) AS number_of_books, MAX(page_count) AS maximum_page_count
FROM authors
JOIN books
  ON authors.id = author_id
GROUP BY authors.name
HAVING COUNT(books.id) > 1;

-- Question 12

CREATE TABLE ab (
  a serial PRIMARY KEY,
  b int
);

INSERT INTO ab (b)
VALUES (2), (2), (2);

CREATE TABLE bc (
  b int,
  c int
);

CREATE TABLE bc (
  b int REFERENCES ab(a),
  c int
);

INSERT INTO bc (b, c)
VALUES (2, 10), (2, 9), (2, 8);

SELECT ab.*, bc.* FROM ab
INNER JOIN bc
        ON ab.b = bc.b;

SELECT * FROM ab
LEFT JOIN bc
        ON ab.b = bc.b;

SELECT * FROM ab
RIGHT JOIN bc
        ON ab.b = bc.b;

SELECT ab.*, bc.* FROM ab
INNER JOIN bc
        ON ab.a = bc.b;

SELECT ab.*, bc.* FROM ab
LEFT JOIN bc
        ON ab.a = bc.b;

SELECT ab.*, bc.* FROM ab
RIGHT JOIN bc
        ON ab.a = bc.b;