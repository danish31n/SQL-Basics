--Q1. Create a table called employees with the following structure emp_id 
-- (integer, should not be NULL and should be a primary key) 
-- emp_name (text, should not be NULL)
--  age (integer, should have a check constraint to ensure the age is at least 18)
--  email (text, should be unique for each employee) 
--  salary (decimal, with a default value of 30,000). 
--  Write the SQL query to create the above table with all constraints.

CREATE DATABASE IF NOT EXISTS Sql_basics;
USE Sql_basics;

CREATE TABLE employees( Emp_id int primary key,
					   Emp_name varchar(255) not null,
                       Age int check (age >= 18),
                       Email varchar(255) unique,
                       Salary DECIMAL(10, 2) DEFAULT 30000); 


SELECT * from employees;




/*Q2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types
    of constraints.  */

-- ANS-2) Constraints in a database are rules or conditions that are applied to data in order to ensure its accuracy, consistency,
--  and reliability. They help maintain data integrity by restricting the type of data that can be inserted, updated, or deleted, ensuring
--  that the database contains valid, accurate, and consistent information. 

-- Here’s how constraints help maintain data integrity:
--  i) Ensuring valid data: Constraints limit what data can be stored in a column (e.g., numeric values only, no empty values).
-- ii) Avoiding errors: They help avoid data anomalies, such as duplicate entries or entries that don't match other related data.
-- iii) Enforcing business rules: Constraints can enforce certain rules related to business logic, ensuring that only valid operations
--      are performed on the data.




-- Q3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer

--ANS-3) The **NOT NULL** constraint is applied to a column to ensure that it always has a value and cannot be left empty. It’s useful 
--       when a field must always contain data, such as a person's name or an email address.

-- A **primary key** cannot contain **NULL** values. This is because a primary key uniquely identifies each record in a table, 
-- and NULL means "no value," which would make it impossible to identify a record. Therefore, for a primary key to work, every value 
-- must be unique and non-null.


-- Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and
--  removing a constraint.

--ANS-4)   i.) Example of Adding a Primary Key Constraint
--         This will add a primary key constraint to the 'employee_id' column in the 'employees' table
--         ALTER TABLE employees
--         ADD CONSTRAINT pk_employee_id PRIMARY KEY (employee_id);

-- ii.) Example of Adding a NOT NULL Constraint
--      This will make the 'email' column in the 'employees' table NOT NULL, meaning it cannot accept NULL values
--                 ALTER TABLE employees
--                 MODIFY email VARCHAR(100) NOT NULL;

-- iii.) Example of Removing a Primary Key Constraint
-- This will remove the primary key constraint named 'pk_employee_id' from the 'employees' table
--                  ALTER TABLE employees
--                  DROP CONSTRAINT pk_employee_id;

-- iv.) Example of Removing a NOT NULL Constraint
-- This will remove the NOT NULL constraint on the 'email' column, allowing NULL values in the 'email' column
--                  ALTER TABLE employees
--                  MODIFY email VARCHAR(100) NULL;




/* Q5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example
    of an error message that might occur when violating a constraint. */

/* ANS-5)  When attempting to insert, update, or delete data in a way that violates constraints, the database will reject the operation
and generate an error message. Constraints are designed to ensure the integrity, consistency, and accuracy of data within the database.

Consequences include:
1. **Insertion Errors**: If you try to insert data that violates a constraint (like a NOT NULL or PRIMARY KEY), the insertion will fail.
2. **Update Errors**: Attempting to update a record that violates a constraint (like changing a primary key value to a duplicate) will also fail.
3. **Deletion Errors**: Trying to delete a record that is referenced by a foreign key constraint will result in an error to prevent orphaned records.

### Example of an error message when violating constraints:

1. **Violation of NOT NULL Constraint**:
   - Trying to insert a NULL value into a column that has a `NOT NULL` constraint will result in an error.
   ```sql
   INSERT INTO employees (employee_id, name, email)
   VALUES (101, 'John Doe', NULL); ## Error: Column 'email' cannot be null */



/* Q6. You created a products table without constraints as follows: 
CREATE TABLE products ( product_id INT, product_name VARCHAR(50),
 price DECIMAL(10, 2));
 Now, you realise that The product_id should be a primary key The price should have a default 
 value of 50.00 */


 CREATE TABLE IF NOT EXISTS products ( product_id INT,
                                       product_name VARCHAR(50),
                                       price DECIMAL (10,2));

