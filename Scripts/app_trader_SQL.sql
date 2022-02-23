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





/*select a.name, a.price, a.review_count, a.rating, a.content_rating, a.primary_genre, p.install_count, p.type
from app_store_apps as a
left join play_store_apps as p
ON a.name = p.name;*/


select 
	a.name, 
	a.price, 
	a.review_count, 
	a.rating, 
	a. content_rating_num, 
	a.primary_genre, 
	CAST(REPLACE(p.install_count, '+','') AS int) AS install_count_num, 
	p.type
from app_store_apps as a
inner join play_store_apps as p
ON a.name = p.name
ORDER BY a.review_count DESC, a.rating DESC, a.price, install_count DESC;












