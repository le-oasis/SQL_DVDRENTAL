-- Welcome to the Oasis -- 
-- Today's lesson is SQL fundamentals -- 

-- Syntax for SELECT statement -- 
-- tables {actor,customer,film,payment}
-- Asking for an entire table  -- 
-- (*) - returns back all the columns -- 

SELECT * FROM actor;
SELECT first_name, last_name FROM actor;

-- Challenge: we want to send out a promo email to our existing customers -- 
SELECT first_name, last_name, email FROM customer;

-- SELECT DISTINCT --
-- DISTINCT keyword can be used to return only distinct values
-- in a column -- 
SELECT DISTINCT (release_year) FROM film;
SELECT DISTINCT (rating) FROM film;

-- COUNT -- 
-- how many rows there are in the payment table.
SELECT * FROM payment;
SELECT COUNT(*) FROM payment;

-- how many rows there are in the amount column front the payment table.
SELECT COUNT(amount) FROM payment;
SELECT amount FROM payment;

-- how many distinct amounts being payed --
-- distinct amount happens first before count.
SELECT COUNT (DISTINCT amount) FROM payment;


-- SELECT WHERE -- 
SELECT * FROM customer
-- looking for customer named Jared.
WHERE first_name ='Jared';

-- combining conditions with logical operators. -- 
SELECT * FROM film
-- find all the rental rates that are higher than $4 -- 
-- replacement cost > 19.99 
WHERE rental_rate > 4 AND replacement_cost >= 19.99
-- WE ONLY WANT THE R movies -- 
AND rating='R';

-- how many titles there are where these conditions happen to be true
-- how many rows would it return that satisfy these positions.
SELECT COUNT(*) FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating='R';

-- we want movies that have an R rating or PG-13
SELECT title, rating
FROM film
WHERE rating='R' OR rating = 'PG-13';

-- how many films have an R rating or PG-13 rating.
SELECT COUNT(*) FROM film
WHERE rating='R' OR rating = 'PG-13';


-- not equal to 
SELECT * FROM film
WHERE rating !='R';

-- email for the customer with the name Nancy Thomas 
SELECT email FROM customer 
WHERE first_name = 'Nancy'
AND last_name = 'Thomas';

-- description for the movie "Outlaw Hanky"
SELECT description FROM film 
WHERE title = 'Outlaw Hanky';

-- get the phone number for the customer who lives at 259 Ipoh Drive
SELECT phone FROM address
WHERE address = '259 Ipoh Drive' ;

-- ORDER BY --
SELECT * FROM customer
ORDER BY first_name DESC;

-- ORDER BY store_id -- all the first_name are in alphabetical order 
SELECT store_id, first_name, last_name FROM customer 
ORDER BY store_id, first_name;

-- ORDER BY store_id -- ASC, DESC 
SELECT store_id, first_name, last_name FROM customer 
ORDER BY store_id DESC, first_name ASC;

-- TEKKERS-- you can order by a column and not select it in your select statment.
SELECT first_name, last_name FROM customer 
ORDER BY store_id DESC, first_name ASC;

-- LIMIT - limit the amount of rows it returns in a query.
-- goes at the very end of a query request.
-- can use ORDER BY & LIMIT to get the top end rows of something.
SELECT * FROM payment
WHERE amount != 0.00 
ORDER BY payment_date DESC
LIMIT 5;

-- general layout of a table
SELECT * FROM payment
WHERE amount != 0.00 
ORDER BY payment_date DESC
LIMIT 1;

-- goal : customer_id : of : first 10 customers who
-- made a payment --
SELECT * FROM payment;

SELECT customer_id,payment_id, payment_date FROM payment
ORDER BY payment_date ASC
LIMIT 10;

-- A Ccustomer wants to quickly rent a video to watch over their
-- short lunch break.
-- What are the title of the 5 shortest (in lenght of time) movies nd the release year
SELECT * FROM film;
--
SELECT title, release_year, length 
FROM film
ORDER BY length ASC
LIMIT 5;

-- If the previous customer can watch any movie that is 
-- 50 minutes or less in run time, how much options does she have?
SELECT COUNT(title) 
FROM film
WHERE length <= 50;

-- BETWEEN OPERATOR
-- can be used to match a value against a range of values:
--value BETWEEN low AND high;
--value >= low AND value <= high;
-- You can also combine BETWEEN with the NOT logical operator:
-- value NOT BETWEEN low AND high
SELECT * FROM payment
WHERE amount BETWEEN 8 AND 9;
--
SELECT * FROM payment
WHERE amount >= 8 AND amount <= 9;

