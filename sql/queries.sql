--Howe many restaurants total?
select
Count(*) as total_restaurants
from zomato_restaurants 


--Top 10 localities by restaurant count
select locality,
count(*) as total_restaurants,
round(AVG(aggregate_rating)::numeric,2) as avg_rating,
round(AVG(votes)::numeric,0) as avg_votes
from zomato_restaurants 
group by locality
order by total_restaurants desc
limit 10

--Top 15 cuisines 
select cuisine,
count(*) as restaurant_count,
round(AVG(aggregate_rating )::numeric,2) as avg_rating,
round(AVG(avg_cost_for_two )::numeric,0) as avg_price
from cuisine_breakdown 
where aggregate_rating >0
group by cuisine 
order by restaurant_count desc
limit 15


--Price range vs average rating
select price_range,
count(*) as total,
round(avg(aggregate_rating)::numeric,2) as avg_rating,
round(avg(average_cost_for_two)::numeric,0) as avg_cost_for_two
from zomato_restaurants zr 
where zr.aggregate_rating >0
group by price_range 
order by price_range 

--Online delivery effect on ratings
select has_online_delivery,
count(*) as total,
round(avg(aggregate_rating)::numeric,2) as avg_rating,
round(avg(votes)::numeric,0) as avg_votes
from zomato_restaurants zr 
where zr.aggregate_rating >0
group by has_online_delivery 

--Undeserved locality(low supply,decent rating signal)
WITH locality_stats AS (
    SELECT locality,
           COUNT(*) AS restaurant_count,
           AVG(aggregate_rating) AS avg_rating,
           AVG(votes) AS avg_votes
    FROM zomato_restaurants
    WHERE aggregate_rating > 0
    GROUP BY locality
),
benchmarks AS (
    SELECT AVG(restaurant_count) AS city_avg_count
    FROM locality_stats
)
SELECT ls.locality,
       ls.restaurant_count,
       ROUND(ls.avg_rating::numeric, 2) AS avg_rating,
       ROUND(ls.avg_votes::numeric, 0) AS avg_votes
FROM locality_stats ls, benchmarks b
WHERE ls.restaurant_count < b.city_avg_count
  AND ls.avg_rating >= 3.8
ORDER BY ls.avg_rating DESC,ls.avg_votes DESC;

--Deleivery time by time of day
SELECT time_of_day,
       ROUND(AVG(delivery_time_min)::numeric, 1) AS avg_delivery_min,
       ROUND(AVG(preparation_time_min)::numeric, 1) AS avg_prep_min,
       COUNT(*) AS total_orders
FROM delivery_times
GROUP BY time_of_day
ORDER BY avg_delivery_min DESC;

--Delivery time by traffic level
SELECT traffic_level,
       ROUND(AVG(delivery_time_min)::numeric, 1) AS avg_delivery_min,
       COUNT(*) AS orders
FROM delivery_times
GROUP BY traffic_level
ORDER BY avg_delivery_min DESC;

--Delivery time by weather condition
SELECT weather,
       ROUND(AVG(delivery_time_min)::numeric, 1) AS avg_delivery_min,
       COUNT(*) AS orders
FROM delivery_times
GROUP BY weather
ORDER BY avg_delivery_min DESC;
