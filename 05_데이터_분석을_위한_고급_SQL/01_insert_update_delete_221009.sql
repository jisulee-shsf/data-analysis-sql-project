-- [Section 1] DML(Data Manipulation Language) - INSERT / UPDATE / DELETE

-- Q1-1. INSERT) 전체 컬럼 데이터 추가하기
INSERT INTO table_name 
VALUES (1, 'A', '2022-10-10');

-- Q1-2. INSERT) 특정 컬럼 데이터 추가하기
INSERT INTO table_name(column_name1, column_name2)
VALUES (1, 'A');

-- Q2-1. UPDATE) 전체 컬럼 데이터 수정하기
UPDATE table_name 
SET column_name = update_value;

-- Q2-2. UPDATE) 특정 컬럼 내에 조건 맞는 행 데이터 수정하기
UPDATE table_name 
SET column_name = update_value
WHERE specific_condition;

-- Q3-1. DELETE) 전체 테이블 데이터 삭제하기
DELETE FROM table_name;

-- Q3-2. DELETE) 테이블 내에 조건 맞는 행 데이터 삭제하기
DELETE FROM table_name
WHERE specific_condition;

-- [Section 2] LeetCode

-- Q. 627. Swap Salary)
/* Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) 
with a single update statement and no intermediate temporary tables.
Note that you must write a single update statement, do not write any select statement for this problem. */
-- A1-1. 기존 코드
SELECT *
UPDATE Salary 
set CASE
         WHEN sex = 'm' THEN  'f'
         WHEN sex = 'f' THEN  'm'
         ELSE NULL
         END;

-- A1-2. 기존 코드
UPDATE Salary 
SET sex = CASE
               WHEN sex = 'f' THEN 'm'
               ELSE sex = 'm' THEN 'f'
               END;

-- A2. 수정 코드
UPDATE Salary 
SET sex = CASE
               WHEN sex = 'f' THEN 'm'
               ELSE 'f'
               END;
