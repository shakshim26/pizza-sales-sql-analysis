-- Calculate the percentage contribution of each pizza type to total revenue.
-- Formula: Percentage = (category / total) * 100 
-- Below there GroupBy ka game . Category Mai Group Use h So veg Revenue , Non veg Revenue but... Total no Groupby all category ka e mai .

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    SUM(order_details.quantity * pizzas.price)
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;


-- Analyze the cumulative revenue generated over time.

select order_date,    --  Kaunsa value kis date ka hai? 
sum(revenue) over (order by order_date) as cum_revenue   -- Yeh running total (cumulative) nikalta hai
from
(select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue     -- Har day ka total revenue nikalta hai
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
join orders on order_details.order_id = orders.order_id
group by orders.order_date ) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
 
select *    -- saare columns le aao 
from (
select pizza_types.category,  pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue,
rank() over( partition by pizza_types.category    -- Partition : Yeh data ko alag-alag groups me tod deta hai
		order by sum(order_details.quantity * pizzas.price) desc   -- Order By Yeh ranking ke liye use ho raha hai, highest rank 1 
        ) as rn
        FROM pizza_types
    JOIN pizzas 
        ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN order_details 
        ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.category, pizza_types.name
    ) as ranked_pizza
    where rn <= 3;  -- where : use filtering ke liye hota hai , only give top 3 remove all col
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
