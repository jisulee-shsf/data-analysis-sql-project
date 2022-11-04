# products에서 category_id별 price가 2021년 10월 매출액에서 차지하는 비율 출력하기 
# category_id / oct_sales / price / price_pct 출력
# price_pct가 높은 순으로 정렬한 후, 상위 30개 값만 출력

-- 1-1. FROM절 서브쿼리
SELECT table1.category_id
     , table1.oct_sales
     , table2.price
     , table2.price * 100 / table1.oct_sales AS price_pct
FROM (SELECT category_id
           , SUM(price) AS oct_sales
      FROM products
      WHERE order_timestamp >= '2021-10-01'
        AND order_timestamp < '2021-11-01'
      GROUP BY 1) AS table1
INNER JOIN products table2 ON table1.category_id = table2.category_id
ORDER BY 4 DESC
LIMIT 30;

-- 1-2. FROM절 서브쿼리 - WITH절 사용
WITH table1 AS (
SELECT category_id
     , SUM(price) AS oct_sales
FROM products
WHERE order_timestamp >= '2021-10-01'
  AND order_timestamp < '2021-11-01'
GROUP BY 1)

SELECT table1.category_id
     , table1.oct_sales
     , table2.price
     , table2.price * 100 / table1.oct_sales AS price_pct
FROM table1
INNER JOIN products table2 ON table1.category_id = table2.category_id
ORDER BY 4 DESC
LIMIT 30;
