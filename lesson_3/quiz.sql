CREATE TABLE books (
  id serial PRIMARY KEY,
  name text NOT NULL,
  author varchar(50) NOT NULL,
  isbn int NOT NULL
);

ALTER TABLE books
ALTER COLUMN isbn TYPE bigint;

CREATE TABLE checkouts (
  id serial PRIMARY KEY,
  user_id int NOT NULL REFERENCES users(id),
  book_id int NOT NULL REFERENCES books(id),
  checkout_date date,
  return_date date
);

INSERT INTO users (name)
VALUES ('Linda Phillips'), ('Natalie Bradely'), ('Javier Dean'),
       ('Alma Flore'), ('Jessie Meyer');

INSERT INTO books (name, author, isbn)
VALUES ('On the Road', 'Jack Kerouac', 9780140283297),
       ('A Game of Thrones', 'George RR Martin', 9780553593716),
       ('The Da Vinci Code', 'Dan Brown', 9780307474278),
       ('The Handmaids Tale', 'Margaret Atwood', 9780385490818),
       ('Jazz', 'Toni Morrison', 9781400076215),
       ('1Q84', 'Haruki Murakami', 9780307476463);

INSERT INTO checkouts (user_id, book_id, checkout_date, return_date)
VALUES (3, 1, '2016-02-15', '2016-03-11'),
       (3, 2, '2016-03-11', '2016-05-02'),
       (5, 5, '2017-11-25', '2017-12-18'),
       (1, 4, '2017-12-22', NULL),
       (4, 6, '2018-01-02', NULL);

-- 7.

SELECT DISTINCT users.name
FROM users
JOIN checkouts
  ON users.id = user_id;

-- 8.

SELECT users.name AS "User Name", count(checkouts.id) AS "Books Checked Out"
  FROM users 
  JOIN checkouts
    ON users.id = checkouts.user_id
  GROUP BY "User Name"
  ORDER BY "User Name" ASC;

-- 9.

SELECT lu.name AS "User Name", b.name AS "Books Checked Out"
  FROM users AS lu LEFT OUTER JOIN checkouts c
  ON lu.id = c.user_id
  FULL OUTER JOIN books b
  ON b.id = c.book_id;