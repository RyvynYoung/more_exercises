-- Employees Database
use employees;

-- How much do the current managers of each department get paid, relative to the average salary for the department?
-- Is there any department where the department manager gets paid less than the average salary?

	-- How much do the current managers of each department get paid
	select emp_no, salary, dept_no from salaries 
	where emp_no in (select emp_no from dept_manager where to_date > now())
	and to_date > now();
	-- average salary by dept
	select de.dept_no, avg(s.salary)
	from departments as d
	join dept_emp as de on de.dept_no = d.dept_no and de.to_date > now()
	join salaries as s on s.emp_no = de.emp_no and s.to_date > now()
	group by de.dept_no;
	
	-- show dept, manager name, salary, average dept salary
select dm.dept_no, d.dept_name, concat(e.first_name, ' ', e.last_name) as ManagerName, manager_info.salary, avg_dept_salary.avg_sal, 
(manager_info.salary - avg_dept_salary.avg_sal) as mgr_over_under_avg 
from employees as e
join salaries as s on e.emp_no = s.emp_no and s.to_date > now() 
join dept_manager as dm on e.emp_no = dm.emp_no
join departments as d on dm.dept_no = d.dept_no
join (select emp_no, salary from salaries
	where emp_no in (select emp_no from dept_manager where to_date > now())
	and to_date > now()) as manager_info on e.emp_no = manager_info.emp_no
join(select de.dept_no as dno, avg(s.salary) as avg_sal
	from departments as d
	join dept_emp as de on de.dept_no = d.dept_no and de.to_date > now()
	join salaries as s on s.emp_no = de.emp_no and s.to_date > now()
	group by de.dept_no) as avg_dept_salary on dm.dept_no = avg_dept_salary.dno;

    -- Is there any department where the department manager gets paid less than the average salary?
            -- yes, 2 departments = Production and Customer Service


-- World Database
-- Use the world database for the questions below.
use world;

-- What languages are spoken in Santa Monica?
-- +------------+------------+
-- | Language   | Percentage |
-- +------------+------------+
-- | Portuguese |        0.2 |
-- | Vietnamese |        0.2 |
-- | Japanese   |        0.2 |
-- | Korean     |        0.3 |
-- | Polish     |        0.3 |
-- | Tagalog    |        0.4 |
-- | Chinese    |        0.6 |
-- | Italian    |        0.6 |
-- | French     |        0.7 |
-- | German     |        0.7 |
-- | Spanish    |        7.5 |
-- | English    |       86.2 |
-- +------------+------------+
-- 12 rows in set (0.01 sec)
select Language, Percentage from countrylanguage where countrycode = (select countrycode from city where name = 'Santa Monica');


-- How many different countries are in each region?
-- +---------------------------+---------------+
-- | Region                    | num_countries |
-- +---------------------------+---------------+
-- | Micronesia/Caribbean      |             1 |
-- | British Islands           |             2 |
-- | Baltic Countries          |             3 |
-- | Antarctica                |             5 |
-- | North America             |             5 |
-- | Australia and New Zealand |             5 |
-- | Melanesia                 |             5 |
-- | Southern Africa           |             5 |
-- | Northern Africa           |             7 |
-- | Micronesia                |             7 |
-- | Nordic Countries          |             7 |
-- | Central America           |             8 |
-- | Eastern Asia              |             8 |
-- | Central Africa            |             9 |
-- | Western Europe            |             9 |
-- | Eastern Europe            |            10 |
-- | Polynesia                 |            10 |
-- | Southeast Asia            |            11 |
-- | Southern and Central Asia |            14 |
-- | South America             |            14 |
-- | Southern Europe           |            15 |
-- | Western Africa            |            17 |
-- | Middle East               |            18 |
-- | Eastern Africa            |            20 |
-- | Caribbean                 |            24 |
-- +---------------------------+---------------+
-- 25 rows in set (0.00 sec)
select Region, count(name) as num_countries
from country
group by Region
order by num_countries;



