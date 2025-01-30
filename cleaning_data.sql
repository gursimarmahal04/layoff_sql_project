
-- Data cleaning

SELECT * FROM layoffs

-- Creating a copy of origanl table layoffs

CREATE TABLE layoffs_staging
(LIKE layoffs);

INSERT INTO layoffs_staging
SELECT * 
FROM layoffs;

SELECT *
FROM layoffs_staging

-- 1. Removing Duplicates

WITH duplicates_value AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised) AS row_num
    FROM layoffs_staging
)

SELECT *
FROM duplicates_value
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company='Cazoo';

-- Creating a new table with adding new column row_num in it.

CREATE TABLE layoffs_staging2 (
    company TEXT NOT NULL,
    location TEXT,
    industry TEXT,
    total_laid_off FLOAT,
    percentage_laid_off FLOAT,
    date DATE NOT NULL,
    stage TEXT,
    country TEXT NOT NULL,
    funds_raised FLOAT,
    row_num INT
);

INSERT INTO layoffs_staging2
SELECT *,
     ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised) AS row_num
FROM layoffs_staging

SELECT * FROM layoffs_staging2
WHERE row_num >1

-- Now we can delete duplicate rows

DELETE FROM layoffs_staging2
WHERE row_num >1


-- Handling null values

SELECT * 
FROM layoffs_staging2
WHERE country is NULL

SELECT * from layoffs_staging2
WHERE company='Appsmith'

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL


DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL
