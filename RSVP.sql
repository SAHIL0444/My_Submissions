USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



SELECT 
    COUNT(*) AS ROW_COUNT
FROM
    DIRECTOR_MAPPING

SELECT 
    COUNT(*) AS ROW_COUNT
FROM
    GENRE

SELECT 
    COUNT(*) AS ROW_COUNT
FROM
    MOVIE

SELECT 
    COUNT(*) AS ROW_COUNT
FROM
    NAMES

SELECT 
    COUNT(*) AS ROW_COUNT
FROM
    RATINGS

SELECT 
    COUNT(*) AS ROW_COUNT
FROM
    ROLE_MAPPING














-- Q2. Which columns in the movie table have null values?
-- Type your code below:
SELECT 
    SUM(CASE
        WHEN id IS NULL THEN 1
        ELSE 0
    END) AS ID_nulls,
    SUM(CASE
        WHEN title IS NULL THEN 1
        ELSE 0
    END) AS title_nulls,
    SUM(CASE
        WHEN year IS NULL THEN 1
        ELSE 0
    END) AS year_nulls,
    SUM(CASE
        WHEN date_published IS NULL THEN 1
        ELSE 0
    END) AS date_published_nulls,
    SUM(CASE
        WHEN duration IS NULL THEN 1
        ELSE 0
    END) AS duration_nulls,
    SUM(CASE
        WHEN country IS NULL THEN 1
        ELSE 0
    END) AS country_nulls,
    SUM(CASE
        WHEN worlwide_gross_income IS NULL THEN 1
        ELSE 0
    END) AS worlwide_gross_income_nulls,
    SUM(CASE
        WHEN languages IS NULL THEN 1
        ELSE 0
    END) AS languages_nulls,
    SUM(CASE
        WHEN production_company IS NULL THEN 1
        ELSE 0
    END) AS production_company_nulls
FROM
    movie





-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)



SELECT 
    YEAR, COUNT(ID) AS NUMBER_OF_MOVIES
FROM
    MOVIE
GROUP BY YEAR

-- 2ND PART
 
SELECT 
    MONTH(DATE_PUBLISHED) AS MONTH_NUM,
    COUNT(ID) AS NUMBER_OF_MOVIES
FROM
    MOVIE
GROUP BY MONTH_NUM
ORDER BY MONTH_NUM





/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
SELECT 
    COUNT(ID) AS NUMBER_OF_MOVIES, YEAR
FROM
    MOVIE
WHERE
    COUNTRY = 'USA' OR COUNTRY = 'INDIA'
GROUP BY COUNTRY
HAVING YEAR = 2019










/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

SELECT DISTINCT
    (GENRE)
FROM
    GENRE









/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

SELECT 
    GENRE, COUNT(ID) AS NUMBER_OF_MOVIES
FROM
    GENRE AS G
        INNER JOIN
    MOVIE AS M ON G.MOVIE_ID = M.ID
GROUP BY GENRE
ORDER BY NUMBER_OF_MOVIES DESC
LIMIT 1









/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

WITH SINGLE_GENRE AS(
SELECT  MOVIE_ID,COUNT(GENRE) AS NUMBER_OF_MOVIES
FROM GENRE
GROUP BY MOVIE_ID
HAVING NUMBER_OF_MOVIES=1
)
SELECT COUNT(MOVIE_ID) as SINGLE_GENRE_COUNT
FROM SINGLE_GENRE;









/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)



/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT 
    GENRE, ROUND(AVG(DURATION), 2) AS AVG_DURATION
FROM
    GENRE AS G
        INNER JOIN
    MOVIE AS M ON G.MOVIE_ID = M.ID
GROUP BY GENRE
ORDER BY AVG_DURATION DESC;








/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

WITH THRILLER_RANK AS
(SELECT GENRE, COUNT(MOVIE_ID) AS movie_count,
RANK() OVER(ORDER BY COUNT(MOVIE_ID) DESC) AS GENRE_RANK
FROM GENRE
GROUP BY GENRE
)
SELECT *
FROM THRILLER_RANK
WHERE GENRE='THRILLER';




/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:
SELECT MIN(AVG_RATING) AS MIN_AVG_RATING ,
		MAX(AVG_RATING) AS MAX_AVG_RATING,
        MIN(TOTAL_VOTES) AS MIN_TOTAL_VOTES,
        MAX(TOTAL_VOTES) AS MAX_TOTAL_VOTES , 
        MIN(MEDIAN_RATING) AS MIN_MEDIAN_RATING,
        MAX(MEDIAN_RATING) AS MAX_MEDIAN_RATING
