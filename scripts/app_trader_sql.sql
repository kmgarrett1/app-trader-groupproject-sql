select 
	a.name, 
	CAST(a.price AS money) AS a_price,
	CAST(p.price AS money) AS p_price,
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
WHERE a_price = < 1 AND p_price = < 1
ORDER BY 
	rating_num DESC,
	install_count_num DESC,
	a_review_count_num DESC,  
	a.price;

