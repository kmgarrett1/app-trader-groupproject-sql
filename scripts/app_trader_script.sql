/*SELECT
	a.name, 
	CAST(a.price AS money),
	CAST(a.rating AS numeric) AS a_rating,
	CAST(p.rating AS numeric) AS p_rating,
	CAST(REPLACE(a.content_rating, '+','') AS numeric) AS content_rating_num,
	p.content_rating,
	a.primary_genre,
	CAST(REPLACE(REPLACE(p.install_count, '+',''), ',','') AS numeric) AS install_count_num,
	p.type
FROM app_store_apps as a
INNER JOIN play_store_apps as p
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
	install_count_num DESC;*/
	
/*Calculating how much each app will make in its lifetime
Purchase Price = $10,000 (because we are using free apps
Apps earn $5,000 per month on average - 1/2 goes to developers and 1/2 goes to app trader
$1,000 on marketing 
Projected lifespan :an app with a rating of 0 can be expected to be in use for 1 year, an app with a rating of 1.0 can be expected to last 3 years, and an app with a rating of 4.0 can 	be expected to last 9 years. Ratings should be rounded to the nearest 0.5 to evaluate an app's likely longevity.*/

/*2500 is half of the expected monthly revenue (5000)after splitting 1/2 wtih developers, 	1000 is monthly cost of marketing, 2n+1 calculates expected longevity, *12 to account for 12 months of revenue per year of longevity
Cost is 10,000 times the price of the app. For apps that are priced from free up to 		$1.00, the purchase price is $10,000*/

SELECT 
	a.name,
	(2*a.rating + 1) AS longevity,
	((2500 - 1000)*(2*a.rating+1)*12) AS expected_revenue,
	CASE WHEN a.price <= 1.00 THEN 10000
		 WHEN a.price > 1.00 THEN a.price*10000 END AS purchase_price,
	((2500 - 1000)*(2*a.rating+1)*12) - (CASE WHEN a.price <= 1.00 THEN 10000
		 WHEN a.price > 1.00 THEN a.price*10000 END) AS net
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
GROUP BY 
	a.name,
	longevity,
	purchase_price
ORDER BY
	net DESC;
	