FROM RATINGS;





    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

SELECT title, avg_rating,
		RANK() OVER(ORDER BY avg_rating DESC) AS movie_rank
FROM movie AS m
INNER JOIN ratings AS r
ON r.movie_id = m.id
LIMIT 10;


/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

SELECT MEDIAN_RATING, COUNT(MOVIE_ID) AS MOVIE_COUNT
FROM RATINGS
GROUP BY MEDIAN_RATING
ORDER BY MOVIE_COUNT DESC;




/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:
SELECT PRODUCTION_COMPANY , COUNT(ID) AS MOVIE_COUNT ,
DENSE_RANK()OVER(ORDER BY COUNT(ID) DESC ) AS PROD_COMPANY_RANK
FROM MOVIE AS M
INNER JOIN
RATINGS AS R
ON M.ID=R.MOVIE_ID
WHERE AVG_RATING >8 AND PRODUCTION_COMPANY IS NOT NULL
GROUP BY PRODUCTION_COMPANY 
ORDER BY MOVIE_COUNT DESC
LIMIT 1;








-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT GENRE,COUNT(G.MOVIE_ID) AS MOVIE_COUNT
FROM GENRE AS G
INNER JOIN 
RATINGS  AS R
ON G.MOVIE_ID=R.MOVIE_ID
INNER JOIN
MOVIE AS M
ON R.MOVIE_ID=M.ID
WHERE COUNTRY ='USA' AND TOTAL_VOTES > 1000 AND MONTH(DATE_PUBLISHED)=3 AND  YEAR= 2017
GROUP BY GENRE
ORDER BY MOVIE_COUNT DESC;

-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
SELECT TITLE , AVG_RATING , GENRE
FROM MOVIE AS M
INNER JOIN
RATINGS AS R
ON M.ID=R.MOVIE_ID
INNER JOIN
GENRE AS G
ON R.MOVIE_ID = G.MOVIE_ID
WHERE TITLE LIKE 'THE%' AND AVG_RATING > 8
ORDER BY AVG_RATING DESC;








-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

SELECT MEDIAN_RATING,COUNT(MOVIE_ID) AS MOVIE_COUNT
FROM RATINGS AS R
INNER JOIN
MOVIE AS M
ON R.MOVIE_ID=M.ID
WHERE MEDIAN_RATING=8  AND DATE_PUBLISHED BETWEEN '2018-04-01' AND '2019-04-01'
GROUP BY MEDIAN_RATING;










-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

SELECT LANGUAGES,TOTAL_VOTES
FROM MOVIE AS M
INNER JOIN 
RATINGS AS R
ON M.ID=R.MOVIE_ID
WHERE LANGUAGES LIKE 'GERMAN' OR LANGUAGES LIKE 'ITALIAN'
GROUP BY LANGUAGES
ORDER BY TOTAL_VOTES DESC;




-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT
		SUM(CASE WHEN NAME IS NULL THEN 1 ELSE 0 END) AS NAME_NULLS,
		SUM(CASE WHEN HEIGHT IS NULL THEN 1 ELSE 0 END) AS HEIGHT_NULLS,
		SUM(CASE WHEN DATE_OF_BIRTH IS NULL THEN 1 ELSE 0 END) AS DATE_OF_BIRTH_NULL,
		SUM(CASE WHEN KNOWN_FOR_MOVIES IS NULL THEN 1 ELSE 0 END) AS KNOWN_FOR_MOVIES_NULL
FROM NAMES;


/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

WITH top_rated_genres AS 
(
   SELECT
      genre,
      COUNT(m.id) AS movie_count,
      RANK () OVER (
   ORDER BY
      COUNT(m.id) DESC) AS genre_rank 
   FROM
      genre AS g 
      LEFT JOIN
         movie AS m 
         ON g.movie_id = m.id 
      INNER JOIN
         ratings AS r 
         ON m.id = r.movie_id 
   WHERE
      avg_rating > 8 
   GROUP BY
      genre 
)
SELECT
   n.name as director_name,
   COUNT(m.id) AS movie_count 
FROM
   names AS n 
   INNER JOIN
      director_mapping AS d 
      ON n.id = d.name_id 
   INNER JOIN
      movie AS m 
      ON d.movie_id = m.id 
   INNER JOIN
      ratings AS r 
      ON m.id = r.movie_id 
   INNER JOIN
      genre AS g 
      ON g.movie_id = m.id 
