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
