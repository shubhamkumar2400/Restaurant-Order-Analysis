-- Problems Statements-- 

-- 	View the menu_items table and write a query to find the number of items on the menu

select count(*) from menu_items;

-- 1.	What are the least and most expensive items on the menu?

select item_name, price from menu_items
order by price;

select item_name, price from menu_items
order by price desc;

-- 2.	How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?

select count(*) from menu_items
where category = 'Italian'

-- Least_Expensive

select * from menu_items
where category = 'Italian'
order by price;

-- Most_Expensive

select * from menu_items
where category = 'Italian'
order by price desc;

-- 3.	How many dishes are in each category? What is the average dish price within each category?

select category, count(item_name) as num_dishes, avg(price) as avg_dish_price from menu_items
group by category

-- 4.	View the order_details table. What is the date range of the table?

select * from order_details;

select min(order_date), max(order_date) from order_details;

-- 5.	How many orders were made within this date range? How many items were ordered within this date range?

select count(distinct order_id) from order_details;

select count(*) from order_details;

-- 6.	Which orders had the most number of items?

select order_id, count(item_id) as most_items from order_details
group by order_id
order by most_items desc

-- 7.	How many orders had more than 12 items?

select count(*) from (
select order_id, count(item_id) as item_counts from order_details
group by order_id
having item_counts > 12) as num_orders

-- 8.	Combine the menu_items and order_details tables into a single table

select *
from menu_items
Inner join order_details on menu_items.menu_item_id = order_details.item_id

-- 9.	What were the least and most ordered items? What categories were they in?

select item_name , count(order_details_id) as purchases, m.category
from order_details od
left join menu_items m
on od.item_id = m.menu_item_id
group by item_name, m.category
order by purchases desc;

-- 10.	What were the top 5 orders that spent the most money?

select order_id, sum(price) as total_money_spent
from order_details od
left join menu_items m
on od.item_id = m.menu_item_id
group by order_id
order by total_money_spent desc limit 5;

-- 11.	View the details of the highest spend order. Which specific items were purchased?

select category, count(item_id) as items_num from order_details od
left join menu_items m
on od.item_id = m.menu_item_id
where order_id = 440
group by category

-- 12.	View the details of the top 5 highest spend orders

select order_id, category, count(item_id) as items_num from order_details od
left join menu_items m
on od.item_id = m.menu_item_id
where order_id in (440, 2075, 1957, 330, 2675)
group by order_id, category