ALTER table products ADD CONSTRAINT PRIMARY KEY (product_id);

ALTER table products MODIFY  column  price DECIMAL (10,2) DEFAULT 50.00;                                    

SELECT*from products;




/* Q7. You have two tables: Students and Classes
Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
*/

CREATE TABLE IF NOT EXISTS Students (student_id int,
                                     student_name VARCHAR(255),
                                     class_id INT);

INSERT INTO  Students VALUES(1,'Alice',101),
                                 (2,'Bob',102),
                                 (3,'Charlie',101);
SELECT* from students;

CREATE TABLE IF NOT EXISTS Classes (class_id int,
                                    class_name VARCHAR(255));         


INSERT INTO  Classes VALUES (101,'Math'),
                                 (102,'Science'),
                                 (103,'History');

SELECT*from Classes;


SELECT Students.student_name, Classes.class_name FROM
students
INNER JOIN classes
ON
Students.class_id = Classes.class_id;



/* Q8. Consider the following three tables:  orders, customers, products.COMMENT
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with 
an order Hint: (use INNER JOIN and LEFT JOIN) */


CREATE TABLE IF NOT EXISTS Orders (order_id int,
                                   order_date date,
                                   customer_id int);

INSERT INTO Orders values (1,Date('2024-01-01'),101),
                          (2,Date('2024-01-03'),102);



SELECT*FROM orders;


CREATE TABLE IF NOT EXISTS Customers (customer_id INT,
                                    customer_name VARCHAR(255));

INSERT INTO Customers VALUES (101,'Alice'),
                             (102,'Bob');

SELECT*FROM Customer;


CREATE TABLE IF NOT EXISTS Products (product_id int,
                                     product_name VARCHAR(255),
                                     order_id int);

INSERT INTO Products VALUES (1,'Laptop',1),
                            (2,'Phone',NULL);
SELECT*from products;









/* Q9. Given the following tables: Sales, Products.COMMENT
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function. */

 CREATE TABLE IF NOT EXISTS Sales (sale_id int,
                                  product_id int,
                                  amount int);

INSERT INTO Sales VALUES (1,101,500),
                         (2,102,300),
                         (3,101,700);

SELECT*FROM Sales;


CREATE TABLE IF NOT EXISTS Products1 (product_id int,
                                      product_name VARCHAR(255));

INSERT INTO Products1 VALUES (101,'Laptop'),
                             (102,'Phone');

SELECT*from Products1;

SELECT Products1.product_name,sum(Sales.amount) as Total_sales_amount from 
Sales 
INNER JOIN Products1
ON
Sales.product_id = Products1.product_id
GROUP BY Products1.product_name;


/* Q10. You are given three tables: Orders, Customers, Order_Details.COMMENT
Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer 
using an INNER JOIN between all three tables */


CREATE TABLE IF NOT EXISTS Orders1 (order_id int,
                                   order_date Date,
                                   customer_id int);
INSERT INTO Orders1 VALUES (1,'2024-01-02',1),
                            (2,'2024-01-05',2);
SELECT*from Orders1;

CREATE TABLE IF NOT EXISTS Customers1 (customer_id int,
                                       customer_name VARCHAR(255));
INSERT INTO Customers1 VALUES (1,'Alice'),
                            (2,'Bob');
SELECT*from Customers1;

CREATE TABLE IF NOT EXISTS Order_Details (order_id int,
                                   product_id int,
                                   quantity int);

INSERT INTO Order_Details VALUES (1,101,2),
                            (1,102,1),
                            (2,101,3);

SELECT*from Order_Details;


SELECT Orders1.order_id, Customers1.customer_name , sum(Order_Details.quantity) AS total_quantity FROM
Orders1
INNER JOIN Customers1
ON
Orders1.customer_id = Customers1.customer_id
INNER JOIN Order_Details
ON
Orders1.order_id = Order_Details.order_id
GROUP BY Orders1.order_id, Customers1.customer_name
ORDER BY total_quantity DESC;




                                    /*          SQL Commands             */


/*Q1. Identify the primary keys and foreign keys in maven movies db. Discuss the differences*/

USE mavenmovies;

/* ANS-1) 
   ✅ PRIMARY KEYS (PK): 
   - A Primary Key uniquely identifies each record in a table.
   - It must be UNIQUE and CANNOT be NULL.
*/

