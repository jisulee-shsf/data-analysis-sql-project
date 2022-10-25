-- 1-1. SELECT절 서브쿼리
# products에서 price가 category_id별 전체 매출액에서 차지하는 비율 출력하기 
# category_id / sales / price / price_pct 출력
# price_pct가 높은 순으로 정렬한 후, 상위 30개 값만 출력
select table1.category_id
     , table1.price
     , (select SUM(price) from products table2 where table1.category_id = table2.category_id) AS sales
     , table1.price * 100 / (select SUM(price) from products table2 where table1.category_id = table2.category_id) AS price_pct
from products table1
ORDER BY 3 DESC
LIMIT 30;

-- 1-2. SELECT절 서브쿼리
# products에서 price가 전체 매출액에서 차지하는 비율 출력하기 
# category_id / sales / price / price_pct 출력
# price_pct가 높은 순으로 정렬한 후, 상위 30개 값만 출력
select table1.category_id
     , table1.price
     , (select SUM(price) from products table2) AS sales
     , table1.price * 100 / (select SUM(price) from products table2) AS price_pct
from products table1
ORDER BY 3 DESC
LIMIT 30;