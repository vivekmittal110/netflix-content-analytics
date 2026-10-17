
-- ============================================================
-- NETFLIX ANALYTICS PROJECT
-- Database: Decoding Netflix End-to-End Content Strategy & BI Analysis
-- Table: public.netflix_titles
-- Dataset: 8,807 titles
-- ============================================================


-- 1. MOVIES VS TV SHOWS
SELECT
    type,
    COUNT(*) AS total_titles,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2
    ) AS percentage
FROM public.netflix_titles
GROUP BY type
ORDER BY total_titles DESC;


-- 2. TITLES ADDED BY YEAR
SELECT
    EXTRACT(YEAR FROM date_added_parsed)::INTEGER AS year_added,
    COUNT(*) AS titles_added
FROM public.netflix_titles
WHERE date_added_parsed IS NOT NULL
GROUP BY EXTRACT(YEAR FROM date_added_parsed)
ORDER BY titles_added DESC, year_added DESC;


-- 3. TITLES BY ORIGINAL RELEASE YEAR
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM public.netflix_titles
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY total_titles DESC, release_year DESC;


-- 4. CONTENT RATING DISTRIBUTION
SELECT
    COALESCE(rating, 'Missing') AS content_rating,
    COUNT(*) AS total_titles,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2
    ) AS percentage
FROM public.netflix_titles
GROUP BY rating
ORDER BY total_titles DESC, content_rating;


-- 5. TOP 15 GENRES
SELECT
    TRIM(genre) AS genre,
    COUNT(*) AS total_titles
FROM public.netflix_titles AS n
CROSS JOIN LATERAL
    UNNEST(STRING_TO_ARRAY(n.listed_in, ',')) AS genre
WHERE n.listed_in IS NOT NULL
GROUP BY TRIM(genre)
ORDER BY total_titles DESC, genre
LIMIT 15;


-- 6. TOP 15 COUNTRIES
SELECT
    TRIM(country_name) AS country,
    COUNT(*) AS total_titles
FROM public.netflix_titles AS n
CROSS JOIN LATERAL
    UNNEST(STRING_TO_ARRAY(n.country, ',')) AS country_name
WHERE n.country IS NOT NULL
  AND TRIM(country_name) <> ''
GROUP BY TRIM(country_name)
ORDER BY total_titles DESC, country
LIMIT 15;


-- 7. MOVIE DURATION STATISTICS
SELECT
    COUNT(*) AS total_movies,
    ROUND(AVG(duration_minutes), 2) AS average_minutes,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY duration_minutes) AS median_minutes,
    MIN(duration_minutes) AS shortest_movie_minutes,
    MAX(duration_minutes) AS longest_movie_minutes
FROM public.netflix_titles
WHERE type = 'Movie'
  AND duration_minutes IS NOT NULL;


-- 8. TV SHOW SEASON STATISTICS
SELECT
    COUNT(*) AS total_tv_shows,
    ROUND(AVG(duration_seasons), 2) AS average_seasons,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY duration_seasons) AS median_seasons,
    MIN(duration_seasons) AS minimum_seasons,
    MAX(duration_seasons) AS maximum_seasons,
    COUNT(*) FILTER (
        WHERE duration_seasons = 1
    ) AS single_season_shows
FROM public.netflix_titles
WHERE type = 'TV Show'
  AND duration_seasons IS NOT NULL;


-- 9. TOP RELEASE YEARS BY CONTENT TYPE
WITH yearly_counts AS (
    SELECT
        type,
        release_year,
        COUNT(*) AS total_titles
    FROM public.netflix_titles
    WHERE release_year IS NOT NULL
    GROUP BY type, release_year
),
ranked_years AS (
    SELECT
        type,
        release_year,
        total_titles,
        RANK() OVER (
            PARTITION BY type
            ORDER BY total_titles DESC
        ) AS year_rank
    FROM yearly_counts
)
SELECT
    type,
    release_year,
    total_titles,
    year_rank
FROM ranked_years
WHERE year_rank <= 5
ORDER BY type, year_rank, release_year;


-- 10. TOP DIRECTORS
SELECT
    TRIM(director_name) AS director,
    COUNT(*) AS total_titles
FROM public.netflix_titles AS n
CROSS JOIN LATERAL
    UNNEST(STRING_TO_ARRAY(n.director, ',')) AS director_name
WHERE n.director IS NOT NULL
  AND TRIM(director_name) <> ''
GROUP BY TRIM(director_name)
ORDER BY total_titles DESC, director
LIMIT 15;


-- 11. TOP PERFORMERS
SELECT
    TRIM(performer_name) AS performer,
    COUNT(*) AS total_titles
FROM public.netflix_titles AS n
CROSS JOIN LATERAL
    UNNEST(STRING_TO_ARRAY(n."cast", ',')) AS performer_name
WHERE n."cast" IS NOT NULL
  AND TRIM(performer_name) <> ''
GROUP BY TRIM(performer_name)
ORDER BY total_titles DESC, performer
LIMIT 15;


-- 12. CONTENT RATINGS BY TYPE
SELECT
    type,
    COALESCE(rating, 'Missing') AS content_rating,
    COUNT(*) AS total_titles,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (PARTITION BY type), 2
    ) AS percentage_within_type
FROM public.netflix_titles
GROUP BY type, rating
ORDER BY type, total_titles DESC;


-- 13. TITLES ADDED BY CALENDAR MONTH
SELECT
    EXTRACT(MONTH FROM date_added_parsed)::INTEGER AS month_number,
    TRIM(TO_CHAR(date_added_parsed, 'Month')) AS month_name,
    COUNT(*) AS titles_added
FROM public.netflix_titles
WHERE date_added_parsed IS NOT NULL
GROUP BY
    EXTRACT(MONTH FROM date_added_parsed),
    TRIM(TO_CHAR(date_added_parsed, 'Month'))
ORDER BY titles_added DESC, month_number;


-- 14. MEDIAN MOVIE DURATION BY RELEASE PERIOD
SELECT
    CASE
        WHEN release_year BETWEEN 2005 AND 2009 THEN '2005-2009'
        WHEN release_year BETWEEN 2010 AND 2014 THEN '2010-2014'
        WHEN release_year BETWEEN 2015 AND 2019 THEN '2015-2019'
        WHEN release_year BETWEEN 2020 AND 2021 THEN '2020-2021'
    END AS release_period,
    COUNT(*) AS total_movies,
    ROUND(
        PERCENTILE_CONT(0.5)
            WITHIN GROUP (ORDER BY duration_minutes)::NUMERIC,
        2
    ) AS median_duration_minutes
FROM public.netflix_titles
WHERE type = 'Movie'
  AND duration_minutes IS NOT NULL
  AND release_year BETWEEN 2005 AND 2021
GROUP BY release_period
ORDER BY release_period;
