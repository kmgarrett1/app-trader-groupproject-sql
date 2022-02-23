select 
	a.name, 
	a.price, 
	CAST(a.review_count AS numeric) AS review_count_num, 
	CAST(a.rating AS numeric) AS rating_num, 
	CAST(REPLACE(a.content_rating, '+','') AS numeric) AS content_rating_num, 
	a.primary_genre, 
	CAST(REPLACE(REPLACE(p.install_count, '+',''), ',','') AS numeric) AS install_count_num,
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
ORDER BY 
	rating_num DESC,
	install_count_num DESC,
	review_count_num DESC,  
	a.price;
