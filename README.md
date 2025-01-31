# Introduction
📊 Unveiling Layoff Trends: This project dives into workforce reductions across industries, analyzing 🔍 top-impacted companies, 🌍 affected countries, and 📈 trends in layoffs based on industry, funding stages, and time. Explore patterns to understand the evolving dynamics of employment during turbulent times.


# Background
This project aims to explore the patterns and trends behind company layoffs across industries. By analyzing key metrics such as total layoffs, industry impact, funding stages, and temporal patterns, it seeks to provide insights that help understand employment dynamics during challenging periods.

### The questions I wanted to answer through my SQL queries were:

1. What are the top 10 companies by total layoffs?
2. What are the top 10 industries by total layoffs?
3. What is the trend of layoffs throughout the year?
4. What are the company performance outliers?


# Tools I Used
For my deep dive into layoff trends across industries, I leveraged several powerful tools to analyze and interpret key insights from the data.
- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query in this project was designed to explore specific aspects of layoff trends across industries. Here's how I approached each question to uncover key insights from the data:

### 1. top 10 companies by total layoffs

To identify companies with the highest layoffs, I filtered the dataset by total layoffs per company. This query highlights companies that had significantly higher layoffs than others.

```SQL
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
```

### Output:

| Company      | Employees Laid Off |
|--------------|--------------------|
| Amazon       | 27,840             |
| Meta         | 24,600             |
| Intel        | 16,057             |
| Microsoft    | 14,708             |
| Tesla        | 14,500             |
| Cisco        | 14,300             |
| Google       | 13,472             |
| Dell         | 12,650             |
| Salesforce   | 11,140             |
| SAP          | 11,000             |

Here's the breakdown of the top company layoffs in recent times:

- **Wide Layoff Range:** The top 10 companies saw layoffs ranging from 11,000 to 27,840 employees, highlighting significant workforce reductions.

- **Diverse Industries:** Companies like Amazon, Meta, and Intel span multiple sectors, showing that layoffs are not limited to a single industry.

- **Business Impact:** The layoffs affected both established tech giants and other industry leaders, reflecting a broad shift in the market landscape.


### 2. top 10 industries by total layoffs

To gain insights into the industries most impacted by workforce reductions, I analyzed layoff trends across different sectors. This analysis highlights the sectors facing the greatest challenges and helps identify broader market dynamics.

```SQL
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
```
### Output:

| Industry        | Total Layoffs |
|-----------------|---------------|
| Consumer        | 74,646        |
| Retail          | 72,819        |
| Other           | 62,132        |
| Transportation  | 60,568        |
| Hardware        | 54,870        |
| Finance         | 50,447        |
| Food            | 48,123        |
| Healthcare      | 38,561        |
| Travel          | 23,295        |
| Infrastructure  | 20,614        |

Breakdown of Industries Most Affected by Layoffs:

- Consumer leads the list with a significant number of layoffs.
- Retail and Telecommunications follow closely, indicating challenges beyond the tech sector.
- Finance and Manufacturing also see notable reductions, showcasing a widespread impact across different industries.

This analysis reveals the sectors facing the greatest disruptions during recent times.


### 3. Layoffs Trend Over Time

This query helped identify, what was the trend of layoffs throughout the year.


```SQL
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
```
### Monthly Layoff Trends:

| Month Number | Month | Total Layoffs |
|--------------|-------|---------------|
| 1            | Jan   | 136,744       |
| 2            | Feb   | 60,184        |
| 3            | Mar   | 60,755        |
| 4            | Apr   | 73,622        |
| 5            | May   | 64,927        |
| 6            | Jun   | 48,744        |
| 7            | Jul   | 43,171        |
| 8            | Aug   | 53,013        |
| 9            | Sep   | 15,299        |
| 10           | Oct   | 32,678        |
| 11           | Nov   | 70,729        |
| 12           | Dec   | 23,173        |


- **January Surge:** The highest number of layoffs occurred in January with 136,744 employees affected. This might indicate companies restructuring or downsizing early in the year.

- **Seasonal Dip in September:** September saw the least layoffs at 15,299, suggesting a possible stabilization in employment during this period.

- **Year-End Layoff Peaks:** November experienced a notable layoff count of 70,729, hinting at budget adjustments or strategic workforce realignments toward the year-end.

- **Gradual Decline Post-April:** Layoffs appear to trend downward after April, indicating possible hiring stabilization or reduced operational adjustments mid-year.

![](/images/output.png)


### 4. Company performance outliers

```sql
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
    SELECT 
        AVG(total_laid_off) 
    FROM 
        layoffs_staging2
)
ORDER BY
    total_laid_off DESC;
```
- **Significant Layoff Outliers:** Companies such as Google, Tesla, and Intel recorded the highest layoffs, indicating strategic downsizing or cost-cutting measures despite being industry leaders.
- **Tech Industry Under Pressure:** Many outlier companies belong to the technology sector, suggesting market shifts, technological disruptions, or a need for operational streamlining within this space.
- **Diverse Impact Across Sectors:** While tech giants dominate the layoff charts, companies in sectors like retail and consumer goods are also notable, hinting at broader economic challenges beyond just technology.
- **Global Strategy Adjustments:** The high layoffs at these companies may be indicative of global restructuring efforts, automation adoption, or strategic resource allocation changes to adapt to market demands.


# What I Learned
This journey into layoff analysis provided valuable lessons and sharpened my SQL abilities:

**🔍 Advanced Querying:** Mastered writing complex queries, efficiently using subqueries, and crafting WITH clauses for streamlined data manipulation.

**📊 Data Aggregation Expertise:** Gained proficiency in leveraging GROUP BY, SUM(), and AVG() to summarize and derive meaningful insights from large datasets.

**💡 Analytical Problem-Solving:** Enhanced my ability to turn business questions into actionable insights by designing thoughtful and data-driven SQL queries.

**📈 Trend Analysis:** Developed the skills to identify key trends, detect anomalies, and uncover outliers through data exploration and visualization techniques.

# Conclusions
### Insights
From the analysis, several key findings emerged:

**Top Companies by Layoffs:** Major players like Google, Tesla, and Intel reported the highest layoffs, with Amazon leading at 27,840 employees laid off.

**Industries Most Affected:** The consumer, retail, and transportation sectors faced the highest layoffs, signaling broad challenges across these industries.

**Layoff Trends:** January recorded the highest layoffs, suggesting companies often implement workforce reductions at the beginning of the year, while September saw the lowest layoffs, indicating relative stability.

**Performance Outliers:** Despite being industry leaders, several companies experienced disproportionately high layoffs, hinting at operational realignments or market pressures.
Year-End Layoff Peaks: Layoffs showed a slight resurgence in November, potentially driven by year-end cost adjustments and strategic planning.

### Closing Thoughts
This project provided valuable insights into industry trends and strengthened my SQL skills. Understanding layoff patterns helps in recognizing broader economic signals and market dynamics. The findings underscore the importance of continuous learning and strategic decision-making for both companies and professionals navigating uncertain market conditions.