WHERE
   g.genre IN 
   (
      SELECT DISTINCT
         genre 
      FROM
         top_rated_genres 
      WHERE
         genre_rank <= 3
   )
   AND avg_rating > 8 
GROUP BY
   name 
ORDER BY
   movie_count DESC LIMIT 3;







/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT NAME AS ACTOR_NAME,COUNT(RM.MOVIE_ID) AS MOVIE_COUNT
FROM NAMES AS N
INNER JOIN
ROLE_MAPPING AS RM
ON N.ID=RM.NAME_ID
INNER JOIN
RATINGS AS R
ON  RM.MOVIE_ID=R.MOVIE_ID
WHERE RM.CATEGORY='ACTOR' AND MEDIAN_RATING>= 8
GROUP BY ACTOR_NAME
ORDER BY MOVIE_COUNT DESC
LIMIT 2;









/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
SELECT PRODUCTION_COMPANY ,SUM(TOTAL_VOTES )AS VOTE_COUNT , DENSE_RANK()OVER(ORDER BY SUM(TOTAL_VOTES) DESC) AS PROD_COMP_RANK
FROM MOVIE AS M
INNER JOIN 
RATINGS AS R
ON M.ID= R.MOVIE_ID
GROUP BY PRODUCTION_COMPANY
LIMIT 3;






/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT NAME AS ACTOR_NAME, (TOTAL_VOTES) AS TOTAL_VOTES,COUNT(M.ID) AS MOVIE_COUNT, ROUND(SUM(AVG_RATING*TOTAL_VOTES)/SUM(TOTAL_VOTES),2) AS ACTOR_AVG_RATING,
DENSE_RANK() OVER(ORDER BY AVG_RATING DESC) AS ACTOR_RANK
FROM MOVIE AS M
INNER JOIN 
RATINGS AS R
ON M.ID= R.MOVIE_ID
INNER JOIN
ROLE_MAPPING AS RM
ON R.MOVIE_ID=RM.MOVIE_ID
INNER JOIN
NAMES AS N
ON N.ID=RM.NAME_ID
WHERE CATEGORY='ACTOR' AND COUNTRY ='INDIA'
GROUP BY NAME
HAVING COUNT(M.ID)>=5
LIMIT 1;




-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
SELECT NAME AS ACTRESS_NAME, (TOTAL_VOTES) AS TOTAL_VOTES,COUNT(M.ID) AS MOVIE_COUNT,
ROUND(SUM(AVG_RATING*TOTAL_VOTES)/SUM(TOTAL_VOTES),2) AS ACTRESS_AVG_RATING,
DENSE_RANK() OVER(ORDER BY AVG_RATING DESC) AS ACTRESS_RANK
FROM MOVIE AS M
INNER JOIN 
RATINGS AS R
ON M.ID= R.MOVIE_ID
INNER JOIN
ROLE_MAPPING AS RM
ON R.MOVIE_ID=RM.MOVIE_ID
INNER JOIN
NAMES AS N
ON N.ID=RM.NAME_ID
WHERE CATEGORY='ACTRESS' AND COUNTRY ='INDIA' AND LANGUAGES = 'HINDI'
GROUP BY NAME
HAVING COUNT(M.ID)>=3
LIMIT 5;







/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


SELECT 
    TITLE,
    CASE
        WHEN AVG_RATING > 8 THEN 'SUPERHIT MOVIES'
        WHEN AVG_RATING BETWEEN 7 AND 8 THEN 'HIT MOVIES'
        WHEN AVG_RATING BETWEEN 5 AND 7 THEN 'ONE-TIME-WATCH-MOVIES'
        WHEN AVG_RATING < 5 THEN 'FLOOP MOVIES'
    END AS AVG_RATING_CATEGORY
FROM
    MOVIE AS M
        INNER JOIN
    GENRE AS G ON M.ID = G.MOVIE_ID
        INNER JOIN
    RATINGS AS R ON G.MOVIE_ID = R.MOVIE_ID
WHERE
    GENRE = 'THRILLER';









/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
SELECT GENRE,
		ROUND(AVG(DURATION),2) AS AVG_DURATION,
        SUM(ROUND(AVG(DURATION),2)) OVER(ORDER BY GENRE ROWS UNBOUNDED PRECEDING) AS RUNNING_TOTAL_DURATION,
        AVG(ROUND(AVG(DURATION),2)) OVER(ORDER BY GENRE ROWS 10 PRECEDING) AS MOVING_AVG_DURATION
FROM MOVIE AS M 
INNER JOIN GENRE AS G
ON M.ID= G.MOVIE_ID
GROUP BY GENRE
ORDER BY GENRE;










