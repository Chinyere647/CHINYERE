-- PROJECT 1

-- Select Statement
-- 1. Retrieve all columns from the `products` table.;
SELECT *
FROM product_retailstores;

-- 2. Retrieve only the `product_id` and `Product` columns from the `products` table.
select product_id, product
from product_retailstores;

-- 3. Retrieve the `Customer name` and `city` from the `customers` table.
select customer_name, city
from customer2;

-- From Statement
-- 4. Write a query to display all columns from the `orders` table.
select *
from orders;
-- 5. Display the `order_id`, `order_date`, and `total_amount` from the `orders` table.

-- Where Statement
-- 6. Retrieve all products from the `products` table where the `price` is greater than 500.
select product, price
from product_retailstores
where price > 500;

-- 7. Find all customers from the `customers` table who live in "Houston".
select customer_name, city
from customer2
where city like "Houston";

-- 8. Retrieve all orders from the `orders` table where the `total_amount` is less than 1000.
select order_id, total_amount
from orders
where total_amount < 1000;

-- 9. Find all products in the `products` table that belong to the "Electronics" category.
select product, category
from product_retailstores
where category like "Electronics";

-- Group By and Order By
-- 10. Count the number of products in each category from the `products` table and group the results by
-- `Category`.
select count(product), category
from product_retailstores
group by category;

-- 11. Retrieve the total number of orders placed by each customer from the `orders` table, grouped by
-- `customer_id`.
select sum(order_id), customer_id
from orders
group by customer_id;
-- 12. Display the average `price` of products in each category, sorted by the average price in descending
-- order.
select avg(price), Category
from product_retailstores
group by Category
order by avg(price) desc;

-- 13. Find the total `quantity` of each product sold from the `order_items` table, grouped by `product_id`.
select product_id, sum(quantity)
from order_items
group by product_id;

-- Using Having vs. Where Statement
-- 14. Retrieve categories from the `products` table where the average price is greater than 500 (use
-- `GROUP BY` and `HAVING`).
select category, Avg(price)
from product_retailstores
group by Category
having avg(price) > 500;

select *
from customer2;

select *
from order_items;

select *
from orders;

select *
from product_retailstores;
-- 15. Find customers from the `customers` table who are in the "Young" age bracket (use `WHERE`).
select Customer_name, Age_Bracket
from customer2
where Age_Bracket like "young";

-- 16. Retrieve products from the `products` table where the price is greater than 300 and the category is accessories (use WHERE)
select product, price, category
from product_retailstores
where price > 300 and category like "accessories";

-- 17. Display categories from the `products` table that have more than 5 products (use `GROUP BY` and
-- `HAVING`)
select Category, count(Product)
from product_retailstores
group by category
having count(product) > 5;


-- PROJECT 1

-- Limit and Aliasing
-- 18. Retrieve the top 5 most expensive products from the `products` table (use `LIMIT`).
select Product, price
from product_retailstores
order by price desc
limit 5;

-- 19. Display the first 10 orders from the `orders` table, sorted by `order_date` in ascending order.
select order_id, order_date
from orders
order by order_date asc
limit 10;

-- 20. Retrieve the `product_id` and `Product` from the `products` table, and alias them as `ID` and `Product
-- Name`.
select product_id as id, Product as product_name
from product_retailstores;
-- 21. Find the top 3 customers with the highest `total_amount` spent from the `orders` table.
select customer_id, total_amount
from orders
order by total_amount  desc
limit 3;


-- Joins in MySQL
-- 22. Retrieve the `order_id`, `order_date`, and `Customer name` by joining the `orders` and `customers`
-- tables.
select o.order_id, o.order_date, c.Customer_name
from orders as o
inner join
customer2 as c
on 
o.Customer_id = c.customer_id;

-- 23. Display the `product_id`, `Product`, and `quantity` sold by joining the `products` and `order_items`
-- tables.
select p.product_id, p.Product, o.quantity
from product_retailstores as p
inner join order_items as o
on
p.product_id = o.product_id;