-- What is the population for each region?
-- +---------------------------+------------+
-- | Region                    | population |
-- +---------------------------+------------+
-- | Eastern Asia              | 1507328000 |
-- | Southern and Central Asia | 1490776000 |
-- | Southeast Asia            |  518541000 |
-- | South America             |  345780000 |
-- | North America             |  309632000 |
-- | Eastern Europe            |  307026000 |
-- | Eastern Africa            |  246999000 |
-- | Western Africa            |  221672000 |
-- | Middle East               |  188380700 |
-- | Western Europe            |  183247600 |
-- | Northern Africa           |  173266000 |
-- | Southern Europe           |  144674200 |
-- | Central America           |  135221000 |
-- | Central Africa            |   95652000 |
-- | British Islands           |   63398500 |
-- | Southern Africa           |   46886000 |
-- | Caribbean                 |   38140000 |
-- | Nordic Countries          |   24166400 |
-- | Australia and New Zealand |   22753100 |
-- | Baltic Countries          |    7561900 |
-- | Melanesia                 |    6472000 |
-- | Polynesia                 |     633050 |
-- | Micronesia                |     543000 |
-- | Antarctica                |          0 |
-- | Micronesia/Caribbean      |          0 |
-- +---------------------------+------------+
-- 25 rows in set (0.00 sec)
select Region, sum(Population) as population
from country
group by Region
order by population desc;




-- What is the population for each continent?
-- +---------------+------------+
-- | Continent     | population |
-- +---------------+------------+
-- | Asia          | 3705025700 |
-- | Africa        |  784475000 |
-- | Europe        |  730074600 |
-- | North America |  482993000 |
-- | South America |  345780000 |
-- | Oceania       |   30401150 |
-- | Antarctica    |          0 |
-- +---------------+------------+
-- 7 rows in set (0.00 sec)
select Continent, sum(Population) as population
from country
group by Continent
order by population desc;



-- What is the average life expectancy globally?
-- +---------------------+
-- | avg(LifeExpectancy) |
-- +---------------------+
-- |            66.48604 |
-- +---------------------+
-- 1 row in set (0.00 sec)
select avg(LifeExpectancy)
from country;



-- What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
-- +---------------+-----------------+
-- | Continent     | life_expectancy |
-- +---------------+-----------------+
-- | Antarctica    |            NULL |
-- | Africa        |        52.57193 |
-- | Asia          |        67.44118 |
-- | Oceania       |        69.71500 |
-- | South America |        70.94615 |
-- | North America |        72.99189 |
-- | Europe        |        75.14773 |
-- +---------------+-----------------+
-- 7 rows in set (0.00 sec)
select Continent, avg(LifeExpectancy)
from country
group by Continent
order by avg(LifeExpectancy);


-- +---------------------------+-----------------+
-- | Region                    | life_expectancy |
-- +---------------------------+-----------------+
-- | Antarctica                |            NULL |
-- | Micronesia/Caribbean      |            NULL |
-- | Southern Africa           |        44.82000 |
-- | Central Africa            |        50.31111 |
-- | Eastern Africa            |        50.81053 |
-- | Western Africa            |        52.74118 |
-- | Southern and Central Asia |        61.35000 |
-- | Southeast Asia            |        64.40000 |
-- | Northern Africa           |        65.38571 |
-- | Melanesia                 |        67.14000 |
-- | Micronesia                |        68.08571 |
-- | Baltic Countries          |        69.00000 |
-- | Eastern Europe            |        69.93000 |
-- | Middle East               |        70.56667 |
-- | Polynesia                 |        70.73333 |
-- | South America             |        70.94615 |
-- | Central America           |        71.02500 |
-- | Caribbean                 |        73.05833 |
-- | Eastern Asia              |        75.25000 |
-- | North America             |        75.82000 |
-- | Southern Europe           |        76.52857 |
-- | British Islands           |        77.25000 |
-- | Western Europe            |        78.25556 |
-- | Nordic Countries          |        78.33333 |
-- | Australia and New Zealand |        78.80000 |
-- +---------------------------+-----------------+
-- 25 rows in set (0.00 sec)
select Region, avg(LifeExpectancy)
from country
group by Region
order by avg(LifeExpectancy);


