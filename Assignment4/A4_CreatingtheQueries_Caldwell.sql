-- CSCI-C442 Assignment 4 Part 2
-- Creating the Queries

-- Drew D. Caldwell
-- 4/8/2025

-- A. What is the full name, full address, title, and phone number for all employees currently living in any US state
-- shares a border with the Pacific Ocean? (Note: not just for the current data)

select first_name || ' ' || last_name as full_name,
       address || ' ' || city || ', ' || region || ' ' || postal_code || ' ' ||country as full_address from employees
       where country = 'USA' and region in('WA', 'OR', 'CA', 'AK', 'HI')

-- B. Give the same information for all employees not in the USA but are older than 50 years of age.
-- Also made new column age to ensure accuracy
select first_name || ' ' || last_name as full_name,
       address || ' ' || city || ', ' || postal_code || ' ' ||country as full_address,
       date_part('year', age(current_date, birth_date)) as age from employees
       where country <> 'USA' and date_part('year', age(current_date, birth_date)) > 50;

-- C. Which employees (last name, first name without repeats) have placed orders delivered to Norway?
select distinct e.last_name, e.first_name, o.ship_country
from employees e
join orders o
    on e.employee_id = o.employee_id
    where o.ship_country = 'Norway'

-- D. What is the title and name of any employee that has sold at least two of either "Veggie-Spread" or "Sir Rodney's Marmalade?"
select
    e.last_name, e.first_name, e.title, p.product_name, count(p.product_name) as product_count
from employees e
join orders o
    on e.employee_id = o.employee_id
join order_details d
    on o.order_id = d.order_id
join products p
    on d.product_id = p.product_id
where p.product_name in ('Vegie-spread', 'Sir Rodney''s Marmalade')
group by e.last_name, e.first_name, e.title, p.product_name
having count(p.product_name) > 2;

--E. What are the employee ID's for all employees who have sold more than 70 products?
select
    e.employee_id,  sum(d.quantity) as total_products_sold
from employees e
join orders o
    on e.employee_id = o.employee_id
join order_details d
    on o.order_id = d.order_id
join products p
    on d.product_id = p.product_id
group by e.employee_id, e.last_name, e.first_name, e.title
having sum(d.quantity) > 70;

--F. List the last name of all employees that live on the same city as their managers.
select e.last_name
from employees e
join employees m
    on e.reports_to = m.employee_id
where e.city = m.city;

--G. List the product names of all products that were bought OR sold by people who live in London. USE UNION.
-- Products bought by employees that live in London
select p.product_name
from products p
join order_details d
    on p.product_id = d.product_id
join orders o
    on d.order_id = o.order_id
join employees e
    on o.employee_id = e.employee_id
where e.city = 'London'

union

-- Products sold by employees that live in London
select p.product_name
from products p
join order_details d
    on p.product_id = d.product_id
join orders o
    on d.order_id = o.order_id
join employees e
    on o.employee_id = e.employee_id
where e.city = 'London';


--H. What is the average price of products for each category?
-- Output just the average price as "average_price" and the category ID
select p.category_id, avg(p.unit_price) as average_price
from products p
    group by p.category_id;