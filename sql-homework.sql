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

# 