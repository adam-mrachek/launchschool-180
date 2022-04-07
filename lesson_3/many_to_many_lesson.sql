-- 1.

ALTER TABLE books_categories
ALTER COLUMN book_id
SET NOT NULL,
ALTER COLUMN category_id
SET NOT NULL;

ALTER TABLE books_categories
DROP CONSTRAINT books_categories_book_id_fkey,
DROP CONSTRAINT books_categories_category_id_fkey;

ALTER TABLE books_categories
ADD CONSTRAINT "books_categories_book_id_fkey"
FOREIGN KEY ("book_id")
REFERENCES books(id)
ON DELETE CASCADE;

ALTER TABLE books_categories
ADD CONSTRAINT "books_categories_category_id_fkey"
FOREIGN KEY ("category_id")
REFERENCES categories(id)
ON DELETE CASCADE;

-- 2.

SELECT books.id, books.author, string_agg(categories.name, ', ') AS categories 
FROM books
INNER JOIN books_categories
  ON books.id = books_categories.book_id
INNER JOIN categories
  ON categories.id = books_categories.category_id
GROUP BY books.id;

-- 3.

INSERT INTO categories (name)
VALUES ('Space Exploration'), ('Cookbook'), ('South Asia');

ALTER TABLE books
ALTER title TYPE varchar(50);

INSERT INTO books (author, title)
VALUES ('Lynn Sherr', 'Sally Ride, America''s First Woman in Space'),
       ('Charlotte Bronte', 'Jane Eyre'),
       ('Meeru Dhalwala and Vikram Vij', 'Vij''s: Elegant and Inspired Indian Cuisine');

INSERT INTO books_categories (book_id, category_id)
VALUES (4, 5), (4, 1), (4, 7);

INSERT INTO books_categories (book_id, category_id)
VALUES (5, 2), (5, 4);

INSERT INTO books_categories (book_id, category_id)
VALUES (6, 8), (6, 1), (6, 9);

-- 4.

ALTER TABLE books_categories
ADD CONSTRAINT unique_book_category_combination
UNIQUE (book_id, category_id);

-- 5. 

SELECT categories.name, COUNT(books_categories.book_id), string_agg(books.title, ', ') AS book_titles
FROM categories
  INNER JOIN books_categories
  ON categories.id = books_categories.category_id
  INNER JOIN books
  ON books.id = books_categories.book_id
GROUP BY categories.name
ORDER BY categories.name;