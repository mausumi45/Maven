## consumers demographic 
--- Q.1) Total consumers in each  State 
SELECT State ,
       COUNT(distinct ï»¿Consumer_ID ) as consumer_count
from consumers
GROUP BY State
order BY consumer_count;

--- Q.2) Total consumers in each city
SELECT City ,
       COUNT(distinct ï»¿Consumer_ID ) as consumer_count
from consumers
GROUP BY City
order BY consumer_count;

--- Q.3) total consumer in each budget
SELECT Budget ,
       COUNT(distinct ï»¿Consumer_ID) as consumer_count
From consumers
WHERE Budget IS NOT null
GROUP BY Budget
ORDER BY consumer_count;

--- Q.4) Total smoker count in each occupation
SELECT Occupation ,
       COUNT(distinct ï»¿Consumer_ID) as consumer_count
From consumers
WHERE Occupation IS NOT null and Smoker = "yes" and Smoker IS NOT NULL
GROUP BY Occupation
ORDER BY consumer_count;

--- Q.5) Total student count in each drink level
SELECT  Drink_Level,
       COUNT(distinct ï»¿Consumer_ID) as consumer_count
From consumers
WHERE Occupation = "Student" and Drink_Level IS NOT NULL
GROUP BY Drink_Level
ORDER BY consumer_count;

--- Q.6) Total consumers in each transportaation method
SELECT  Transportation_Method,
       COUNT(distinct ï»¿Consumer_ID) as consumer_count
From consumers
WHERE Transportation_Method IS NOT NULL
GROUP BY Transportation_Method
ORDER BY consumer_count;

--- Q.7) Add age_bucket
ALTER TABLE Consumers ADD Age_bucket Varchar(20);

SELECT * from consumers;
--- Q.8) set value in age bucket
UPDATE consumers
SET age_bucket = CASE WHEN age > 60 then '61 and Above'
					  WHEN age > 40 then '41 - 60'	
					  WHEN age > 25 then '26 - 40'
					  WHEN age >= 18 then '18 - 25'
					  END
WHERE age_bucket Is NULL;

--- Q.9) total consumer in each age_bucket
SELECT age_bucket ,
       COUNT(distinct ï»¿Consumer_ID) as consumer_count
From consumers
GROUP BY age_bucket
ORDER BY consumer_count;
 
 --- Q.10) Total smoker count in each age group 
 SELECT age_bucket,
       COUNT(distinct ï»¿Consumer_ID) as consumer_count,
       COUNT(CASE when Smoker = "yes" THEN ï»¿Consumer_ID END) as smoker_count,
       100.0*(COUNT(CASE when Smoker = "yes" THEN ï»¿Consumer_ID END)/COUNT(distinct ï»¿Consumer_ID)) as percentage
From consumers
GROUP BY age_bucket
ORDER BY consumer_count;

----------------------------------------- Consumer Preference ------------------------------------------
--- Q.11) Top 20 preferred cuisine
SELECT * from consumer_preferences;
SELECT COUNT(distinct ï»¿Consumer_ID) from consumer_preferences;
SELECT Preferred_Cuisine,
       COUNT(distinct ï»¿Consumer_ID) as consumer_count
FROM consumer_preferences
GROUP BY Preferred_Cuisine
ORDER BY consumer_count desc
LIMIT 20;

--- Q.12) 
SELECT ï»¿Consumer_ID,
       COUNT(distinct Preferred_Cuisine) as cuisine_count,
       GROUP_CONCAT(Preferred_Cuisine) as all_cuisine
FROM consumer_preferences
GROUP BY ï»¿Consumer_ID
ORDER BY cuisine_count desc;

--- Q.13) budget analysis for each customer

SELECT P.Preferred_Cuisine,
        COUNT( CASE WHEN Budget = "Low" THEN 1 END) as low,
		COUNT( CASE WHEN Budget = "medium" THEN 1 END) as medium,
		COUNT( CASE WHEN Budget = "high" THEN 1 END) as high
FROM consumers C
INNER JOIN consumer_preferences P
ON C.ï»¿Consumer_ID = P.ï»¿Consumer_ID
GROUP BY Preferred_Cuisine
order BY Preferred_Cuisine;

--- Q.14) statewise Cuisine count
SELECT
		b.preferred_cuisine,
		SUM(CASE WHEN a.state = 'Cuernavaca 'Then 1 Else 0 END) AS Morelos,
		SUM(CASE WHEN a.state = 'San Luis Potosi' Then 1 Else 0 END) AS San_Luis_Potosi,
		SUM(CASE WHEN a.state = 'Tamaulipas' Then 1 Else 0 END) AS Tamaulipas
FROM CONSUMERS AS a
INNER JOIN consumer_preferences AS b
ON a.ï»¿Consumer_ID = b.ï»¿Consumer_ID
GROUP BY b.preferred_cuisine
ORDER BY b.preferred_cuisine;

--- Q.15) age wise preferred cuisine
SELECT
		b.preferred_cuisine,
		SUM(CASE WHEN a.age_bucket = '18 - 25' Then 1 Else 0 END) AS "18 - 25",
		SUM(CASE WHEN a.age_bucket = '26 - 40' Then 1 Else 0 END) AS "26 - 40",
		SUM(CASE WHEN a.age_bucket = '41 - 60' Then 1 Else 0 END) AS "41 - 60",
		SUM(CASE WHEN a.age_bucket = '61 and Above' Then 1 Else 0 END) AS "61+"
FROM 	consumers AS a
INNER JOIN consumer_preferences AS b
ON a.ï»¿Consumer_ID = b.ï»¿Consumer_ID
GROUP BY b.preferred_cuisine
ORDER BY b.preferred_cuisine;

       