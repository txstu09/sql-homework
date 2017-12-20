USE sakila;

# 1a
# ---------------------------
SELECT first_name, last_name
FROM actor;

# 1b
# ---------------------------
SELECT UPPER(CONCAT_WS(' ', first_name, last_name))
AS Actor_Name
FROM actor;

# 2a
# ---------------------------
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

# 2b
# ---------------------------
SELECT *
FROM actor
WHERE last_name LIKE '%gen%';

# 2c
# ---------------------------
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%li%';

# 2d
# ---------------------------
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan','Bangladesh','China');

# 3a
# ---------------------------
ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(255)
AFTER first_name;

# 3b
# ---------------------------
ALTER TABLE actor
MODIFY middle_name BLOB;

# 3c
# ---------------------------
ALTER TABLE actor
DROP COLUMN middle_name;

# 4a
# ---------------------------
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

# 4b
# ---------------------------
SELECT last_name, COUNT(last_name) AS name_count
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

# 4c
# ---------------------------
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO'
AND last_name = 'WILLIAMS';

# 4d
# ---------------------------
UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172;

# 5a
# ---------------------------
????????????????????????????????

# 6a
# ---------------------------
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN address a USING(address_id);

# 6b
# ---------------------------
SELECT s.first_name, s.last_name, SUM(p.amount) AS august_total
FROM staff s
INNER JOIN payment p USING(staff_id)
WHERE p.payment_date LIKE '2005-08%'
GROUP BY s.last_name;

# 6c
# ---------------------------
SELECT f.title, COUNT(a.actor_id) AS actor_count
FROM film f
INNER JOIN film_actor a USING(film_id)
GROUP BY f.title;

# 6d
# ---------------------------
SELECT f.title, COUNT(i.inventory_id) AS inventory_count
FROM inventory i
INNER JOIN film f
ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

# 6e
# ---------------------------
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_paid
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY c.last_name;

