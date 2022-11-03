####
## 04. 데이터 분석 캠프 week4
#### ► [01_window_function_sum_221028]
- 윈도우 함수 SUM을 통해, 전체 매출에 가장 큰 영향을 미치는 서브 카테고리를 확인하는 쿼리 작성 실습
- sales_category - category 파티션 내에서 sales_sub_category의 합계를 출력한 결과 
- sales_total - 별도의 파티션 없이, 전체 sales_sub_category의 합계를 출력한 결과 
``` SQL
WITH records AS (
SELECT category
     , sub_category
     , ROUND(SUM(sales), 2) AS sales_sub_category
FROM records
GROUP BY 1, 2
)

SELECT category
     , sub_category
     , sales_sub_category 
     , ROUND(SUM(sales_sub_category) OVER (PARTITION BY category), 2) AS sales_category
     , ROUND(SUM(sales_sub_category) OVER (), 2) AS sales_total
     , ROUND(sales_sub_category / SUM(sales_sub_category) OVER (PARTITION BY category) * 100, 2) AS pct_in_category
     , ROUND(sales_sub_category / SUM(sales_sub_category) OVER () * 100, 2) AS pct_in_total
FROM records
GROUP BY 1, 2
ORDER BY pct_in_total DESC;
```
|category|sub_category|sub_category_sales|sales_category|sales_total|pct_in_category|pct_in_total|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|Technology|Phones|105340.52|271730.82|733215.26|38.77|14.37|
##
#### ► [02_window_function_dense_rank_221028]
- 윈도우 함수 DENSE_RANK를 통해, 부서별 급여 순위가 높은 직원을 확인하는 쿼리 작성 실습
- Salary_rank - Department 파티션 내에서 salary가 높은 순으로 공동 순위를 건너뛰지 않고 3순위까지 출력한 결과
- https://leetcode.com/problems/department-highest-salary/
``` SQL
WITH records AS (
SELECT D.name AS Department 
     , E.name AS Employee
     , E.salary AS Salary
     , DENSE_RANK() OVER (PARTITION BY D.name ORDER BY E.salary DESC) AS Salary_rank
FROM Department D
INNER JOIN Employee E ON D.id = E.departmentId
)

SELECT Department
     , Employee
     , Salary
     , Salary_rank
FROM records
WHERE Salary_rank <= 3;
```
|Department|Employee|Salary|Salary_rank|
|:---:|:---:|:---:|:---:|
|IT|Max|90000|1|
|IT|Joe|85000|2|
|IT|Randy|85000|2|
|IT|Will|70000|3|
|Sales|Henry|80000|1|
|Sales|Sam|60000|2|
##
#### ► [03_window_function_session_lag_n_lead_221028]
- 윈도우 함수 LAG() & LEAD()를 통해, 세션을 정의하는 쿼리 작성 실습(PostgreSQL)
- https://mode.com/sql-tutorial/understanding-search-functionality/
- late_event - recordDate 데이터를 recordDate 순서에 맞춰 1칸씩 밀어 NULL 공란을 0으로 출력한 결과
- next_event - recordDate 데이터를 recordDate 순서에 맞춰 1칸씩 당겨 NULL 공란을 0으로 출력한 결과
- https://leetcode.com/problems/rising-temperature/
``` SQL
SELECT id
     , temperature
     , recordDate
     , LAG(recordDate, 1, 0) OVER (ORDER BY recordDate) AS late_event
     , LEAD(recordDate, 1, 0) OVER (ORDER BY recordDate) AS next_event
FROM Weather;
```
|id|temperature|recordDate|late_time|next_time|
|:---:|:---:|:---:|:---:|:---:|
|1|10|2015-01-01|0|2015-01-02|
|2|25|2015-01-02|2015-01-01|2015-01-03|
|3|20|2015-01-03|2015-01-02|2015-01-04|
|4|30|2015-01-04|2015-01-03|0|
