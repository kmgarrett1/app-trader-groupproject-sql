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

select 
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
ORDER BY a.review_count DESC, a.rating DESC, a.price, install_count DESC;

	