-- Primary Keys in MavenMovies Database
SELECT TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    CONSTRAINT_NAME = 'PRIMARY' AND TABLE_SCHEMA = 'mavenmovies';

/*
   ✅ FOREIGN KEYS (FK): 
   - A Foreign Key establishes a relationship between tables.
   - It references the Primary Key of another table to maintain data integrity.
*/

-- Foreign Keys in MavenMovies Database
SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_NAME IS NOT NULL
    AND TABLE_SCHEMA = 'mavenmovies';



/*
   ✅ DIFFERENCE BETWEEN PRIMARY KEY AND FOREIGN KEY:

   PRIMARY KEY:
   - Ensures each row is uniquely identified.
   - Cannot have NULL values.
   - Example: `customer_id` in `customer` table.

   FOREIGN KEY:
   - Creates relationships between tables.
   - Can have duplicate values or NULL (if optional).
   - Example: `customer_id` in `rental` table references `customer_id` in `customer`.
*/


/*Q2.  List all details of actor */

use mavenmovies;
select * from actor;


/*Q3 List all customer information from DB*/

select * from customer;


/*Q4 List different countries*/

select * from country;

/*Q5. -Display all active customers*/

select * from customer
where active = 1;

/*Q6. List of all rental IDs for customer with ID 1.*/

select rental_id, customer_id from rental
where customer_id = 1;

/*Q7. Display all the films whose rental duration is greater than 5 */

select Title, rental_duration from film
where rental_duration > 5;


/*Q8. List the total number of films whose replacement cost is greater than $15 and less than $20. */

select count(*) as Total_film from film
where replacement_cost > 15 and replacement_cost < 20;


/*Q9. Display the count of unique first names of actors. */

select count(distinct first_name) as unique_first_names from actor;


/** 
 * 10 - Display the first 10 records from the customer table.  */

select * from customer
limit 10;



/** 
 * 11 - Display the first 3 records from the customer table whose first name starts with ‘b’. */

select * from customer
where first_name like 'b%'
limit 3;


/** 
 * 12 - Display the names of the first 5 movies which are rated as ‘G’. */

select Title, Rating from film
where rating = 'G'
limit 5;


/** 
 * 13 - Find all customers whose first name starts with "a". */

select Customer_id ,First_Name, Email from customer
where first_name like 'a%'; 


/** 
 * 14 - Find all customers whose first name ends with "a". */

select Customer_id ,First_Name, Email from customer
where first_name like '%a';


/** 
 * 15 - Display the list of first 4 cities which start and end with ‘a’. */

select * from city
where city like 'a%a'
limit 4;



/** 
 * 16 - Find all customers whose first name have "NI" in any position. */

select first_name , email from customer
where first_name like '%NI%';


/** 
 * 17 - Find all customers whose first name have "r" in the second position. */

select first_name , email from customer
where first_name like '_r%';


/** 
 * 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length. */

select customer_id,first_name,email from customer
where first_name like 'a____%'; 


/** 
 * 19 - Find all customers whose first name starts with "a" and ends with "o". */

select customer_id , first_name , email from customer
where first_name like 'a%o';


/** 
 * 20 - Get the films with pg and pg-13 rating using IN operator. */

select title, rating from film
where rating in ('pg','pg-13');


/** 
 * 21 - Get the films with length between 50 to 100 using between operator. */

select title, length from film
where length between 50 and 100;


/** 
 * 22 - Get the top 50 actors using limit operator. */

select * from actor
limit 50;


/** 
 * 23 - Get the distinct film ids from inventory table. */

select distinct film_id as distinct_film_id from inventory;



                                                    /* FUNCTIONS */


/** 
 * Question 1: Retrieve the total number of rentals made in the Sakila database. 
 * Hint: Use the COUNT() function.
 */

use sakila;
select count(*) as total_rentals from rental;


/** 
 * Question 2: Find the average rental duration (in days) of movies rented from the Sakila database. 
 * Hint: Utilize the AVG() function.
 */
use sakila;
select avg(rental_duration) as avg_rental_duration from film;



/** 
 * String Functions:
 * Question 3: Display the first name and last name of customers in uppercase. 
 * Hint: Use the UPPER() function.
 */
use mavenmovies;
select upper(first_name) as upper_firstname , upper(last_name) as upper_lastname from customer;



/** 
 * Question 4: Extract the month from the rental date and display it alongside the rental ID. 
 * Hint: Employ the MONTH() function.
 */
