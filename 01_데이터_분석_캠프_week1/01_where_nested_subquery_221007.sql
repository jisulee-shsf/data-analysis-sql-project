-- 1-1. 연습 문제 응용
-- timestamp의 MIN / MAX 함수를 통해 첫 일자와 마지막 일자 확인 가능
# 2021년 10월 고객별 첫 주문과 마지막 주문 일자 출력하기
SELECT DATE_FORMAT(MIN(order_timestamp), '%Y-%m-%d') AS first_order_date_at
     , DATE_FORMAT(MAX(order_timestamp), '%Y-%m-%d') AS last_order_date_at
WHERE order_timestamp >= '2021-10-01'
  AND order_timestamp < '2021-11-01'
 FROM orders;

-- 1-2. 연습 문제 응용
-- 복수의 조건을 생성하는 CASE 문에서 ELSE 구문 생략 가능
-- COUNT 함수에 CASE 문 조건을 포함 조건이 성립될 경우 카운팅하여 출력 가능
# 2021년 10월 주문 일자별 배송 예상일에 따른 성공 및 실패 케이스 수 출력하기
SELECT DATE_FORMAT(order_timestamp, '%Y-%m-%d') AS order_date_at
     , COUNT(CASE WHEN estimated_date <= delivered_date THEN order_id END) AS success_case
     , COUNT(CASE WHEN estimated_date > delivered_date THEN order_id END) AS fail_case
FROM orders
WHERE order_timestamp >= '2021-10-01'
  AND order_timestamp < '2021-11-01'
GROUP BY order_date_at 
ORDER BY fail_case DESC 

-- 2-1. WHERE절 서브쿼리 - 단일행 서브쿼리
-- 비교 연산자를 사용해, 서브쿼리의 결괏값이 1개의 값인 쿼리문 작성
# products에서 물품의 평균 비용보다 더 높은 물품명 출력하기
SELECT product_name
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 2-2. WHERE절 서브쿼리 - 다중행 서브쿼리
-- 주요 연산자를 사용해, 서브쿼리의 결괏값이 다수의 값을 가진 1개의 컬럼인 쿼리문 작성
# products에서 category_id별 평균 물품 비용이 30이상인 물품명 출력하기
SELECT product_name
FROM products 
WHERE category_id IN (SELECT category_id
                      FROM products
                      GROUP BY category_id
                      HAVING AVG(price) >= 30);

-- 2-3. WHERE절 서브쿼리 - 다중컬럼 서브쿼리
# products에서 category_id별 가장 높은 물품 비용의 결재 내역을 출력하고, 비용이 높은 순으로 정렬하기
-- 주요 연산자를 사용해, 서브쿼리의 결괏값이 다수의 값을 가진 n개의 컬럼인 쿼리문 작성
SELECT *
FROM products
WHERE (category_id, price) IN (SELECT category_id
                                    , MAX(price)
                               FROM products
                               GROUP BY category_id)
ORDER BY price DESC;