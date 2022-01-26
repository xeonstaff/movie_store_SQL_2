--1 list all customers who live in TEXAS (join)
--T1: customer: first_name, last_name, *address_id
--T2: address: district+, address_id*

select c.first_name, c.last_name, a.district
from customer c inner join address a 
on c.address_id = a.address_id
where district = 'Texas'


--2 get all payments above 6.99 with the customers' full name
--T1: customer: first_name, last_name, customer_id*
--T2: payment: customer_id*, amount

select c. first_name, c.last_name, p.amount 
from customer c inner join payment p 
on c.customer_id = p.customer_id
where amount > 6.99
order by amount


--3 show all customers names who have made payments over 175 (sq)
--T1: customer: first_name, last_name, customer_id*
--T2: payment: customer_id*, amount


select c.first_name, c.last_name, sum(payment.amount)
from customer c 
where customer_id in (
	select customer_id 
	from payment p 
	where sum(payment.amount) > 175
)

--4 list all customers who live in nepal (city table)
--T1: customer: first_name, last_name, address_id*
--T2: address: address_id, city_id*
--T3: city: city_id*, country_id*
--T4: country: country_id*, country

select customer.first_name, customer.last_name, country
from customer 
full join address on customer.address_id = address.address_id
full join city on address.city_id = city.city_id 
full join country on city.country_id = country.country_id
where country = 'Nepal'


--5 which staff member had the most transactions?
--there's only two staff members so this works...it wouldn't with duplicate surnames
--T1: staff: staff_id*, last_name
--T2: payment: staff_id*,

select last_name, count(last_name) 
from staff 
full join payment on staff.staff_id = payment.staff_id
group by last_name
order by last_name

--6 how many movies of each rating are there?
--T1:inventory: film_id*
--T2: film: film_id*, rating+, title

select count(film.rating), film.rating
from inventory full join film on inventory.film_id = film.film_id 
group by film.rating
order by count(film.rating) desc

--7 show all customers who have made a single payment above 699 (sq) -- (repeat question?)
--T1: customer: first_name, last_name, customer_id*
--T2: payment: customer_id*, amount+

--normal way with amounts
select c.first_name, c.last_name, p.amount
from customer c inner join payment p 
on c.customer_id = p.customer_id 
where amount > 699

--subquery way without amounts
select c.first_name, c.last_name
from customer c 
where customer_id in (
	select customer_id 
	from payment p 
	where amount > 699
)

--8 how many free rentals did the stores give away?
--T1:payment: amount+
select count(rental_id)
from payment
where amount = 0
group by amount
