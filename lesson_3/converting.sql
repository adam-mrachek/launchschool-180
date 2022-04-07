-- 2.

CREATE TABLE directors_films (
  id serial PRIMARY KEY,
  director_id int REFERENCES directors(id),
  film_id int REFERENCES films(id)
);

-- 3.

INSERT INTO directors_films (director_id, film_id)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6),
       (3, 7), (7, 8), (8, 9), (4, 10);

-- 4.

ALTER TABLE films
DROP COLUMN director_id;

-- 5.

SELECT films.title, directors.name
FROM films
INNER JOIN directors_films
  ON films.id = directors_films.film_id
INNER JOIN directors
  ON directors.id = directors_films.director_id
ORDER BY films.title ASC;

-- 6.

INSERT INTO films (title, "year", genre, duration)
VALUES ('Fargo', 1996, 'comedy', 98),
       ('No Country for Old Men', 2007, 'western', 122),
       ('Sin City', 2005, 'crime', 124),
       ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors (name)
VALUES ('Joel Coen'), ('Ethan Coen'), ('Frank Miller'), ('Robert Rodriguez');

INSERT INTO directors_films (director_id, film_id)
VALUES (9, 11), (9, 12), (10, 12), (11, 13), (12, 13), (12, 14);

-- 7.

SELECT directors.name, COUNT(films.id) AS films_directed
FROM directors
INNER JOIN directors_films ON directors.id = directors_films.director_id
INNER JOIN films ON films.id = directors_films.film_id
GROUP BY directors.name
ORDER BY films_directed DESC, directors.name ASC;