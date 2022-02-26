select
	name,
	total_reviews,
	SUM(weighted_a_rating + weighted_p_rating) AS weighted_avg_rating,
	a_price,
	a_content_rating,
	p_content_rating,
	a_genre,
	p_genre,
	install_count_num
	FROM
	(select
		name,
		SUM(a_review_count + p_review_count) AS total_reviews,
		a_rating * a_review_count / SUM(a_review_count + p_review_count) AS weighted_a_rating,
		p_rating * p_review_count / SUM(a_review_count + p_review_count) AS weighted_p_rating,
		a_price,
		a_content_rating,
		p_content_rating,
		a_genre,
		p_genre,
		install_count_num
		FROM
		(select 
			a.name AS name, 
			CAST(a.price AS money) AS a_price,
			CAST(a.rating AS numeric) AS a_rating,
			CAST(a.review_count AS integer) AS a_review_count,
			CAST(p.rating AS numeric) AS p_rating,
			AVG(CAST(p.review_count AS numeric)) AS p_review_count,
			CAST(REPLACE(a.content_rating, '+','') AS text) AS a_content_rating,
			p.content_rating AS p_content_rating,
			a.primary_genre AS a_genre,
			p.genres AS p_genre,
			CAST(REPLACE(REPLACE(p.install_count, '+',''), ',','') AS numeric) AS install_count_num
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
			a_rating,
			a_review_count,
			p_rating,
			a.content_rating,
			p.content_rating,
			a.primary_genre,
			p.genres,
			p.install_count
		ORDER BY 
			p_rating DESC,
			a_rating DESC,
			install_count_num DESC) AS subquery1
	GROUP BY
		name,
		a_rating,
		p_rating,
		a_review_count,
		p_review_count,
		a_price,
		a_content_rating,
		p_content_rating,
		a_genre,
		p_genre,
		install_count_num) AS subquery2
GROUP BY
	name,
	total_reviews,
	a_price,
	a_content_rating,
	p_content_rating,
	a_genre,
	p_genre,
	install_count_num
ORDER BY
	weighted_avg_rating DESC,
	install_count_num DESC;
