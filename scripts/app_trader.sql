
-- 3. Deliverables
-- a. Develop some general recommendations as to the price range, genre, content rating, or anything else for apps that the company should target.

-- b. Develop a Top 10 List of the apps that App Trader should buy next week for its Fourth of July debut.

-- c. Prepare a 5-10 minute presentation for the leadership team of App Trader to inform them of your recommendations.

-- All analysis work must be done in PostgreSQL, however you may export query results if you want to create charts in Excel for your presentations.
SELECT  ps.name, ps.genres AS dis_gen, AVG(ps.rating) AS avg_rate, sum(ps.review_count) AS num_reviews
FROM play_store_apps AS ps
FULL JOIN app_store_apps AS aa
ON ps.genres = aa.primary_genre
WHERE ps.rating IS NOT NULL
AND ps.review_count > 20
GROUP BY ps.review_count, genres, ps.name
ORDER BY avg_rate DESC, num_reviews DESC
LIMIT 20;
-- This line is to deliniate between codes. Below is Rudy's
select p.name, p.price, p.rating, a.size_bytes, p.install_count
from play_store_apps as p
left join app_store_apps as a
on p.name = a.name
order by install_count DESC;
-- This line is to deliniate between codes.
SELECT DISTINCT p.name, p.price, REPLACE(p.install_count, '+', ' ') AS installed
FROM play_store_apps as p
LEFT JOIN app_store_apps AS a
ON p.name = a.name
ORDER BY installed DESC, price
LIMIT 25;
-- This line is to deliniate between codes.
select name, category, rating, review_count, type, price, content_rating, primary_genre
from app_store_apps as a
UNION ALL 
SELECT name, category, rating, review_count, install_count, type, price, content_rating, genre
FROM play_store_apps as p
ON a.name = p.name
;
-- abigail's code
select 
	a.name, 
	a.price, 
	CAST(a.review_count AS int), 
	a.rating, 
	REPLACE(a.content_rating, '+','') AS content_rating, 
	a.primary_genre, 
	REPLACE(CAST(p.install_count AS int), '+','') AS install_count, 
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
ORDER BY a.review_count DESC, a.rating DESC, a.price, install_count DESC;