-- know the total amount of rows 
SELECT COUNT(*) FROM payment
WHERE amount BETWEEN 8 AND 9;

-- wasn't between 8 & 9 dollars.
SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8 AND 9;

-- payment date.
SELECT  * FROM payment
WHERE payment_date  BETWEEN '2007-02-01' AND '2007-02-15';

-- exclusivity.
SELECT  * FROM payment
WHERE payment_date >= '2007-02-01' AND payment_date <= '2007-02-15';



-- IN OPERATOR -- 
-- to create a condition to quickly checks to see if a value is included in a list of multiple options.
SELECT * FROM customer
WHERE first_name IN('John','Jake', 'Julie');
--
SELECT * FROM payment
WHERE amount IN (0.99,1.98,1.99);
--
SELECT customer_id, amount FROM payment
WHERE amount IN (0.99,1.98,1.99)
ORDER BY amount DESC;
--
SELECT * FROM payment
WHERE amount NOT IN (0.99,1.98,1.99);

--how many payments actually occurred
--that happened to be one of these three values
SELECT COUNT(*) FROM payment
WHERE amount  IN (0.99,1.98,1.99);


-- LIKE and ILIKE -- 
-- pattern matching with string data.
-- WHERE name LIKE '%a'  -- any sequence of characters can come before the 
-- everyone in customer table with the first name : letter J
SELECT * FROM customer 
WHERE first_name LIKE 'J%';

-- everyone in customer table with the first name that ends with S
SELECT * FROM customer 
WHERE first_name LIKE '%s';

-- how many customers names start with letter J
SELECT COUNT(*) FROM customer 
WHERE first_name LIKE 'J%';
--65 people

-- and last name starts with an "S"
-- 5 people
SELECT COUNT(*) FROM customer 
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

-- let's explore them
SELECT * FROM customer 
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

-- ilike is case insensitive
SELECT * FROM customer 
WHERE first_name ILIKE 'j%' AND last_name ILIKE 's%';

-- people who have the sequence of characters 'er' in their name
-- ilike is case insensitive
SELECT * FROM customer 
WHERE first_name LIKE '%her%';


SELECT * FROM customer 
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B%'
ORDER BY last_name;

-- % - for a long sequence of characters 
-- _ - for a single replacemnt of characters.
SELECT * FROM customer
WHERE first_name LIKE '%_her%';

-- Challenge 
-- how many business transactions where greater than $5
SELECT COUNT(amount) FROM payment
WHERE amount > 5; 

-- 
SELECT COUNT (*) FROM actor
WHERE first_name LIKE 'P%';


-- Challenge 

-- How many payment transactions were > $5.00.
SELECT COUNT(amount) FROM payment
WHERE amount >5;

-- How many actors have a first name that starts with the letter P?
SELECT COUNT(*) FROM actor 
WHERE first_name LIKE 'P%';

--How many unique districts are our customers from?
SELECT COUNT (DISTINCT (district)) FROM address;

-- retrieve a list of names for those distinct districts 
-- from the previous question.
SELECT DISTINCT(district) FROM address;

-- how many films 
-- rating of R and
-- replacement cost between $5 and $15
SELECT COUNT (film) FROM film
WHERE rating = 'R'
AND replacement_cost BETWEEN 5 AND 15;

-- how many films have the word Truman somewhere in the title?
SELECT COUNT (*) FROM film
WHERE title LIKE '%Truman%';


-- GROUP BY & Aggregate.
-- Most common Aggregate functions:
-- AVG() - returns average value
-- COUNT() - returns number of values
-- MAX() - returns maximum value
-- MIN() - returns minmum value
-- SUM() - returns the sum of all values

-- Aggregate function calls happen only in the
-- SELECT clause or the HAVING clause.

SELECT * FROM film;

-- what the minimum replacement cost was
SELECT MIN(replacement_cost) FROM film; 

-- whats the most we can expect to pay to replace a film.
SELECT MAX(replacement_cost) FROM film;

-- max and min 
SELECT MAX(replacement_cost), MIN(replacement_cost) 
FROM film;

-- in order to call other columns we use the GROUP BY statement.

-- average replacement cost
SELECT AVG(replacement_cost)
FROM film;

-- round to 2 decimal places
SELECT ROUND (AVG(replacement_cost), 2)
FROM film;

