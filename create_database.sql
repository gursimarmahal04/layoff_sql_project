DROP TABLE IF EXISTS layoffs;
CREATE TABLE layoffs (
    company TEXT NOT NULL,
    location TEXT,
    industry TEXT,
    total_laid_off FLOAT,
    percentage_laid_off FLOAT,
    date DATE NOT NULL,
    stage TEXT,
    country TEXT NOT NULL,
    funds_raised FLOAT
);
 SELECT * FROM layoffs