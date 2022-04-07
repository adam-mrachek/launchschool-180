-- 2. 

ALTER TABLE orders
ADD CONSTRAINT orders_product_id_fkey
FOREIGN KEY (product_id)
REFERENCES products(id);

-- 3.

INSERT INTO products (name)
VALUES ('small bolt'), ('large bolt');

INSERT INTO orders (product_id, quantity)
VALUES (1, 10), (1, 25), (2, 15);

-- 4. 

SELECT quantity, products.name
FROM orders
JOIN products
ON orders.product_id = products.id;

-- 5.
-- You can insert a row into orders without a product_id:
INSERT INTO orders (quantity)
VALUES (20);

-- 6.
-- This will throw an error because the product_id column contains null values:
ALTER TABLE orders
ALTER COLUMN product_id
SET NOT NULL;

-- 7.
-- Delete row will null value
DELETE FROM orders
WHERE id = 4;

-- 8. 

CREATE TABLE reviews (
  id serial PRIMARY KEY,
  body varchar(100) NOT NULL,
  product_id integer REFERENCES products(id) NOT NULL
);

-- 9.

INSERT INTO reviews (product_id, body)
VALUES (1, 'a little small'),
       (1, 'very round!'),
       (2, 'could have been smaller');