-- sum of the replacement cost
SELECT SUM(replacement_cost)
FROM film;

-- Basic Group BY call 
SELECT customer_id FROM payment
GROUP BY customer_id;

-- Basic Group BY call 
SELECT customer_id FROM payment
GROUP BY customer_id
ORDER BY customer_id;

-- what customer is spending the most money in total.
-- total sum amount per(,) customer_id
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) ;

-- order by descending
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- count the number of transactions they're having.
SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount) DESC;

-- using GROUP BY on multiple columns.
--SELECT * 

-- total amount spent per staff, per customer.
SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id;

/* Group BY statement is used to group the rows that have the same value.
   Whereas Order BY statement sort the result-set either in ascending or in descending order.*/

-- desc order 
SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY SUM(amount) DESC;

-- how much each customer spent with each staff member.
SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY staff_id;

-- GROUP BY multiple columns.
-- how much each customer spent with each staff member.
SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY staff_id, customer_id;

-- GROUP BY multiple columns.
SELECT DATE(payment_date) FROM payment;

-- how much is being processed each day.
SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
-- highest to lowest
ORDER BY SUM(amount) DESC;

-- Challenge 
-- We have two staff memebers, 
-- staff_id = 1,2
-- bonus to staff member that held the most payments.
-- how many payments of did each staff member handle and who gets the bonus.
SELECT staff_id, 
COUNT(amount) FROM payment
GROUP BY staff_id;

--  Average replacement_cost per rating
SELECT rating, ROUND(AVG(replacement_cost), 2)  
FROM film
GROUP BY rating;

-- customer ids of the top 5 customers based by total spend?
SELECT customer_id, ROUND(SUM(amount), 2)
FROM payment
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;

-- Having comes after GROUP BY
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY SUM(amount) DESC;

-- number of customers per store
SELECT store_id, 
COUNT(*) FROM customer
GROUP BY store_id;

-- stores that had more than 300 customers
SELECT store_id, COUNT(*) FROM customer
GROUP BY store_id
HAVING COUNT(*) > 300;

-- customers with >= 40 payments
SELECT * FROM payment;

SELECT customer_id,  -- customer column
COUNT(*) FROM payment  -- count the payment table
GROUP BY customer_id  -- group by customer_id
HAVING COUNT(*) >= 40;   -- where payment >= 40

-- platinum = amount >= 40
-- what customer_ids are eligible for platinum status.
SELECT customer_id, COUNT(amount)
FROM payment
GROUP BY customer_id
HAVING COUNT(amount) >= 40;

-- what are customer ids of customers who 
-- have sent more than $100 in payment transactions 
-- with our staff_id member 2.
SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100 ;

-- AS -- give the resulting column a new name / alias.
-- renaming the resulting column.
SELECT COUNT(amount) AS num_transactions 
FROM payment;

-- GROUP BY
-- showing how much each customer has spent
SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id;

-- showing how much each customer has spent
-- AS comes after what kind of function call I want to rename.
SELECT customer_id, 
SUM(amount) AS total_spent
FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount) DESC ;

-- Clarify on the sum amount
-- filtering - where 
-- aliases get assigned at the very end and you cannot use them to filter by.
SELECT customer_id, 
SUM(amount) AS total_spent
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) > 100 ;

--
SELECT customer_id, amount
FROM payment
WHERE amount > 2;

-- JOINS 
-- INNER 

-- JOIN the payment table with the customer table in order 
-- to get maybe the customer email associated with a specific payment.
SELECT * FROM payment;
SELECT * FROM customer;


SELECT * FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

-- select certain columns from each table
SELECT payment_id, payment.customer_id, first_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

-- FULL OUTER JOINS.
-- all the payments we have is associated with the current customer.
-- Pivacy Policy: we don't have any payment information, not associated with some
-- customer, and we also, more importantly, don't have 
-- any customers information who has never made a payment.
SELECT * FROM customer
FULL OUTER JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null 
OR payment.payment_id IS null;

-- other way 
SELECT COUNT(DISTINCT customer_id) FROM payment;

-- order is symmetrical  - left outer join 
SELECT * FROM inventory;

-- a film_id(unique identifier for the film), as well as the title.
SELECT film.film_id, title, inventory_id, store_id
FROM film 
LEFT JOIN inventory ON 
inventory.film_id = film.film_id
WHERE inventory.film_id IS null;