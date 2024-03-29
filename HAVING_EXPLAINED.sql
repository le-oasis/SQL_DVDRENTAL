-- Hello World --
-- Welcome to the Oasis --
-- In this lecture, we're going to discuss the having clause. --
---------------------------------------------------------------------------
-- HAVING --
-- The having clause allows us to filter after an aggregation has already taken place.
-- So it comes after a group buy call.
-- Let's take a look back at one of our previous examples.
-- Let's imagine this very simple query where we're selecting some sort of company column and then taking
-- the sum of the sales column from some financial table where we group by company.
-- So we're aggregating sales per company.
-- SELECT company, SUM(sales)
-- FROM finance_table
-- GROUP BY company;
---------------------------------------------------------------------------
-- Now we've already seen we can filter before executing the GROUP BY with a WHERE statement.
-- For example, here I could put a WHERE right before my GROUP BY and say WHERE company not equal to Google
-- because maybe I don't want to include Google in my final results.
--------------------------------------------------------------------------------------------------------------------------
-- SELECT company, SUM(sales)
-- FROM finance_table
-- WHERE company != 'Google'
-- GROUP BY company;
--------------------------------------------------------------------------------------------------------------------------
-- So that's okay because the company isn't being aggregated in any sort of way.
-- It is in the GROUP BY statement.
-- However, it's not having an aggregate function being called on it so I can use WHERE.
--------------------------------------------------------------------------------------------------------------------------
-- But what if we actually want it to filter based off the SUM sales?
-- So keep in mind that since we're calling SUM on sales, that's not going to happen until after that
-- GROUP BY statement is executed all the way at the bottom, which means we cannot use where to filter
-- based off aggregate results because those happen after the actual WHERE statement is executed.
-- So if after performing the GROUP BY and calculating the sum of sales per company, I want it to then
-- perform an additional filter on that result based off the sum of sales.
-- I could add the having clause, so having allows us to use the
-- aggregate result as a filter along with a group buy.
--------------------------------------------------------------------------------------------------------------------------
-- SELECT company, SUM(sales)
-- FROM finance_table
-- WHERE company != 'Google'
-- GROUP BY company
-- HAVING SUM(sales) > 1000;
--------------------------------------------------------------------------------------------------------------------------
-- So you can essentially think of this as a WHERE statement, but only for something that is being aggregated
-- through the GROUP BY .
-- And hopefully you can see that connection quite clearly here.
-- So again, here, I'm able to now filter based off the aggregate result of SUM of sales in my having
-- clause.
-- So here I'm saying do the filter of the where and then after you GROUP BY, go ahead and do another
-- filtering where we're HAVING the SUM of sales greater than some number like 1000.
-- So you would end up with a query that looks something like this.
-- All right.
-- Let's explore some examples of having in our own database.
--------------------------------------------------------------------------------------------------------------------------
-- Hint: Neo
-- -- So we're aggregating sales per company.
-- Aggregating here means SUM(sales) per company
-- so we're SELECT company, SUM(sales)
-- FROM ___
-- GROUP BY company (that's the per!)
--------------------------------------------------------------------------------------------------------------------------

-- Having comes after GROUP BY
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100
ORDER BY SUM(amount) DESC;


-- customers with >= 40 payments
SELECT * FROM payment;

SELECT customer_id,  -- customer column
COUNT(*) FROM payment  -- count the payment table
GROUP BY customer_id  -- group by customer_id
HAVING COUNT(*) >= 40;   -- where payment >= 40
