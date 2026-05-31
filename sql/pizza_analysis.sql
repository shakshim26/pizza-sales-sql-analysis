-- 1. Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

-- 2. Calculate the total revenue generated from pizza sales.
-- why we use join due to due diffrent table diffrent row h woh  humein for revenue so we used join dono table common is pizza_id.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
-- 3.Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- 4 . Identify the most common pizza size ordered. (Interview) ⭐⭐⭐⭐=

select quantity, count(order_details_id)
from order_details
group by quantity ;    -- quantity = number of pizzas in that single order row ( order id )

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- query do join both tables, group it pizza size,  count how many times order sizes 
-- Aggregate data = Summary data ( Count Summary ) without count we get may raw row . count how many in each group 
-- agrregated count value must group by with non aggreagated