use mavenmovies;
select rental_date,rental_id , month(rental_date) as Month
 from rental;


/** 
 * GROUP BY:
 * Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 
 * Hint: Use COUNT() in conjunction with GROUP BY.
 */

select customer_id ,count(rental_id) as rental_count from rental
group by customer_id;



/** 
 * Question 6: Find the total revenue generated by each store. 
 * Hint: Combine SUM() and GROUP BY.
 */

select staff_id as store,sum(amount) as total_revenue 
from payment 
group by store;


/** 
 * Question 7: Determine the total number of rentals for each category of movies. 
 * Hint: JOIN film_category, film, and rental tables, then use COUNT() and GROUP BY.
 */
use mavenmovies;

select c.name as cate, count(rental_id) as Total_rental  from
film f
inner join category c
on 
f.film_id = fc.film_id
inner join rental r
on
r.last_update = fc.last_update
group by cate;




/** 
 * Question 8: Find the average rental rate of movies in each language. 
 * Hint: JOIN film and language tables, then use AVG() and GROUP BY.
 */

use mavenmovies;

-- Update the `language_id` in the `film` table to distribute films across available languages
UPDATE film 
SET language_id = (
    -- Use the modulo operator to cycle through available language IDs
    (film_id % (SELECT COUNT(*) FROM language)) + 1
);

select l.name ,avg(rental_rate) as avg_rental_rate from film as f
inner join language as l
on f.language_id = l.language_id
group by l.name;


                                           /* JOINS */

/** 
 * Question 9 - Display the title of the movie, customer’s first name, and last name who rented it. 
 * Hint: Use JOIN between the film, inventory, rental, and customer tables.
 */
 
use mavenmovies;

select title, first_name,  last_name  from film f
inner join inventory as i
on f.film_id = i.film_id
inner join rental as r
on i.inventory_id = r.inventory_id
inner join customer as c
on r.customer_id = c.customer_id;


/** 
 * Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind." 
 * Hint: Use JOIN between the film actor, film, and actor tables.
 */
use mavenmovies;

select a.first_name, a.last_name, f.title from film as f
inner join film_actor as fa on f.film_id = fa.film_id
inner join actor as a on fa.actor_id = a.actor_id
where f.title like 'Gone with the Wind';


/*
*  Question 11: Retrieve the customer names along with the total amount they've spent on rentals.
 Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
 */

use mavenmovies;

select concat(first_name,' ',last_name) as customer_name, sum(amount) as total_amount from customer as c
inner join payment as p on c.customer_id = p.customer_id
inner join rental as r on p.rental_id = r.rental_id
group by customer_name
order by sum(amount) desc;


/** 
 * Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London'). 
 * Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
 */
use mavenmovies;

select Title, concat(first_name,' ',last_name) as customer_name,city 
from customer as c
inner join address as a on c.address_id = a.address_id
inner join city as ci on a.city_id = ci.city_id
inner join rental as r on c.customer_id = r.customer_id
inner join inventory as i on r.inventory_id = i.inventory_id
inner join film as f on i.film_id = f.film_id
group by city, customer_name, title;



											    /* Advanced Joins and GROUP BY */

/** 
 * Question 13: Display the top 5 rented movies along with the number of times they've been rented. 
 * Hint: JOIN film, inventory, and rental tables, then use COUNT() and GROUP BY, and limit the results.
 */
 use mavenmovies;
 
select f.title,count(r.rental_id) as rental_count
from film as f
inner join inventory as i on f.film_id = i.film_id
inner join rental as r on i.inventory_id = r.inventory_id
group by f.title
limit 5;
 


/** 
 * Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 
 * Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
 */
use mavenmovies;

select concat(first_name,' ',last_name) as customer_name, c.customer_id from rental as r
inner join inventory as i on r.inventory_id = i.inventory_id
inner join customer as c on r.customer_id = c.customer_id
where i.store_id in (1,2)
group by c.customer_id, c.first_name
having count(distinct i.store_id) = 2;



                                                  /* Windows Function */

/* 1. Rank the customers based on the total amount they've spent on rentals. */

use mavenmovies;
SELECT  rank() OVER (ORDER BY sum(amount) desc) as rank_amount, customer_id FROM payment
group by customer_id;


/* 2. Calculate the cumulative revenue generated by each film over time. */

use mavenmovies;

