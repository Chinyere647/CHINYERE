-- PROJECT 2
-- Select Statement

SELECT *
FROM data_dictionary;

SELECT *
FROM locations;

SELECT *
FROM make_details;

SELECT *
FROM stolen_vehicle;


-- 1. Retrieve all columns from the `stolen_vehicles` table.
select *
from stolen_vehicle;

-- 2. Select only the `vehicle_type`, `make_id`, and `color` columns from the `stolen_vehicles` table.
-- From Statement
select vehicle_type, make_id, color
from stolen_vehicle; 

-- 1. Write a query to display all records from the `make_details` table
select *
from make_details;

-- 2. Retrieve all columns from the `locations` table.
select *
from locations;

-- Where Statement
-- 1. Find all stolen vehicles that are of type "Trailer".
select vehcle_id
from stolen_vehcle
where vehicle_types = "trailer";


-- 2. Retrieve all stolen vehicles that were stolen after January 1, 2022.
select vehcle_id, vehicle_type, date_stolen
from stolen_vehicle
where date_stolen like "%1,2022%";

-- 3. Find all stolen vehicles that are of color "Silver".

select vehicle_id, vehicle_type, color
from stolen_vehicle
where color like "silver";


--  By and Order By
-- 1. Count the number of stolen vehicles for each `vehicle_type` and order the results by the count in
-- descending order.

select vehicle_type, COUNT(vehicle_id)
from stolen_vehicle
group by vehicle_type
order by COUNT(vehicle_id);

-- 2. Find the total number of stolen vehicles for each `make_id` and order the results by `make_id`.

SELECT make_id, COUNT(vehicle_id) AS total_stolen_vehicles
FROM stolen_vehicle
GROUP BY make_id
ORDER BY make_id;

-- Using Having vs. Where Statement
-- 1. Find the `make_id` values that have more than 10 stolen vehicles.

select make_id, COUNT(vehicle_type)
from stolen_vehicle
group by  make_id
Having COUNT(vehicle_type) > 10;

-- 2. Retrieve the `vehicle_type` values that have at least 5 stolen vehicles.
-- Limit and Aliasing
select vehicle_id, COUNT(vehicle_type) AS vehicle_stolen_type
from stolen_vehicle
group by vehicle_type
having COUNT(vehicle_type) >= 5;

-- 1. Retrieve the first 10 records from the `stolen_vehicles` table and alias the `vehicle_type` column as
-- "Type".
select vehicle_id, vehicle_type AS 'type', make_id, model_year, vehicle_desc, color, date_stolen, location_id
from stolen_vehicle
limit 10;

-- 2. Find the top 5 most common colors of stolen vehicles and alias the count column as "Total".
-- Joins in MySQL
select COUNT(vehicle_id) as "total", vehicle_type,color
from stolen_vehicle
group by vehicle_type, color 
limit 5 ;

-- 1. Join the `stolen_vehicles` table with the `make_details` table to display the `vehicle_type`,
-- make_name`, and `color` of each stolen vehicle.
select v.vehicle_type, mn.make_name, sv.color
from stolen_vehicle AS SV
inner join make_details AS MD
on 
m.make_id = sv.make_id;

-- 2. Join the `stolen_vehicles` table with the `locations` table to display the `vehicle_type`, `region`, and
-- `country` where the vehicle was stolen.
-- Unions in MySQL

select vehicle_type, region,country
from stolen_vehicle AS sv
left join locations AS L
on
sv.location_id =l.location_id;

-- 1. Write a query to combine the `make_name` from the `make_details` table and the `region` from the
-- `locations` table into a single column.
select make_name
from make_details
union
select region
from locations;

-- PROJECT 2

-- 2. Combine the `vehicle_type` from the `stolen_vehicles` table and the `make_type` from the
-- `make_details` table into a single column.
select vehicle_type, make_type
from stolen_vehicle
union
select make_type
from make_details;

-- Case Statements
-- 1. Create a new column called "Vehicle_Category" that categorizes vehicles as "Luxury" if the
-- `make_type` is "Luxury" and "Standard" otherwise.

update make_details
set vehicle_category =case
when  make_type = luxury then 'luxury'
when make_type = standard then 'standard'
Else 'otherwise'
End;


-- 2. Use a CASE statement to categorize stolen vehicles as "Old" if the `model_year` is before 2010, "Mid"
-- if between 2010 and 2019, and "New" if 2020 or later.
-- Aggregate Functions.

update stolen_vehicle
set stolen_vehicle_model_year = case
when model_year < 2010 then old
when model_year between 2010 and 2019
Else 'NEW' 
end as vehicle_age_category;

-- 1. Calculate the total number of stolen vehicles.
select sum(vehicle_id), vehicle_type
from stolen_vehicle
group by vehicle_type;

-- 2. Find the average population of regions where vehicles were stolen.
select AVG(population),region
from locations
group by region;

-- 3. Determine the maximum and minimum `model_year` of stolen vehicles.
-- String Functions
select max(model-year)
from stolen_vehicle;

select min(model_year)
from stolen_vehicle;

-- 1. Retrieve the `make_name` from the `make_details` table and convert it to uppercase.
select upper( make_name)
from make_details;

-- 2. Find the length of the `vehicle_desc` for each stolen vehicle.
select length(vehicle_desc)
from stolen_vehicle;

-- 3. Concatenate the `vehicle_type` and `color` columns from the `stolen_vehicles` table into a single
-- column called "Description".
select concat(vehicle_type, '-', color) AS description
from stolen_vehicle;

-- Update Records
-- 1. Update the `color` of all stolen vehicles with `vehicle_type` "Trailer" to "Black".
update stolen_vehicle
set color = 'black'
where vehicle_type = 'trailer';

-- 2. Change the `make_name` of `make_id` 623 to "New Make Name" in the `make_details` table.
update make_details
set make_name = 'new_make_name'
where make_id = 623;


-- Bonus Questions.
-- 1. Write a query to find the top 3 regions with the highest number of stolen vehicles.

SELECT  COUNT(vehicle_id),region
FROM stolen_vehicle as sv
inner join location as l
on 
sv.location_id = l.loction_id
GROUP BY region
ORDER BY count(vehicle_id) DESC
LIMIT 3;

-- 2 To retrieve the make_name and the total number of stolen vehicles for each make, but only for makes that have more than 5 stolen vehicles
SELECT  COUNT(vehicle_id) AS total_stolen_vehicle, make_name
FROM stolen_vehicle AS SV
inner join make_details MD
ON SV.make_id =MD.makeke_id

GROUP BY make_name
HAVING COUNT(vehicle_id) > 5 ; 

-- 3. Use a JOIN to find the `region` and `country` where the most vehicles were stolen.
SELECT region, country, MAX(vehicle_id) AS MAX_STOLEN_VEHICLEES
FROM locations AS L
INNER JOIN stolen_vehicle AS SV
ON L.location_id = Av.location_id
GROUP BY region, country;

-- 4. Write a query to find the percentage of stolen vehicles that are of type "Boat Trailer".
select count(vehicle_id), vehicle_type
from stolen_vehicle
where  vehicle_type = 'Boat Trailer';

-- 5. Use a CASE statement to create a new column called "Density_Category" that categorizes regions as
-- "High Density" if `density` is greater than 500, "Medium Density" if between 200 and 500, and "Low
-- Density" if less than 200.
select region, density, case
when density >500 THEN 'High density'
when density BETWEEN 200 AND 500 THEN 'Medium Density'
Else 'Low Density'
End AS Denity_Category
From locations;