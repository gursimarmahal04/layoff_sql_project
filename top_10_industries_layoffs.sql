-- This query calculates the top 10 industries by total layoffs.
-- Steps:
-- 1. Use a Common Table Expression (CTE) named 'industry_layoffs' to aggregate total layoffs by industry.
-- 2. Group the results by industry and sum the 'total_laid_off' values.
-- 3. Filter out any rows with NULL layoff values.
-- 4. Order the result by total layoffs in descending order and limit the output to the top 10.


WITH industry_layoffs AS(
    SELECT industry,
        SUM(total_laid_off) AS total_layoffs
    FROM
        layoffs_staging2
    GROUP BY 
        industry
)

SELECT *
FROM industry_layoffs
WHERE total_layoffs IS NOT NULL
ORDER BY total_layoffs DESC
LIMIT 10;