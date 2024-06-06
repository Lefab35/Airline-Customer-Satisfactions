CREATE DATABASE airline_satisfaction;

USE airline_satisfaction;

SELECT * 
FROM airline_satisfaction.customers;

-- 1. Customer satisfactions percentage?
SELECT 
satisfaction, COUNT(satisfaction) AS count,
( COUNT(satisfaction) / 
    (SELECT COUNT(*) 
    FROM customers)
) * 100 AS percentage
FROM customers
GROUP BY satisfaction
ORDER BY percentage DESC;

-- 2. Age group distribution
# Age, and Flight distance statistics
SELECT MIN(age) AS youngest, MIN(flight_distance) AS shortest_flight,
	   AVG(age) AS mean, AVG(flight_distance) AS avg_flight,
	   MAX(age) AS oldest, MAX(flight_distance) AS longest_flight
FROM customers
WHERE age >= 1;

SELECT
CASE 
	WHEN age <= 8 THEN 'Child'
	WHEN age >= 9 AND age <= 17 THEN 'Teenage'
	WHEN age >= 18 AND age <= 30 THEN 'Young'
	WHEN age >= 31 AND age <= 59 THEN 'Adult'
	ELSE 'Senior'
END AS age_names, 
COUNT(*) AS count
FROM customers
WHERE age >= 1
GROUP BY age_names
ORDER BY count DESC;

-- 3. Customer satisfactions by Age group 
SELECT
CASE 
	WHEN age <= 8 THEN 'Child'
	WHEN age >= 9 AND age <= 17 THEN 'Teenage'
	WHEN age >= 18 AND age <= 30 THEN 'Young'
	WHEN age >= 31 AND age <= 59 THEN 'Adult'
	ELSE 'Senior'
END AS age_names, satisfaction,
COUNT(*) AS count
FROM customers
WHERE age >= 1
GROUP BY age_names, satisfaction
ORDER BY age_names, satisfaction DESC;

-- 4. Flight ranges distribution
SELECT
CASE
	WHEN flight_distance < 700 THEN 'short_haul'
    WHEN flight_distance >= 700 AND flight_distance < 2200 THEN 'medium_haul'
    WHEN flight_distance >= 2200 AND flight_distance < 5400 THEN 'long_haul'
    ELSE 'ultra_long_haul'
END AS flight_range,
COUNT(*) AS count
FROM customers
WHERE flight_distance > 0 AND age > 0
GROUP BY flight_range
ORDER BY flight_range; 


-- 5. Customer satisfactions by Flight ranges 
SELECT
CASE
	WHEN flight_distance < 700 THEN 'short_haul'
    WHEN flight_distance >= 700 AND flight_distance < 2200 THEN 'medium_haul'
    WHEN flight_distance >= 2200 AND flight_distance < 5400 THEN 'long_haul'
    ELSE 'ultra_long_haul'
END AS flight_range, satisfaction,
COUNT(*) AS count
FROM customers
WHERE flight_distance > 0 AND age > 0
GROUP BY flight_range, satisfaction
ORDER BY flight_range, satisfaction; 


-- 6. Flight classes by Customer age range
SELECT
CASE 
	WHEN age <= 8 THEN 'Child'
	WHEN age >= 9 AND age <= 17 THEN 'Teenage'
	WHEN age >= 18 AND age <= 30 THEN 'Young'
	WHEN age >= 31 AND age <= 59 THEN 'Adult'
	ELSE 'Senior'
END AS age_names, 
class, COUNT(*) AS count
FROM customers
GROUP BY age_names, class
ORDER BY age_names, count DESC;


-- 7. Filtering  and sorting data base Customer satisfaction, type and travel 
SELECT satisfaction, 
customer_type, travel_type,
COUNT(*) AS count
FROM customers
GROUP BY satisfaction, 
customer_type, travel_type
ORDER BY satisfaction, travel_type;


-- 8. Flight Classes distribution by age name
SELECT 
class, COUNT(class) AS count,
( COUNT(class) / 
    (SELECT COUNT(*) 
    FROM customers)
) * 100 AS percentage,
CASE 
	WHEN age <= 8 THEN 'Child'
	WHEN age >= 9 AND age <= 17 THEN 'Teenage'
	WHEN age >= 18 AND age <= 30 THEN 'Young'
	WHEN age >= 31 AND age <= 59 THEN 'Adult'
	ELSE 'Senior'
END AS age_names
FROM customers
WHERE age >= 1 AND class <> 1
GROUP BY age_names, class
ORDER BY percentage DESC, age_names;


-- 9. total number of customers surveyed
SELECT COUNT(*) AS total_customers
FROM customers;


-- 10. Percentage of airline customers by flight classes who ranked 4 and 5 to cleanliness
SELECT cleanliness, class, COUNT(*) AS count,
(COUNT(cleanliness) / (SELECT COUNT(*) FROM customers)) * 100 AS rank_percentage
FROM customers
WHERE cleanliness >= 4 
GROUP BY class, cleanliness
ORDER BY 
(CASE
	WHEN cleanliness = 5 THEN class
    ELSE cleanliness
END) DESC;


-- 11. Airline Classes proportion ?
SELECT 
class, COUNT(class) AS count,
( COUNT(class) / 
    (SELECT COUNT(*) 
    FROM customers)
) * 100 AS percentage
FROM customers
GROUP BY class
ORDER BY percentage DESC;


-- 12. 

