/* Weather Observation Station 11 -
A company's executives are interested in seeing who earns the most money in each of the company's departments. 
A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
Write an SQL query to find the employees who are high earners in each of the departments.
Return the result table in any order. */
# 기존 코드
SELECT D.name AS Department 
     , E.name AS Employee
     , E.salary AS Salary
FROM Department D
INNER JOIN Employee E ON D.id = E.departmentId
ORDER BY D.name, DENSE_RANK() OVER (ORDER BY E.Salary DESC);

/*
["Department", "Employee", "Salary"]
["IT", "Max", 90000]
["IT", "Joe", 85000]
["IT", "Randy", 85000]
["IT", "Will", 70000]
["IT", "Janet", 69000]
["Sales", "Henry", 80000]
["Sales", "Sam", 60000]
*/

# 수정 코드1 - WITH절 사용
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

# 수정 코드2 - Inline View SubQuery 사용
SELECT Department
     , Employee
     , Salary
FROM (
     SELECT D.name AS Department 
          , E.name AS Employee
          , E.salary AS Salary
          , DENSE_RANK() OVER (PARTITION BY D.name ORDER BY E.salary DESC) AS Salary_rank
     FROM Department D
     INNER JOIN Employee E ON D.id = E.departmentId) records
WHERE Salary_rank <= 3;

/*
["Department", "Employee", "Salary"]
["IT", "Max", 90000]
["IT", "Joe", 85000]
["IT", "Randy", 85000]
["IT", "Will", 70000]
["Sales", "Henry", 80000]
["Sales", "Sam", 60000]
*/
