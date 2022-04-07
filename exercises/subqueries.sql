-- 1.

CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6, 2) NOT NULL CHECK(initial_price BETWEEN 0.01 AND 1000.00),
  sales_price numeric(6, 2) CHECK(sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id int NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id int NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6, 2) NOT NULL CHECK(amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

\copy bidders FROM 'bidders.csv' WITH HEADER CSV;
\copy items FROM 'items.csv' WITH HEADER CSV;
\copy bids FROM 'bids.csv' WITH HEADER CSV;

-- 2.

SELECT name AS "Bid on Items"
FROM items
WHERE id IN 
  (SELECT DISTINCT item_id FROM bids);

-- 3.

SELECT name AS "Not Bid On"
FROM items
WHERE id NOT IN (SELECT item_id FROM bids);

-- 4.

SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bidder_id = bidders.id);

SELECT DISTINCT name FROM bidders
JOIN bids
  ON bidder_id = bidders.id;

-- 5.

SELECT MAX(count) FROM (
  SELECT count(bidder_id)
  FROM bids
  GROUP BY bidder_id
) AS max;

-- 6.

SELECT items.name, (SELECT count(bids.item_id) FROM bids WHERE item_id = items.id)
FROM items;

-- Here items.id equals the current id of the value from the outer SELECT for each item.
-- This subquery is actually faster the query below using JOIN.

-- OR

SELECT items.name, COUNT(bids.item_id)
FROM items
LEFT OUTER JOIN bids
  ON items.id = item_id
GROUP BY items.name;

-- 7.

SELECT id FROM items
WHERE ROW('Painting', 100.00, 250.00) = 
      ROW(name, initial_price, sales_price);

-- 8.

EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- 9.

EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

  -- Total costs: 37.16
  -- Planning time: 0.425ms
  -- Execution time: 0.272ms


EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

  -- Total costs: 35.65
  -- Planning time: 0.384ms
  -- Execution time: 0.225ms

-- Further exploration:

EXPLAIN ANALYZE SELECT name,
(SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;
  -- Total costs: 25455
  -- Planning time: 0.464ns
  -- Execution time: 0.258ms

EXPLAIN ANALYZE SELECT items.name, COUNT(bids.item_id)
FROM items
LEFT OUTER JOIN bids
  ON items.id = item_id
GROUP BY items.name;

  -- Total costs: 68.44
  -- Planning time: 0.539ms
  -- Execution time: 0.316ms