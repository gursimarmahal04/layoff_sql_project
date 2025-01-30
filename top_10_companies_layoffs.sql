-- This query calculates the top 10 companies by total layoffs
-- Steps:
-- 1. Use a Common Table Expression (CTE) named 'total_layoffs' to aggregate total layoffs by company.
-- 2. Group the results by company and sum the 'total_laid_off' values.
-- 3. Filter out any rows with NULL layoff values.
-- 4. Order the result by layoffs in descending order and limit the output to the top 10.


WITH total_layoffs AS (
    SELECT 
        company,
        SUM(total_laid_off) AS employees_laid_off
    FROM 
        layoffs_staging2
    GROUP BY 
        company
)
SELECT *
FROM 
    total_layoffs
WHERE 
    employees_laid_off IS NOT NULL
ORDER BY 
    employees_laid_off DESC
LIMIT 10;