-- Bonus
-- Find all the countries whose local name is different from the official name
select LocalName, Name
from country
where LocalName not like Name;

-- How many countries have a life expectancy less than x?
-- x = Austin, TX
select count(Name)
from country
where LifeExpectancy < (select LifeExpectancy
from country
join city on city.CountryCode = country.Code
where city.Name = 'Austin');

-- What state is city x located in?
select city.Name, city.District as State
from country
join city on city.CountryCode = country.Code
where city.Name = 'Austin';

-- What region of the world is city x located in?
select city.Name, country.Region
from country
join city on city.CountryCode = country.Code
where city.Name = 'Austin';

-- What country (use the human readable name) city x located in?
select city.Name, country.Name
from country
join city on city.CountryCode = country.Code
where city.Name = 'Austin';

-- What is the life expectancy in city x?
select city.Name, LifeExpectancy
from country
join city on city.CountryCode = country.Code
where city.Name = 'Austin';





-- Sakila Database
use sakila; 


-- Display the first and last names in all lowercase of all the actors.
select lower(first_name), lower(last_name)
from actor;

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe."
-- What is one query would you could use to obtain this information?
select actor_id, first_name, last_name
from actor
where first_name like 'Joe';

-- Find all actors whose last name contain the letters "gen":
select first_name, last_name
from actor
where last_name like '%gen%';

-- Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.
select last_name, first_name
from actor
where last_name like '%li%'
order by last_name, first_name;

-- Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:
select country_id, country 
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- List the last names of all the actors, as well as how many actors have that last name.
select last_name, count(last_name) 
from `actor` 
group by last_name;

-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(last_name) count
from actor 
group by last_name
having count > 1
order by count desc;

