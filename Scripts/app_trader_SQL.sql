/*select count(*)
from app_store_apps;

select count(*)
from play_store_apps;*/
--correct number of rows have been populated--

--readme not 4th of july but pi date--

--5-10 min presentation.  many people can present.  
--all analysis will be in sql.  you cannot create visuals.  when you run your query for the data you want.  export the data.  you can create visuals using excel--
--you presentation would be best as a slide-show in google slide --
-- a week from thursday --
--For "B top ten list." - Base off all the rules laid out.  its easy to go off on your own, but try to use the rules to come up with a top 10 list--
--dont get too caught up in pi related apps--
--do not have pie charts--
--make sure it's readable and effective visuals--
--3-5 dashboard.  make sure you have appropriate amount of slides for the time you're afforded.  1 slide per min.--
--dont limit yourself to one presenter.  you can have multiple presentors.  have one person drive the presentation.  2-3 would be good for talking--
--save information.  download button on the top right corner.  lets you save results to file.  --
--git checkout -b RudyMoya    this is how you create a branch--

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


/*  if you already have answers to questions - think about what else (data prespective) what else might be interesting for them?
example: how much will each app make in it's lifetime.   
these 10 apps.  this is how much this app will make based off these projections you gave us.
--she made a query to determine exactly how many apps were completely left off once i joined them all together.  she made a subquery in select and from.--

do whatever you want in the project.*/ 


--Rudy M. Price differences by by store--

Select 
	a.primary_genre, 
	count(a.primary_genre), 
	max(a.price) as max_apple,
	min(a.price) as min_apple,
	avg(a.price) as avg_apple,
	max(cast(p.price as money)) as max_google,
	min(cast(p.price as money)) as min_google,
		max(cast(a.price as money)) - max(cast(p.price as money)) AS max_diff,
		min(cast(a.price as money)) - min(cast(p.price as money)) AS min_diff
FROM 
	app_store_apps as a
INNER JOIN 
	play_store_apps as p
ON
	a.name = p.name
GROUP BY
	a.primary_genre
ORDER BY
	max_apple DESC, 
	max_google DESC,
	min_apple DESC,
	min_google DESC;
	

--Breakdown by name and price difference--

SELECT a.name, p.name, max(a.price) as max_apple, max(cast(p.price as money)) as max_google
FROM 
	app_store_apps as a
INNER JOIN 
	play_store_apps as p
ON
	a.name = p.name
WHERE 
	a.primary_genre = 'Medical'
GROUP BY
	a.name,
	p.name
ORDER BY
	max_apple DESC,
	max_google DESC;


--katie's sql statement--

SELECT 
	a.name,
	(2*p.rating + 1) AS longevity,
	((2500 - 1000)*(2*p.rating+1)*12) AS expected_revenue,
	CASE WHEN a.price <= 1.00 THEN 10000
		 WHEN a.price > 1.00 THEN a.price*10000 END AS purchase_price,
	((2500 - 1000)*(2*p.rating+1)*12) - (CASE WHEN a.price <= 1.00 THEN 10000
		 WHEN a.price > 1.00 THEN a.price*10000 END) AS net
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
GROUP BY 
	a.name,
	expected_revenue,
	longevity,
	purchase_price
ORDER BY
	net DESC;
