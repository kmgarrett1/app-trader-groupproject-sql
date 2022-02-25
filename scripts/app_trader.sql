-- 3. Deliverables
-- a. Develop some general recommendations as to the price range, genre, content rating, or anything else for apps that the company should target.

-- b. Develop a Top 10 List of the apps that App Trader should buy next week for its Fourth of July debut.

-- c. Prepare a 5-10 minute presentation for the leadership team of App Trader to inform them of your recommendations.

-- All analysis work must be done in PostgreSQL, however you may export query results if you want to create charts in Excel for your presentations.
select 
	DISTINCT a.name, 
	CAST(a.price AS money) AS ap,
	CAST(p.price AS money) AS pp,
	COUNT(a.review_count) AS a_review_count_num, 
	COUNT(p.review_count) AS p_review_count_num,
	AVG(a.rating) + AVG(p.rating)/(AVG(a.rating) + AVG(p.rating)) AS rating_num,
	SUM(CAST(REPLACE(a.content_rating, '+','') AS numeric)) AS content_rating_num, 
	a.primary_genre, 
	SUM(CAST(REPLACE(REPLACE(p.install_count, '+',''), ',','') AS numeric)) AS install_count_num,
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
WHERE a.price < '1' AND p.price < '1'
GROUP BY primary_genre, a.name, a.price, p.price, p.rating, p.type, a.rating, p.rating
ORDER BY 
	rating_num DESC,
	install_count_num DESC,
	primary_genre DESC, a.name, ap;
-- This line shall not be crossed.
select 
	a.name, 
	CAST(a.price AS money),
	CAST(a.rating AS numeric) AS a_rating,
	CAST(p.rating AS numeric) AS p_rating,
	CAST(REPLACE(a.content_rating, '+','') AS numeric) AS content_rating_num,
	p.content_rating,
	a.primary_genre,
	CAST(REPLACE(p.install_count, '+','') AS numeric) AS install_count_num,
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
WHERE  p.install_count >= 1000000 
	a.price < '1' 
	AND p.price < '1'
	AND a.rating BETWEEN 4.5 AND 5.0
	AND p.rating BETWEEN 4.5 AND 5.0
GROUP BY
	a.name,
	a.price,
	a.review_count,
	a.rating,
	p.rating,
	a.content_rating,
	p.content_rating,
	a.primary_genre,
	p.install_count,
	p.type
ORDER BY 
	p_rating DESC,
	a_rating DESC,
	install_count_num DESC;
-- What we decided to go with
select 
	a.name, 
	CAST(a.price AS money),
	CAST(a.rating AS numeric) AS a_rating,
	CAST(p.rating AS numeric) AS p_rating,
	CAST(REPLACE(a.content_rating, '+','') AS numeric) AS content_rating_num,
	p.content_rating,
	a.primary_genre,
	CAST(REPLACE(REPLACE(p.install_count, '+',''), ',','') AS numeric) AS install_count_num,
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
WHERE 
	a.price < '1' 
	AND p.price < '1'
	AND a.rating BETWEEN 4.5 AND 5.0
	AND p.rating BETWEEN 4.5 AND 5.0
GROUP BY
	a.name,
	a.price,
	a.review_count,
	a.rating,
	p.rating,
	a.content_rating,
	p.content_rating,
	a.primary_genre,
	p.install_count,
	p.type
ORDER BY 
	p_rating DESC,
	a_rating DESC,
	install_count_num DESC;

	
