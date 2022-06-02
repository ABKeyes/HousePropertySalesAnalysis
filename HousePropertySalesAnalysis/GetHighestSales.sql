--This query is used to find the date in which the greatest number of houses were sold.
--It does this by 

Select TOP 1 
	datesold, COUNT(datesold) 
	from dbo.raw_sales 
	GROUP BY datesold 
	ORDER BY COUNT(datesold) DESC;