/*SELECT 
	play_store_apps.name, 
	rating, 
	install_count
FROM play_store_apps
WHERE rating IS NOT NULL 
ORDER BY rating DESC;*/

/*SELECT 
	name, 
	rating, 
	install_count
FROM play_store_apps
WHERE rating IS NOT NULL AND rating > 4.6
ORDER BY install_count DESC;*/

/*SELECT 
	p.name,
	a.name,
	p.rating,
	a.rating, 
	a.review_count,
	p.review_count
FROM play_store_apps AS p
LEFT JOIN app_store_apps AS a
ON p.name = a.name
ORDER BY a.review_count, p.review_count;*/

/*SELECT
	a.name,
	CAST(a.review_count AS integer),
	p.review_count,
	a.rating,
	p.rating
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
WHERE p.review_count >50000 AND CAST(a.review_count AS integer) >50000
ORDER BY a.rating DESC, p.rating DESC;*/

/*select 
	a.name, 
	a.price, 
	a.review_count, 
	a.rating, 
	REPLACE(a.content_rating, '+','') AS content_rating, 
	a.primary_genre, 
	REPLACE(p.install_count, '+','') AS install_count, 
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
ORDER BY a.review_count DESC, a.rating DESC, a.price, install_count DESC;*/

/*select 
	a.name, 
	a.price, 
	a.review_count, 
	a.rating, 
	CAST(REPLACE(a.content_rating, '+','') AS int) AS content_rating_num, 
	a.primary_genre, 
	CAST(REPLACE(p.install_count, '+','') AS int) AS install_count_num, 
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
ORDER BY a.review_count DESC, a.rating DESC, a.price, install_count DESC;*/

/*select 
    a.name, 
	CAST(a.price AS money),
	CAST(p.price AS money),
	CAST(a.review_count AS numeric) AS a_review_count_num, 
	CAST(p.review_count AS numeric) AS p_review_count_num,
	CAST(a.rating AS numeric) AS rating_num,
	p.rating,
	CAST(REPLACE(a.content_rating, '+','') AS numeric) AS content_rating_num, 
	a.primary_genre, 
	CAST(REPLACE(REPLACE(p.install_count, '+',''), ',','') AS numeric) AS install_count_num,
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
WHERE a.price < '1' AND p.price < '1'
ORDER BY 
	rating_num DESC,
	install_count_num DESC,
	a_review_count_num DESC,  
	a.price;*/

/*SELECT 
	a.name, 
	p.name,
	a.rating AS a_rating
FROM app_store_apps AS a
JOIN play_store_apps AS p
ON a.name = p.name
GROUP BY a.name, p.name, a_rating;*/

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
	
