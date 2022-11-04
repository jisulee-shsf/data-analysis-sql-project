-- 1-1. 주문 요약 테이블 추출하기 - 단일 WITH절 사용
WITH order_stats AS (
SELECT customer_id
     , MIN(order_date) AS first_order_date
     , MAX(order_date) AS last_order_date
     , COUNT(DISTINCT order_id) AS cnt_orders
     , ROUND(SUM(sales), 3) AS sum_sales
FROM records
GROUP BY 1
)

SELECT * FROM order_stats;

-- 1-2. 전처리 완료 테이블 추출하기 - 다중 WITH절 사용
WITH order_stats AS (
SELECT customer_id
     , MIN(order_date) AS first_order_date
     , MAX(order_date) AS last_order_date
     , COUNT(DISTINCT order_id) AS cnt_orders
     , ROUND(SUM(sales), 3) AS sum_sales
FROM records
GROUP BY 1
), records_preprocessed AS (
SELECT order_records.customer_id
     , order_records.order_id
     , DATE_FORMAT(order_records.order_date, '%Y-%m-01') AS order_month
     , DATE_FORMAT(order_stats.first_order_date, '%Y-%m-01') AS first_order_month
     , DATE_FORMAT(order_stats.last_order_date, '%Y-%m-01') AS last_order_month
FROM records order_records
INNER JOIN order_stats ON order_records.customer_id = order_stats.customer_id
)

SELECT * FROM order_stats;
SELECT * FROM records_preprocessed;

-- 2-1. 첫 구매한 달의 주문 고객 수 출력하기
SELECT first_order_month
     , COUNT(DISTINCT customer_id) AS month0
FROM records_preprocessed
GROUP BY 1;

-- 2-2. 첫 구매한 달 이후 다음달에 재주문한 고객 수 출력하기 - 단일 IF / 단일 CASE WHEN 구문 사용
SELECT first_order_month
     , COUNT(DISTINCT customer_id) AS month0
     , COUNT(DISTINCT IF(DATE_ADD(first_order_month, INTERVAL 1 month) = order_month, customer_id, NULL)) AS month1
FROM records_preprocessed
GROUP BY 1;

SELECT first_order_month
     , COUNT(DISTINCT customer_id) AS month0
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 1 month) = order_month THEN customer_id END) AS month1
FROM records_preprocessed
GROUP BY 1;

-- 3-1. 첫 구매한 달 이후 재주문 고객 수 출력하기 - 다중 CASE WHEN 구문 사용
SELECT first_order_month
     , COUNT(DISTINCT customer_id) AS month0
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 1 month) = order_month THEN customer_id END) AS month1
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 2 month) = order_month THEN customer_id END) AS month2
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 3 month) = order_month THEN customer_id END) AS month3
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 4 month) = order_month THEN customer_id END) AS month4
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 5 month) = order_month THEN customer_id END) AS month5
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 6 month) = order_month THEN customer_id END) AS month6
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 7 month) = order_month THEN customer_id END) AS month7
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 8 month) = order_month THEN customer_id END) AS month8
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 9 month) = order_month THEN customer_id END) AS month9
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 10 month) = order_month THEN customer_id END) AS month10
     , COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 11 month) = order_month THEN customer_id END) AS month11
FROM records_preprocessed
GROUP BY 1;

-- 3-2. 첫 구매한 달 이후 재주문 고객 비율 출력하기
SELECT first_order_month
     , FORMAT(COUNT(DISTINCT customer_id) * 100 / COUNT(DISTINCT customer_id), 2) AS month0
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 1 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month1
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 2 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month2
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 3 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month3
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 4 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month4
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 5 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month5
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 6 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month6
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 7 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month7
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 8 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month8
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 9 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month9
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 10 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month10
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 11 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month11
FROM records_preprocessed
GROUP BY 1;

-- 3-3. 최종 클래식 리텐션 출력하기
SELECT first_order_month
     , COUNT(DISTINCT customer_id) AS month0
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 1 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month1
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 2 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month2
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 3 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month3
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 4 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month4
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 5 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month5
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 6 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month6
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 7 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month7
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 8 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month8
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 9 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month9
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 10 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month10
     , FORMAT(COUNT(DISTINCT CASE WHEN DATE_ADD(first_order_month, INTERVAL 11 month) = order_month THEN customer_id END) * 100 / COUNT(DISTINCT customer_id), 2) AS month11
FROM records_preprocessed
GROUP BY 1;