SELECT f.title, p.payment_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY f.title, p.payment_date;

/* 3. Determine the average rental duration for each film, considering films with similar lengths. */

use mavenmovies;

SELECT 
    title,
    length,
    rental_duration,
    CASE 
        WHEN length <= 60 THEN '0-60 mins'
        WHEN length <= 90 THEN '61-90 mins'
        WHEN length <= 120 THEN '91-120 mins'
        ELSE 'Over 120 mins'
    END AS length_category,
    AVG(rental_duration) OVER (PARTITION BY 
        CASE 
            WHEN length <= 60 THEN '0-60 mins'
            WHEN length <= 90 THEN '61-90 mins'
            WHEN length <= 120 THEN '91-120 mins'
            ELSE 'Over 120 mins'
        END
    ) AS avg_rental_duration_for_category
FROM 
    film
ORDER BY 
    length, title;

/* 4. Identify the top 3 films in each category based on their rental counts. */

use mavenmovies;

SELECT 
    c.name AS category_name,
    f.title,
    COUNT(r.rental_id) AS rental_count,
    ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS film_rank
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name, f.title
ORDER BY 
    c.name, film_rank;




/* 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers. */

USE mavenmovies;

select c.first_name ,c.customer_id,COUNT(r.rental_id) AS rental_count ,count(r.rental_id) - avg(count(r.rental_id)) over() as diff_rental_counts from rental as r
inner join customer as c on r.customer_id = c.customer_id
group by c.customer_id, c.first_name;



/* 6. Find the monthly revenue trend for the entire rental store over time. */

USE mavenmovies;
select month(payment_date) as month_, year(payment_date) as Year_ ,
sum(amount) over(partition by month(payment_date) , year(payment_date) order by year(payment_date), month(payment_date)) as revenue
 from payment;


/* 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers. */
USE mavenmovies;

WITH customerSpending AS (
    SELECT 
        p.customer_id, 
        SUM(p.amount) AS Total_spend, 
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        NTILE(5) OVER (ORDER BY SUM(p.amount) DESC) AS spending_per
    FROM payment p
    JOIN customer c ON p.customer_id = c.customer_id
    GROUP BY p.customer_id, c.first_name, c.last_name)
SELECT 
    customer_id,
    Total_spend,
    customer_name
FROM customerSpending
WHERE spending_per = 1;



/* 8. Calculate the running total of rentals per category, ordered by rental count. */

use mavenmovies;
SELECT c.name AS category_name, f.title, COUNT(r.rental_id) AS rental_count,
SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rental_category
FROM 
    rental r
JOIN 
inventory i ON r.inventory_id = i.inventory_id
JOIN 
film f ON i.film_id = f.film_id
JOIN 
film_category fc ON f.film_id = fc.film_id  
JOIN 
category c ON fc.category_id = c.category_id 
GROUP BY c.name, f.title
ORDER BY rental_count DESC;



/* 9. Find the films that have been rented less than the average rental count for their respective categories. */

use mavenmovies;

WITH RentalCounts AS (SELECT  f.title, c.name AS category_name, COUNT(r.rental_id) AS rental_count, 
AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name) AS avg_rental_count
FROM 
rental r
JOIN 
inventory i ON r.inventory_id = i.inventory_id
JOIN 
film f ON i.film_id = f.film_id
JOIN 
film_category fc ON f.film_id = fc.film_id
JOIN 
category c ON fc.category_id = c.category_id
GROUP BY f.title, c.name
)
SELECT 
    category_name, 
    rental_count, 
    avg_rental_count
FROM 
    RentalCounts
WHERE 
    rental_count < avg_rental_count
ORDER BY 
    rental_count ASC;


/* 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month. */

use mavenmovies;
SELECT 
    month_,
    revenue
FROM (
    SELECT 
        MONTH(payment_date) AS month_,
        SUM(amount) AS revenue,
        DENSE_RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
    FROM payment
    GROUP BY MONTH(payment_date)
) AS ranked_months
WHERE revenue_rank <= 5
ORDER BY revenue DESC;



                                             /* Normalisation & CTE */


/*Q1. First Normal Form (1NF): a. Identify a table in the Sakila database that violates 1NF. Explain how you 
would normalize it to achieve 1NF.*/