-- You cannot locate the schema of the address table. Which query would you use to re-create it?
		-- this is the query to find the query that created the table address
	show create table address;

	-- this is a copy of the query used to create the address table
	CREATE TABLE `address` (
  `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` smallint(5) unsigned NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `location` geometry NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  KEY `idx_fk_city_id` (`city_id`),
  SPATIAL KEY `idx_location` (`location`),
  CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8;

-- Use JOIN to display the first and last names, as well as the address, of each staff member.
select first_name, last_name, address 
from staff
join address using(address_id);

-- Use JOIN to display the total amount rung up by each staff member in August of 2005.
select concat(first_name, " ", last_name) staff_member, sum(amount) amount_Aug_2005  
from payment
join staff using(staff_id)
where payment_date like '2005-08%'
group by staff_member;

-- List each film and the number of actors who are listed for that film.
select title, count(actor_id) num_actors
from film
join film_actor using(film_id)
group by title;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
select title, count(inventory_id)
from film
join inventory using(film_id)
where title = 'Hunchback Impossible'
group by title;

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

-- solved without subqueries, need to change!
select title
from film
join language using(language_id)
where title like 'K%' or title like 'Q%' and name = 'English';

-- using subquery
select title
from film
where title like 'K%' or title like 'Q%' and language_id in (select language_id from language where name = 'English');


-- Use subqueries to display all actors who appear in the film Alone Trip.
select concat(first_name, ' ', last_name)
from actor
where actor_id in (select actor_id from film_actor
where film_id in (select film_id from film where title = 'Alone Trip'))
;

-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
select concat(first_name, ' ', last_name), email from customer 
where customer_id in (
select address_id from address where city_id in (select city_id from city where country_id in (select country_id from country where country = 'Canada'))
);

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
select * from film where film_id in (
select film_id from film_category where category_id in (select category_id from category where name = 'family')
);

-- Write a query to display how much business, in dollars, each store brought in.
select store_id, sum(amount) total_sales from payment join store on store.manager_staff_id = payment.staff_id group by store_id;

-- Write a query to display for each store its store ID, city, and country.
select store_id, city, country
from store
join address using(address_id)
join city using(city_id)
join country using(country_id);

-- List the top five genres in gross revenue in descending order.
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select name, sum(amount) 'gross revenue'
from category
join film_category using(category_id)
join inventory using(film_id)
join rental using(inventory_id)
join payment using(rental_id)
group by name;


-- SELECT statements
-- Select all columns from the actor table.
select * from actor;

-- Select only the last_name column from the actor table.
select last_name from actor;

-- Select only the following columns from the film table.
-- DISTINCT operator
-- Select all distinct (different) last names from the actor table.
select distinct last_name from actor;

-- Select all distinct (different) postal codes from the address table.
select distinct postal_code from address;

-- Select all distinct (different) ratings from the film table.
select distinct rating from film;

-- WHERE clause
-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
use sakila;
select title, description, rating, length as movie_length from film 
where length >= 180;

-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
select payment_id, amount, payment_date from payment 
where payment_date >= "2005-05-27";

-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
select payment_id, amount, payment_date from payment
where payment_date like "2005-05-27%";

-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
select * from customer 
where last_name like "S%" and first_name like "%n";

-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
select * from customer 
where active = 0 or last_name like "M%";

-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
select * from category
where category_id > 4 and name like "C%" or name like "S%" or name like "T%";

-- Select all columns minus the password column from the staff table for rows that contain a password.
select staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update from staff 
where password is not null;

-- Select all columns minus the password column from the staff table for rows that do not contain a password.
select staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update from staff
where password is null;

use sakila;
-- IN operator
-- Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
select phone, district from address where district in ('California', 'England', 'Taipei', 'West Java');

-- Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
select payment_id, amount, payment_date from payment where YEAR(payment_date) = 2005 and MONTH(payment_date) = 05 and dayofmonth(payment_date) in (25, 27, 29);

-- Select all columns from the film table for films rated G, PG-13 or NC-17.
select * from film where rating in ('G', 'PG-13', 'NC-17');

-- BETWEEN operator
-- Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
use sakila;
select * from payment where payment_date between '2005-05-25' and '2005-05-26';

-- Select the following columns from the film table for films where the length of the description is between 100 and 120.
-- Hint: total_rental_cost = rental_duration * rental_rate
use sakila;
select rental_duration, rental_rate, (rental_duration * rental_rate) as total_rental_cost from film where length between 100 and 120;

-- LIKE operator
-- Select the following columns from the film table for rows where the description begins with "A Thoughtful".
use sakila;
select * from film where description like 'A Thoughtful%';

-- Select the following columns from the film table for rows where the description ends with the word "Boat".
select * from film where description like '%Boat';

-- Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
select * from film where description like '%Database%' and length > 180;

-- LIMIT Operator
-- Select all columns from the payment table and only include the first 20 rows.
select * from payment limit 20;

-- Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
select payment_date, amount from payment where amount > 5 limit 1000 offset 1000;
-- Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
select * from customer limit 100 offset 100;

-- ORDER BY statement
-- Select all columns from the film table and order rows by the length field in ascending order.
select * from film order by length;

-- Select all distinct ratings from the film table ordered by rating in descending order.
select distinct(rating) from film order by rating desc;

-- Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
select payment_date, amount from payment order by amount desc limit 20;

-- Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
select title, description, special_features, length, rental_duration 
from film 
where special_features like '%Behind the Scenes%' and length < 120 and rental_duration between 5 and 7 
order by length desc;

-- JOINs
-- Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
select customer.first_name, customer.last_name, actor.first_name, actor.last_name
from customer
left join actor on customer.last_name = actor.last_name;

-- Label customer first_name/last_name columns as customer_first_name/customer_last_name
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name, actor.last_name
from customer
left join actor on customer.last_name = actor.last_name;

-- Label actor first_name/last_name columns in a similar fashion.
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as actor_last_name
from customer
left join actor on customer.last_name = actor.last_name;
-- returns correct number of records: 599
-- incorrect, returns 620 rows

-- Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as actor_last_name
from customer
right join actor on customer.last_name = actor.last_name;
-- returns correct number of records: 200
-- correct returns 200 rows

-- Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
select customer.first_name as customer_first_name, customer.last_name as customer_last_name, actor.first_name as actor_first_name, actor.last_name as actor_last_name
from customer
join actor on customer.last_name = actor.last_name;
-- returns correct number of records: 43
-- correct returns 43 rows

-- Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
select city, country 
from city
left join country on city.country_id = country.country_id;
-- Returns correct records: 600
-- correct 600 rows

-- Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
-- Label the language.name column as "language"
select title, description, release_year, language.name as language
from film 
join language on language.language_id = film.language_id;
-- Returns 1000 rows
-- correct returns 1000 rows

-- Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, 
-- performing 2 left joins with the address table then the city table to get the address and city related columns.
select first_name, last_name, address, address2, city, district, postal_code 
from staff 
left join address on address.address_id = staff.address_id
left join city on city.city_id = address.city_id;
-- returns correct number of rows: 2
-- correct 2 rows

-- What is the average replacement cost of a film? Does this change depending on the rating of the film?
select avg(replacement_cost) from film;
-- +-----------------------+
-- | AVG(replacement_cost) |
-- +-----------------------+
-- |             19.984000 |
-- +-----------------------+
-- 1 row in set (2.39 sec)

select rating, avg(replacement_cost) from film group by rating;
-- +--------+-----------------------+
-- | rating | AVG(replacement_cost) |
-- +--------+-----------------------+
-- | G      |             20.124831 |
-- | PG     |             18.959072 |
-- | PG-13  |             20.402556 |
-- | R      |             20.231026 |
-- | NC-17  |             20.137619 |
-- +--------+-----------------------+
-- 5 rows in set (0.09 sec)


-- How many different films of each genre are in the database?
select category.name, count(title) as count 
from category 
join film_category using (category_id) 
join film using (film_id) 
group by category.name;
-- +-------------+-------+
-- | name        | count |
-- +-------------+-------+
-- | Action      |    64 |
-- | Animation   |    66 |
-- | Children    |    60 |
-- | Classics    |    57 |
-- | Comedy      |    58 |
-- | Documentary |    68 |
-- | Drama       |    62 |
-- | Family      |    69 |
-- | Foreign     |    73 |
-- | Games       |    61 |
-- | Horror      |    56 |
-- | Music       |    51 |
-- | New         |    63 |
-- | Sci-Fi      |    61 |
-- | Sports      |    74 |
-- | Travel      |    57 |
-- +-------------+-------+
-- 16 rows in set (0.06 sec)


-- What are the 5 frequently rented films?
select title, count(inventory_id) as total 
from film 
join inventory using (film_id) 
join rental using (inventory_id) 
group by title
order by total desc
limit 5;

-- +---------------------+-------+
-- | title               | total |
-- +---------------------+-------+
-- | BUCKET BROTHERHOOD  |    34 |
-- | ROCKETEER MOTHER    |    33 |
-- | GRIT CLOCKWORK      |    32 |
-- | RIDGEMONT SUBMARINE |    32 |
-- | JUGGLER HARDLY      |    32 |
-- +---------------------+-------+
-- 5 rows in set (0.11 sec)



-- What are the most most profitable films (in terms of gross revenue)?
select title, sum(amount) as total 
from film 
join inventory using (film_id)
join rental using (inventory_id)  
join payment using (rental_id)
group by title
order by total desc
limit 5;
-- +-------------------+--------+
-- | title             | total  |
-- +-------------------+--------+
-- | TELEGRAPH VOYAGE  | 231.73 |
-- | WIFE TURN         | 223.69 |
-- | ZORRO ARK         | 214.69 |
-- | GOODFELLAS SALUTE | 209.69 |
-- | SATURDAY LAMBS    | 204.72 |
-- +-------------------+--------+
-- 5 rows in set (0.17 sec)


-- Who is the best customer?
select concat(last_name, ', ', first_name) as customer, sum(amount) as total 
from customer 
join payment using (customer_id)
group by customer
order by total desc
limit 1;
-- +------------+--------+
-- | name       | total  |
-- +------------+--------+
-- | SEAL, KARL | 221.55 |
-- +------------+--------+
-- 1 row in set (0.12 sec)


-- Who are the most popular actors (that have appeared in the most films)?
select CONCAT(last_name, ", ", first_name) as actor_name, count(film_id) as total
from actor
join film_actor using(actor_id)
group by actor_name
order by total DESC
limit 5;
-- +-----------------+-------+
-- | actor_name      | total |
-- +-----------------+-------+
-- | DEGENERES, GINA |    42 |
-- | TORN, WALTER    |    41 |
-- | KEITEL, MARY    |    40 |
-- | CARREY, MATTHEW |    39 |
-- | KILMER, SANDRA  |    37 |
-- +-----------------+-------+
-- 5 rows in set (0.07 sec)



-- What are the sales for each store for each month in 2005?
SELECT CONCAT(year(payment_date), "-", month(payment_date)) as SaleDate, store_id, sum(amount) 
from payment
join staff using(staff_id)
WHERE payment_date like '2005%'
GROUP BY SaleDate, store_id;
-- +---------+----------+----------+
-- | month   | store_id | sales    |
-- +---------+----------+----------+
-- | 2005-05 |        1 |  2459.25 |
-- | 2005-05 |        2 |  2364.19 |
-- | 2005-06 |        1 |  4734.79 |
-- | 2005-06 |        2 |  4895.10 |
-- | 2005-07 |        1 | 14308.66 |
-- | 2005-07 |        2 | 14060.25 |
-- | 2005-08 |        1 | 11933.99 |
-- | 2005-08 |        2 | 12136.15 |
-- +---------+----------+----------+
-- 8 rows in set (0.14 sec)

/* Temp table method
use darden_1030;
DROP TEMPORARY TABLE IF EXISTS payment_month;

CREATE TEMPORARY TABLE payment_month as
SELECT staff_id, amount, payment_date, store_id
FROM sakila.payment
JOIN sakila.staff USING(staff_id);

ALTER TABLE payment_month ADD SalesMonth TINYINT(3);
ALTER TABLE payment_month ADD SalesYear SMALLINT(5);

UPDATE payment_month
SET SalesMonth = month(payment_date);

UPDATE payment_month
SET SalesYear = year(payment_date);

select *
from payment_month;

select CONCAT(SalesYear, "-", SalesMonth) as SalesDate, store_id, sum(amount)
from payment_month
GROUP BY SalesDate, store_id; */




-- Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.
select title, CONCAT(last_name, ', ', first_name) as customer_name, phone, address, city, country, postal_code
from rental 
join inventory using(inventory_id)
join film using(film_id)
join customer using(customer_id)
join address using(address_id)
join city using(city_id)
join country using(country_id)
where return_date IS NULL; 

-- +------------------------+------------------+--------------+
-- | title                  | customer_name    | phone        |
-- +------------------------+------------------+--------------+
-- | HYDE DOCTOR            | KNIGHT, GAIL     | 904253967161 |
-- | HUNGER ROOF            | MAULDIN, GREGORY | 80303246192  |
-- | FRISCO FORREST         | JENKINS, LOUISE  | 800716535041 |
-- | TITANS JERK            | HOWELL, WILLIE   | 991802825778 |
-- | CONNECTION MICROCOSMOS | DIAZ, EMILY      | 333339908719 |
-- +------------------------+------------------+--------------+
-- 5 rows in set (0.06 sec)
-- 183 rows total, above is just the first 5

