-- 2.

SELECT count(id) FROM tickets;

-- 3.

SELECT COUNT(DISTINCT customer_id) FROM tickets;

-- 4.

SELECT ROUND(COUNT(DISTINCT customer_id) / COUNT(DISTINCT customers.id)::decimal * 100, 2) AS percent 
FROM tickets 
RIGHT OUTER JOIN customers 
ON tickets.customer_id = customers.id;

-- 5. 

SELECT events.name, COUNT(tickets.event_id) AS popularity FROM events
JOIN tickets
ON events.id = tickets.event_id
GROUP BY events.name
ORDER BY popularity DESC;

-- 6.

SELECT customers.id, customers.email, COUNT( DISTINCT tickets.event_id)
FROM customers
JOIN tickets
ON customers.id = tickets.customer_id
GROUP BY customers.id
HAVING COUNT(DISTINCT tickets.event_id) = 3;

-- 7.

SELECT events.name, events.starts_at, sections.name AS section, seats.row, seats.number AS seat
FROM tickets
JOIN events
  ON events.id = tickets.event_id
JOIN customers
  ON customers.id = tickets.customer_id
JOIN seats
  ON seats.id = tickets.seat_id
JOIN sections
  ON sections.id = seats.section_id
WHERE customers.email = 'gennaro.rath@mcdermott.co';