/** ANS.1)
 * First Normal Form (1NF) requires that:
 * - All columns contain atomic (indivisible) values.
 * - Each record in the table must be unique.
 * - Each column must contain values of a single type.
 * 
 * A violation of 1NF occurs when a column contains multiple values (non-atomic values) 
 * or when rows are not uniquely identifiable.
 
 * While most tables in Sakila comply with 1NF, a hypothetical violation could occur if the `film` table 
 * had a column like `actors` storing comma-separated actor names (e.g., "John Doe, Jane Smith"). 
 * This would violate 1NF because the column contains non-atomic values.
 
 * Steps to Normalize to 1NF:
 * 1. Remove the non-atomic `actors` column from the `film` table.
 * 2. Use the existing `film_actor` junction table (which links `film_id` and `actor_id`) to represent 
 *    the many-to-many relationship between films and actors, ensuring each value is atomic.
 **/



/*Q2. Second Normal Form (2NF): a. Choose a table in Sakila and describe how you would determine whether it is in 2NF.             
If it violates 2NF, explain the steps to normalize it.
*/


/*ANS.2)
Second Normal Form (2NF) requires:
1. The table must be in 1NF (all attributes contain atomic values)
2. There must be no partial dependencies (non-key attributes must depend on the ENTIRE primary key)
*/


/*
Table structure:
- Primary Key: rental_id (single-column)
- Non-key attributes: rental_date, inventory_id, customer_id, return_date, staff_id, last_update


-- Checking for 2NF compliance:
1. The table is in 1NF (all values are atomic)
2. Since the primary key is a single column (rental_id), partial dependencies cannot exist
   - Partial dependencies only occur with composite primary keys
   - All non-key attributes depend entirely on rental_id


-- Conclusion:

The rental table is already in 2NF because:
- It satisfies 1NF
- With a single-column primary key, partial dependencies are impossible
- All non-key attributes depend on the full primary key


-- Hypothetical 2NF violation example:

If the rental table had:
- Composite primary key: (inventory_id, customer_id)
- Non-key attribute: film_title (which depends only on inventory_id)

This would violate 2NF because film_title depends on only part of the composite key.


-- Normalization steps for hypothetical violation:
1. Remove the partially dependent attribute (film_title) from rental table
2. Move it to the inventory table where inventory_id is the primary key
3. Maintain the original rental table with only fully dependent attributes
*/



/*Q3. Third Normal Form (3NF): a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies  
present and outline the steps to normalize the table to 3NF.
*/


/*ANS.3)
Third Normal Form (3NF) requires:
1. The table must be in 2NF (which implies it's already in 1NF)
2. There must be no transitive dependencies:
   - A transitive dependency occurs when a non-key attribute depends on another non-key attribute
   - All non-key attributes must depend ONLY on the primary key



-- Checking for transitive dependencies:

In the current Sakila schema, the customer table DOES NOT violate 3NF because:
- All attributes directly depend on customer_id
- store_id is a foreign key, and store-specific information is properly separated in the store table
- address_id is a foreign key, with address details properly stored in the address table


-- Hypothetical 3NF violation example:

If the customer table included store_name (which depends on store_id, not directly on customer_id),
this would create a transitive dependency:
customer_id → store_id → store_name
This would violate 3NF because store_name depends on store_id (a non-key attribute in this context)
rather than directly on customer_id (the primary key)


-- Normalization steps for hypothetical violation:

1. Remove store_name from the customer table
2. Keep the existing store table structure where:
   - store_id is the primary key
   - store_name and other store attributes are properly stored
3. Maintain the relationship through the foreign key (store_id) in customer table
*/



/* 4. Normalization Process: a. Take a specific table in Sakila and guide through the process of normalizing it from the initial         
unnormalized form up to at least 2NF.
*/

