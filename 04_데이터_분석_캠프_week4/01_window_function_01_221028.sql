-- 카테고리별 매출이 전체 카테고리와 전체 매출에서 차지하는 비중 출력하기
# WITH절 사용
WITH records AS (
SELECT category
     , sub_category
     , ROUND(SUM(sales), 2) AS sales_sub_category
FROM records
GROUP BY 1, 2)

SELECT category
     , sub_category
     , sales_sub_category 
     , ROUND(SUM(sales_sub_category) OVER (PARTITION BY category), 2) AS sales_category
     , ROUND(SUM(sales_sub_category) OVER (), 2) AS sales_total
     , ROUND(sales_sub_category / SUM(sales_sub_category) OVER (PARTITION BY category), 2) AS pct_in_category 
     , ROUND(sales_sub_category / SUM(sales_sub_category) OVER (), 2) AS pct_in_total
FROM records
GROUP BY 1, 2
ORDER BY pct_in_total DESC;

# Inline View SubQuery 사용
SELECT category
     , sub_category
     , sales_sub_category 
     , ROUND(SUM(sales_sub_category) OVER (PARTITION BY category), 2) AS sales_category
     , ROUND(SUM(sales_sub_category) OVER (), 2) AS sales_total
     , ROUND(sales_sub_category / SUM(sales_sub_category) OVER (PARTITION BY category), 2) AS pct_in_category 
     , ROUND(sales_sub_category / SUM(sales_sub_category) OVER (), 2) AS pct_in_total
FROM (SELECT category
	       , sub_category
		   , ROUND(SUM(sales), 2) AS sales_sub_category
	  FROM records
	  GROUP BY 1, 2) records
GROUP BY 1, 2
ORDER BY pct_in_total DESC;