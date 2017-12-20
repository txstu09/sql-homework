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