-- 24. Find the total revenue generated by each product by joining the `products` and `order_items` tables.
select p.product, p.product_id, o.quantity*o.unit_price as revenue
from product_retailstores as p
inner join order_items as o
on
p.product_id = o.product_id;


-- 25. Retrieve the `Customer name`, `order_date`, and `total_amount` by joining the `customers` and
-- `orders` tables.
select C.Customer_name, o.order_date, o.total_amount
from customer2 as C
inner join
Orders as o
on 
o.customer_id = C.Customer_id;

-- Unions in MySQL
-- 26. Retrieve a list of all unique cities from the `customers` table and combine it with a list of all unique
-- categories from the `products` table (use `UNION`).
select city
from customer2
union
select category
from product_retailstores;


-- 27. Combine the `product_id` from the `products` table with the `order_id` from the `orders` table (use
-- `UNION`).
select product_id
from product_retailstores
union
select order_id
from orders;

-- Case Statements
-- 28. Create a new column in the `products` table called `Price Range` that categorizes products as "Low"
-- (price < 300), "Medium" (price between 300 and 700), and "High" (price > 700) using a `CASE` statement.
alter table product_retailstores
add column price_range text;
update product_retailstores
set price_range = 
case
when price < 300 then "low"
when price between 300 and 700 then "medium"
when price > 700 then "high"
end; 


-- 29. Use a `CASE` statement to categorize customers in the `customers` table as "Young" (age <= 33), 
-- "Working Class" (age between 34 and 49), and "Retired" (age >= 50).
select *,
case when age <= 33 then "young"
when age between 34 and 49 then "working class"
when age >= 50 then "retired"
end as age_category
from customer2;

  -- 30. Retrieve the `order_id` and a new column called `Order Size` that categorizes orders as "Small"
-- (total_amount < 500), "Medium" (total_amount between 500 and 1000), and "Large" (total_amount >

-- 1000) using a `CASE` statement.
select order_id,
Case
When total_amount < 500 then "small"
When total_amount between 500 and 1000 then "medium"
When total_amount > 1000 then "large"
End as order_size
from orders;

-- PROJECT 1
-- Intermediate Challenges
-- 31. Find the top 5 customers who have spent the most money in total (join `customers` and `orders`
-- tables).
select max(total_amount), c.customer_name, c.Customer_id
from customer2 as c
inner join orders as o 
on
c.customer_id = o.customer_id
group by Customer_name, Customer_id
having max(total_amount)
limit 5; 

-- 32. Retrieve the `Product` name, `Category`, and total revenue generated by each product (join
-- `products` and `order_items` tables).
select P.Product, P.Category, sum(O.quantity*unit_price) as total_revenue
from product_retailstores as P
inner join order_items as o
on 
P.product_id = O.product_id
group by product, category
having total_revenue;

-- 33. Display the `Customer name`, `order_date`, and `total_amount` for orders placed in January 2023
-- (use `WHERE` with date filtering).
select C.Customer_name, O.order_date, O.total_amount
from orders as O
inner join customer2 as C
on 
O.customer_id = C.Customer_id
where order_date between "1/1/2023" and "1/31/2023";

-- 34. Find the average `total_amount` of orders for each customer, and display only those customers
-- whose average order amount is greater than 1000 (use `GROUP BY` and `HAVING`).
select avg(total_amount), order_id
from orders
group by order_id
having avg(total_amount) > 1000;
-- 35. Retrieve the `Customer name`, `Product`, and `quantity` for all orders placed by customers in "New
-- York" (join `customers`, `orders`, and `order_items` tables).
select c.customer, p.product, i.quantity, o.order
from customer2 as c
left join
orders as o
on
c.customer_id = o.customer_id
left join
 order_items as i
 on
 o.order_id = i.order_id
 left join
 product_retailstores as p
 on
o.product_id = p.product_id
 where city = "New_York"; 

 -- 36. Find customers who placed orders in both January and February 2023.
 select Customer_id, order_id
 from orders
 where order_date between "1/1/2023" and "2/28/2023";