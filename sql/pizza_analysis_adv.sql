-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

--  2. Determine the distribution of orders by hour of the day.

select hour(order_time),
count(order_id) 
from orders 
group by hour(order_time);

-- 3. Join relevant tables to find the category-wise distribution of pizzas.

select category , count(name) from pizza_types
group by(category); 

-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(quantity))  as avg_pizza_order_per_day
FROM (
    SELECT orders.order_date, 
           SUM(order_details.quantity) AS quantity
    FROM orders 
    JOIN order_details
    ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS order_quantity;

-- 5. Determine the top 3 most ordered pizza types based on revenue.

 select pizza_types.name,
 sum(order_details.quantity * pizzas.price) as revenue
 from pizza_types join pizzas
 on pizzas.pizza_type_id = pizza_types.pizza_type_id
 join order_details
 on order_details.pizza_id = pizzas.pizza_id
 group by pizza_types.name order by revenue desc limit 3;
 
 