/*ANS.4) 
Normalization is the process of organizing data in a database to minimize redundancy and improve data integrity. There are different
stages of normalization, including 1NF (First Normal Form), 2NF (Second Normal Form), and 3NF (Third Normal Form). 
In this exercise, we will go through the process of normalizing a specific table from the unnormalized form (UNF) to at least 2NF.
We'll use the rental table from the Sakila database for this example.

/*
STEP 1: Initial Unnormalized Form (UNF)

Hypothetical UNF rental table structure:
- rental_id
- customer_data (composite: {customer_id, name, email, address})
- rental_items (repeating: [{inventory_id, film_title, rental_date}])
- staff_data (composite: {staff_id, name, email})

Issues:
1. Redundancy: Customer/staff details repeat for each rental
2. Non-atomic: customer_data and rental_items contain multiple values
3. Update anomalies: Changing customer email requires multiple updates

/*
STEP 2: Convert to 1NF

Requirements met:
- All columns made atomic (no composite/repeating groups)
- Each rental item gets its own row

1NF Structure:
- rental_id
- customer_id
- customer_name
- customer_email
- inventory_id
- film_title
- rental_date
- staff_id
- staff_name

Remaining issues:
- customer_name/email depend only on customer_id (not full PK)
- staff_name depends only on staff_id
- film_title depends only on inventory_id


STEP 3: Convert to 2NF

Requirements:
- Must be in 1NF
- No partial dependencies (non-key attributes must depend on ENTIRE PK)

Solution: Split into multiple tables:

1. customers (customer_id PK, name, email)
2. staff (staff_id PK, name, email)
3. inventory (inventory_id PK, film_id FK)
4. films (film_id PK, title)
5. rentals (rental_id PK, customer_id FK, staff_id FK, inventory_id FK, rental_date)

*/



/*Q5 CTE Basics: 
a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they    
have acted in from the actor and film_actor tables.
*/

use mavenmovies;

with distinct_list as( select concat( first_name,' ',last_name) as full_name , count(distinct fa.film_id) as count_
FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY full_name
)
SELECT full_name, count_
FROM distinct_list
ORDER BY count_ DESC;



/*Q6. CTE with Joins:
a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.*/

use mavenmovies;

with combine_info as (select f.title, l.Name, f.rental_rate
from film as f
join language as l on f.language_id = l.language_id
)
select Title, Name, Rental_rate
from combine_info;



/*Q7 CTE for Aggregation:
a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
from the customer and payment tables
*/


/*Q7 CTE for Aggregation:
a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
from the customer and payment tables
*/

use mavenmovies;

with total_revenue as (select CONCAT(c.first_name, ' ', c.last_name) AS cus_name ,c.customer_id ,sum(p.amount) as total_amount
from payment as p
join customer as c on p.customer_id = c.customer_id
group by c.customer_id, c.first_name,c.last_name
)
select customer_id, cus_name ,total_amount from total_revenue



/*Q8 CTE with Window Functions:
a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
*/

use mavenmovies;
with rank_cte as (select title, rental_duration, rank() over (order by rental_duration) as duration_rank from film
)
select title, rental_duration, duration_rank from rank_cte;



/*Q9. CTE and Filtering:
a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve 
additional customer details.
*/

use mavenmovies;
with cus_list as (select customer_id , count(rental_id) as count_ from rental
group by customer_id)
select concat(first_name,' ',last_name) as cus_name, c.email from customer as c
join cus_list as cl on c.customer_id = cl.customer_id
where cl.count_ > 2;




/*Q10. CTE for Date Calculations: 
a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table
*/

use mavenmovies;

with monthwise_rental as (select month(rental_date) as month_, 
                       count(rental_id) as rental_count
			           from rental
                       group by month(rental_date)
)
select * from monthwise_rental;




/*Q11. CTE and Self-Join: 
a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
*/

use mavenmovies;

with actor_pair as (select fa1.actor_id as actor_id1, 
                             fa2.actor_id as actor_id2, 
							fa1.film_id
                            from film_actor as fa1
						join film_actor as fa2 on fa1.film_id = fa2.film_id
                        WHERE fa1.actor_id < fa2.actor_id -- Ensuring each pair appears only once
                        )
select actor_id1, actor_id2
from actor_pair;



/*Q12.CTE for Recursive Search: 
a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,
considering the reports_to column
 */

drop table if exists employee;
CREATE TABLE employee (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    reports_to INT NULL
);

INSERT INTO employee (staff_id, first_name, last_name, reports_to) VALUES
(1, 'Alice', 'Smith', NULL), 
(2, 'Bob', 'Johnson', 1),
(3, 'Charlie', 'Brown', 1),
(4, 'David', 'Lee', 2),
(5, 'Eve', 'White', 2),
(6, 'Frank', 'Taylor', 3);

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to AS manager_id
    FROM employee
    WHERE reports_to IS NULL
    UNION ALL
    SELECT e.staff_id, e.first_name, e.last_name, eh.manager_id
    FROM employee e
    JOIN EmployeeHierarchy eh ON e.reports_to = eh.staff_id
)
SELECT * FROM EmployeeHierarchy;

















