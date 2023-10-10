use sakila;

-- Task 1: Display the full names of actors available in database
select concat(first_name,' ',last_name) as full_name from actor; 

-- Task 2.a: Display the number of times each first names appears in the database
select first_name,count(*) from actor group by first_name;

-- Task 2.b: What is the count of actors that have unique first names in db? display the first name of all these actor.
select first_name,count(*) as count from actor group by first_name order by count asc;

select first_name,count(*) as count from actor group by first_name having count=1;

-- Task 3.a: Display the number of times each last name appears in the db
select last_name,count(*) as count from actor group by last_name;

-- Task 3.b: Display all unique last names in the db
select last_name,count(*) as count from actor group by last_name order by count asc;

select last_name,count(*) as count from actor group by last_name having count=1;

-- Task 4.a:Display the list of records from movies with the rating "R"
select * from film where rating='R';

-- Task 4.b:Display the list of records from movies that are not rating "R"
select * from film where rating<>'R';

-- Task 4.c:Display the list of records for the movies that are suitable for audience below 13 years of age.
select * from film where rating in('G','PG');

-- Task 5.a:Display the list of records for the movies where the replacement cost is up to $11.
select * from film where replacement_cost>11;

-- Task 5.b:Display the list of records for the movies where the replacement cost is between $11 and $20
select * from film where replacement_cost between 11 and 20;

-- Task 5.c:Display the list of records for the movies in descending order of their replacement costs.
select * from film order by replacement_cost desc;

-- Task 6: Display the names of the top 3 movies with the gratest number of actors.
select f.title,count(aa.actor_id) as actor_count from film f join film_actor a on f.film_id=a.film_id 
											  join actor aa on aa.actor_id=a.actor_id 
                                              group by f.title order by actor_count desc limit 3;
							
-- Task 7: Display the titles of the the movies atarting with letter 'K' and 'Q'
select title from film where title like 'k%' or 'Q%';

-- Task 8: The film 'Agent Truman' has been a great success. display the names of all actors who appeared in this film.
select * from film;
select * from film_actor where film_id=6;
select * from actor where actor_id in(21,23,62,108,137,169,197);

select a.actor_id,a.first_name,a.last_name from film f join film_actor fa on f.film_id=fa.film_id join actor a on a.actor_id=fa.actor_id
																where f.title='agent truman';
                                                                
-- Task 9: identify and display the names of the movies in the family category
select * from film;
select * from film_category;
select * from category;

select f.title,c.name from film f join film_category fc on f.film_id=fc.film_id join category c on fc.category_id=c.category_id
									where c.name='Family';

-- Task 10.a: Display the maximum,minimum and average rental rates of movies based on their rating. the output must be sorted in descending order of the average rental rates.
select rating,max(rental_rate) as maximum, min(rental_rate) as minimum, avg(rental_rate) as average from film group by rating order by average desc;

-- Task 10.b:display the names of the most frequently rented movies in descending order, so that the management can maintain more copies of such movies.
select * from film;
select * from inventory;

select f.title,count(i.inventory_id) as most_frequently_rented_movie from film f join inventory i on f.film_id=i.film_id
															group by f.title order by most_frequently_rented_movie desc;
                                                                
-- Task 11 - calculate and display the number of movie categories where the average between the movie replacement
--  cost and the rental rate is greater than $15
select * from film;
desc film;
select * from film_category;
desc film_category;
select * from category;
desc category;

SELECT c.name,COUNT(*) AS category_count
FROM film f 
JOIN film_category fc ON fc.film_id = f.film_id 
JOIN category c ON c.category_id = fc.category_id
WHERE (f.replacement_cost + f.rental_rate) / 2 > 15 group by c.name; 

-- Task 12: Display the film categories in which the number of movies is grater than 70.
select * from category;
select * from film;
select * from film_category;
desc category;
desc film;
desc film_category;


SELECT c.name AS category_name, COUNT(fc.film_id) AS movie_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
HAVING COUNT(fc.film_id) > 70;
