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

# 7a
# ---------------------------
SELECT title
FROM film
WHERE (title LIKE 'q%' OR title LIKE 'k%')
AND language_id IN
	(
	SELECT language_id
	FROM language
	WHERE name = 'English'
	);

# 7b
# ---------------------------
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(
	SELECT actor_id
	FROM film_actor
	WHERE film_id IN
		(
		SELECT film_id
		FROM film
		WHERE title = 'Alone Trip'
		));

# 7c
# ---------------------------
SELECT c.first_name, c.last_name, c.email
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
WHERE a.address_id IN
	(
	SELECT a.address_id
	FROM address a
	INNER JOIN city c
	ON a.city_id = c.city_id
	WHERE c.city_id IN
		(
		SELECT city.city_id
		FROM city
		INNER JOIN country
		ON city.country_id = country.country_id
		WHERE country.country = 'Canada'
		));

# 7d
# ---------------------------
SELECT title
FROM film
WHERE film_id IN
	(
	SELECT f.film_id
	FROM film_category f
	INNER JOIN category c
	ON f.category_id = c.category_id
	WHERE c.name = 'Family'
	);

# 7e
# ---------------------------
SELECT f.title, COUNT(f.title) AS rental_count
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
WHERE f.film_id IN
	(
	SELECT i.film_id
	FROM inventory i
	INNER JOIN rental r
	ON i.inventory_id = r.inventory_id
	)
GROUP BY f.title
ORDER BY rental_count DESC;

# 7f
# ---------------------------
SELECT c.store_id, SUM(p.amount) AS revenue
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.store_id;

# 7g
# ---------------------------
SELECT store.store_id, city.city, country.country
FROM store
	INNER JOIN address
		ON store.address_id = address.address_id
	INNER JOIN city
		ON city.city_id = address.city_id
	INNER JOIN country
		ON country.country_id = city.country_id;

# 7h
# ---------------------------
SELECT category.name, SUM(payment.amount) AS gross_revenue
FROM category
	INNER JOIN film_category
		ON category.category_id = film_category.category_id
	INNER JOIN inventory
		ON film_category.film_id = inventory.film_id
	INNER JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	INNER JOIN payment
		ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

# 8a
# ---------------------------
CREATE VIEW top_five_genres AS
SELECT category.name AS genre, SUM(payment.amount) AS gross_revenue
FROM category
	INNER JOIN film_category
		ON category.category_id = film_category.category_id
	INNER JOIN inventory
		ON film_category.film_id = inventory.film_id
	INNER JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	INNER JOIN payment
		ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

# 8b
# ---------------------------
SELECT * FROM top_five_genres;

# 8c
# ---------------------------
DROP VIEW top_five_genres;