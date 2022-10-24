-- 1-1. 응용 연습문제
# 2021년 10월 고객별 첫 주문과 마지막 주문 일자 출력하기
# customer_id / first_order_date_at / last_order_date_at 출력
SELECT customer_id
     , DATE_FORMAT(MIN(order_timestamp), '%Y-%m-%d') AS first_order_date_at
     , DATE_FORMAT(MAX(order_timestamp), '%Y-%m-%d') AS last_order_date_at
FROM orders
WHERE order_timestamp >= '2021-10-01'
  AND order_timestamp < '2021-11-01'
GROUP BY customer_id;

-- 1-2. 응용 연습문제
# 2021년 10월 주문 일자별 배송 예상일에 따른 성공 및 실패 케이스 수 출력하기
# order_date_at / success_case / fail_case 출력
# fail_case가 많은 순으로 정렬하여 출력
SELECT DATE_FORMAT(order_timestamp, '%Y-%m-%d') AS order_date_at
     , COUNT(CASE WHEN estimated_date <= delivered_date THEN order_id END) AS success_case
     , COUNT(CASE WHEN estimated_date > delivered_date THEN order_id END) AS fail_case
FROM orders
WHERE order_timestamp >= '2021-10-01'
  AND order_timestamp < '2021-11-01'
GROUP BY order_date_at 
ORDER BY fail_case DESC;

-- 2-1. WHERE절 서브쿼리 - 단일행 서브쿼리
# products에서 물품의 평균 price보다 높은 price의 product_name 출력하기
SELECT product_name
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 2-2. WHERE절 서브쿼리 - 다중행 서브쿼리
# products에서 category_id별 평균 물품 price가 30이상인 product_name 출력하기
SELECT product_name
FROM products 
WHERE category_id IN (SELECT category_id
                      FROM products
                      GROUP BY category_id
                      HAVING AVG(price) >= 30);

-- 2-3. WHERE절 서브쿼리 - 다중 컬럼 서브쿼리
# products에서 category_id별 price가 가장 낮은 물품의 전체 결제 내역을 출력하고, price가 높은 순으로 정렬하기
SELECT *
FROM products
WHERE (category_id, price) IN (SELECT category_id
                                    , MIN(price)
                               FROM products
                               GROUP BY category_id)
ORDER BY price DESC;