-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies

WITH TOP_3_GENRE AS
(
	SELECT GENRE , COUNT(MOVIE_ID) AS NUMBER_OF_MOVIES
    FROM GENRE AS G
    INNER JOIN 
    MOVIE AS M
    ON G.MOVIE_ID=M.ID
    GROUP BY GENRE
    ORDER BY NUMBER_OF_MOVIES DESC
    LIMIT 3
),
TOP_5_MOVIES AS
(
	SELECT GENRE,
    YEAR,
    TITLE AS MOVIE_NAME,
    WORLWIDE_GROSS_INCOME,
    DENSE_RANK() OVER(PARTITION BY year ORDER BY WORLWIDE_GROSS_INCOME DESC) AS MOVIE_RANK
    FROM MOVIE AS M
    INNER JOIN 
    GENRE AS G
    ON M.ID=G.MOVIE_ID
    WHERE GENRE IN(SELECT GENRE FROM TOP_3_GENRE)
)
SELECT * 
FROM 
TOP_5_MOVIES
WHERE MOVIE_RANK<=5;
    
    









-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

SELECT PRODUCTION_COMPANY , COUNT(ID) AS MOVIE_COUNT ,
RANK() OVER(ORDER BY count(id) DESC) AS PROD_COMP_RANK
FROM MOVIE AS M 
INNER JOIN 
RATINGS AS R
ON M.ID=R.MOVIE_ID
WHERE MEDIAN_RATING >=8 AND  PRODUCTION_COMPANY IS NOT NULL AND POSITION(',' IN LANGUAGES)>0
GROUP BY PRODUCTION_COMPANY
LIMIT 2;








-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT NAME AS ACTRESS_NAME,
SUM(TOTAL_VOTES) AS TOTAL_VOTES,
COUNT(RM.MOVIE_ID) AS MOVIE_COUNT,
AVG_RATING AS ACTRESS_AVG_RATING,
RANK() OVER(ORDER BY AVG_RATING DESC) AS ACTRESS_RANK
FROM NAMES AS N
INNER JOIN
ROLE_MAPPING AS RM
ON N.ID=RM.NAME_ID
INNER JOIN
RATINGS AS R
ON RM.MOVIE_ID=R.MOVIE_ID
INNER JOIN GENRE AS G
ON R.MOVIE_ID=G.MOVIE_ID
WHERE CATEGORY='ACTRESS' AND AVG_RATING>8 AND GENRE='DRAMA'
GROUP BY NAME
LIMIT 3;




/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:
WITH top_directors AS 
(
   SELECT
      n.id as director_id,
      n.name as director_name,
      COUNT(m.id) AS movie_count,
      RANK() OVER (
   ORDER BY
      COUNT(m.id) DESC) AS director_rank 
   FROM
      names AS n 
      INNER JOIN
         director_mapping AS d 
         ON n.id = d.name_id 
      INNER JOIN
         movie AS m 
         ON d.movie_id = m.id 
   GROUP BY
      n.id 
)
,
movie_summary AS 
(
   SELECT
      n.id as director_id,
      n.name as director_name,
      m.id AS movie_id,
      m.date_published,
      r.avg_rating,
      r.total_votes,
      m.duration,
      LEAD(date_published) OVER (PARTITION BY n.id 
   ORDER BY
      m.date_published) AS next_date_published,
      DATEDIFF(LEAD(date_published) OVER (PARTITION BY n.id 
   ORDER BY
      m.date_published), date_published) AS inter_movie_days 
   FROM
      names AS n 
      INNER JOIN
         director_mapping AS d 
         ON n.id = d.name_id 
      INNER JOIN
         movie AS m 
         ON d.movie_id = m.id 
      INNER JOIN
         ratings AS r 
         ON m.id = r.movie_id 
   WHERE
      n.id IN 
      (
         SELECT
            director_id 
         FROM
            top_directors 
         WHERE
            director_rank <= 9
      )
)
SELECT
   director_id,
   director_name,
   COUNT(DISTINCT movie_id) AS number_of_movies,
   ROUND(AVG(inter_movie_days), 0) AS avg_inter_movie_days,
   ROUND( SUM(avg_rating*total_votes) / SUM(total_votes) , 2) AS avg_rating,
   SUM(total_votes) AS total_votes,
   MIN(avg_rating) AS min_rating,
   MAX(avg_rating) AS max_rating,
   SUM(duration) AS total_duration 
FROM
   movie_summary 
GROUP BY
   director_id 
ORDER BY
   number_of_movies DESC,
   avg_rating DESC;