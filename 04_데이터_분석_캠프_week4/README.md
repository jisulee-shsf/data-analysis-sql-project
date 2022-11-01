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
|category|sub_category|sub_category_sales|category_sales|total_sales|pct_in_category|pct_in_total|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|Technology|Phones|105340.52|271730.82|733215.26|38.77|14.37|
- Technology 카테고리의 서브 카테고리인 Phones는 105340.52원의 매출로 카테고리 전체 매출인 271730.82원의 약 38%를 차지합니다.
- 또한, Phones는 전체 매출인 733215.26원의 약 14%를 차지해 전체 매출에 가장 큰 영향을 미치는 서브 카테고리 제품임을 확인할 수 있었습니다.
####
