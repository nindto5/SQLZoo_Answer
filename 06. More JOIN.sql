-- 1.List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962

-- 2.Give year of 'Citizen Kane'
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

-- 3.List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
GROUP BY title
ORDER BY yr;

-- 4.What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name= 'Glenn Close'

-- 5.What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca'

-- 6.Obtain the cast list for 'Casablanca'.
SELECT x.name
FROM actor AS x
JOIN casting AS y ON x.id=y.actorid
JOIN movie AS z ON y.movieid=z.id
WHERE z.id= 11768;

-- 7.Obtain the cast list for the film 'Alien'
SELECT x.name
FROM actor AS x
JOIN casting AS y ON x.id=y.actorid
JOIN movie AS z ON y.movieid=z.id
WHERE z.title= 'Alien';

-- 8.List the films in which 'Harrison Ford' has appeared
SELECT x.title
FROM movie AS x
JOIN casting AS y ON x.id=y.movieid
JOIN actor AS z ON y.actorid=z.id
WHERE z.name= 'Harrison Ford';

-- 9.List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT x.title
FROM movie AS x
JOIN casting AS y ON x.id=y.movieid
JOIN actor AS z ON y.actorid=z.id
WHERE z.name = 'Harrison Ford' AND y.ord !=1;

-- 10.List the films together with the leading star for all 1962 films
SELECT x.title, z.name
FROM movie AS x
  JOIN casting AS y ON x.id=y.movieid
  JOIN actor AS z ON y.actorid=z.id
WHERE x.yr= 1962 AND y.ord = 1;

-- 11.Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
SELECT yr, COUNT(title) 
FROM movie AS x
  JOIN casting AS y ON x.id=y.movieid
  JOIN actor AS z ON y.actorid=z.id
WHERE z.name= 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12.List the film title and the leading actor for all of the films 'Julie Andrews' played in
SELECT x.title, z.name
FROM movie AS x
  JOIN casting AS y ON (x.id=y.movieid AND ord=1)
  JOIN actor AS z ON y.actorid=z.id
WHERE y.movieid IN (SELECT y.movieid FROM casting AS y WHERE y.actorid IN(SELECT z.id FROM actor AS z WHERE z.name= 'Julie Andrews'))
GROUP BY x.title;

-- 13.Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles
SELECT x.name
FROM actor as x
  JOIN casting as y ON x.id=y.actorid
  JOIN movie as z ON y.movieid=z.id
WHERE ord = 1
GROUP BY x.name
HAVING COUNT(*) >= 15
ORDER BY x.name;

-- 14.List the films released in the year 1978 ordered by the number of actors in the cast, then by title
SELECT x.title, COUNT(z.name)
FROM movie AS x
  JOIN casting AS y ON x.id=y.movieid
  JOIN actor AS z ON y.actorid=z.id
WHERE yr=1978
GROUP BY x.title
ORDER BY COUNT(z.name) DESC, x.title;

-- 15.List all the people who have worked with 'Art Garfunkel'
SELECT DISTINCT(x1.name)
FROM actor as x
  JOIN casting as y ON x.id=y.actorid
  JOIN movie as z ON y.movieid=z.id
  JOIN casting y1 ON z.id = y1.movieid
  JOIN actor as x1 ON y1.actorid=x1.id
WHERE x.name = 'Art Garfunkel'
  AND x1.name != 'Art Garfunkel';
