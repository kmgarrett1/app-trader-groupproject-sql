SELECT a.name, a.price, a.review_count, a.rating, 
REPLACE(a.content_rating, '+','') AS content_rating, a.primary_genre, 
REPLACE(p.install_count, '+','') AS install_count, p.type
FROM app_store_apps as a
INNER JOIN play_store_apps as p
ON a.name = p.name
ORDER BY a.review_count DESC, a.rating DESC, a.price, install_count DESC;
