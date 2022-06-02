-- Get postcode with highest average sales
SELECT TOP 1 
	postcode, 
	AVG(price) as 'Average Price' 
	FROM 
	dbo.raw_sales 
	GROUP BY 
	postcode 
	ORDER BY AVG(price) DESC;

-- Get datecode with greatest number of average sales.
SELECT TOP 1 
	datesold, COUNT(datesold) AS 'Sales' 
	from dbo.raw_sales 
	GROUP BY datesold 
	ORDER BY COUNT(datesold) DESC;

--Get Year with lowest number of sales
SELECT TOP 1
	YEAR(datesold) AS Year, COUNT(YEAR(datesold)) as 'Sold'
	from dbo.raw_sales
	GROUP BY YEAR(datesold)
	ORDER BY 'Sold';

--Get 6 highest selling postal code for each year
SELECT * FROM (
	SELECT 
		Year, 
		postcode, 
		price_sum, 
		RANK() OVER (partition by Year ORDER BY price_sum desc) Rank
		FROM 
		(
		SELECT 
			YEAR(datesold) AS Year, 
			postcode, 
			sum(price) as price_sum
			FROM dbo.raw_sales
			GROUP BY YEAR(datesold), postcode
		) AS a ) 
	as b where Rank <= 6;