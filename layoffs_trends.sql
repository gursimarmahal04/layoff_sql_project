-- This query extracts the month from each record in 'layoffs_staging2' and calculates the total layoffs per month.
-- Steps:
-- 1. Use EXTRACT(MONTH FROM date) to get the numerical value of the month (1 for January, 12 for December).
-- 2. Use TO_CHAR(date, 'Mon') to display the month as a three-letter abbreviation.
-- 3. Group by both the numeric month value ('mon_num') and the month name ('month') to ensure correct aggregation.
-- 4. Order by the numeric month value to display months chronologically.


SELECT 
    EXTRACT(MONTH FROM date) as mon_num,
    TO_CHAR(date, 'Mon') AS month,
    SUM(total_laid_off) AS total_layoffs
FROM 
    layoffs_staging2
GROUP BY
    month,mon_num
ORDER BY 
    mon_num;

