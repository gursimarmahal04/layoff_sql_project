-- This query identifies companies with layoffs greater than the average and compares each company's layoffs to the overall average.
-- Steps:
-- 1. Select the company name and its total layoffs.
-- 2. Use AVG(total_laid_off) OVER () to compute the overall average layoffs without collapsing the rows.
-- 3. Filter the rows using a subquery to include only companies where total_laid_off is greater than the overall average.
-- 4. Order the results by total_laid_off in descending order to show companies with the highest layoffs first.

SELECT 
    company,
    total_laid_off,
    AVG(total_laid_off) OVER () AS avg_laid_offs
FROM 
    layoffs_staging2
WHERE total_laid_off > (
    SELECT AVG(total_laid_off) FROM layoffs_staging2
)
ORDER BY
    total_laid_off DESC;