####
## 04. 데이터 분석 캠프 week4
#### ► [01_window_function_01_221028 / 02_window_function_02_221028]
- 다양한 비즈니스 사례에 적용되는 윈도우 함수 이론 학습 및 실습
##
#### Window Function - Aggregate Function
``` SQL
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
     , ROUND(sales_sub_category / SUM(sales_sub_category) OVER (PARTITION BY category) * 100, 2) AS pct_in_category 
     , ROUND(sales_sub_category / SUM(sales_sub_category) OVER () * 100, 2) AS pct_in_total
FROM records
GROUP BY 1, 2
ORDER BY pct_in_total DESC;
```
|category|sub_category|sub_category_sales|sales_category|sales_total|pct_in_category|pct_in_total|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|Technology|Phones|105340.52|271730.82|733215.26|38.77|14.37|
- sales_category - category 파티션 내에서 sales_sub_category의 합계를 출력한 결과 
- sales_total - 별도의 파티션 없이, 전체 sales_sub_category의 합계를 출력한 결과 
##
#### Window Function - Rank Function
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
FROM records
WHERE Salary_rank <= 3;
```
|Department|Employee|Salary|
|:---:|:---:|:---:|
|IT|Max|90000|
|IT|Joe|85000|
|IT|Randy|85000|
|IT|Will|70000|
|Sales|Henry|80000|
|Sales|Sam|60000|
- Salary_rank - Department 파티션 내에서 salary가 높은 순으로 공동 순위를 건너뛰지 않고 3순위까지 출력한 결과
##
