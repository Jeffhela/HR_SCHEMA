

/* (1) Joining */

/* NB: To execute a join of three or more tables, we'll join two of the tables based on the join conditions */
/* comparing their columns and then joins the result to another table based on join conditions containing columns of */
/* the joined tables and the new table. */
/* We'll also return some or all of those rows from one table for which no rows from the other satisfy the join condition. */

SELECT e1.employee_id, e1.manager_id, e2.employee_id
   FROM employees e1, employees e2
   WHERE e1.manager_id(+) = e2.employee_id
   ORDER BY e1.employee_id, e1.manager_id, e2.employee_id;

/* Develop a query that lists the name of the employee, the department code
and the starting date that began to work, ordering the result by department and
by start date, the last one that entered to work goes first*/

SELECT FIRST_NAME, DEPARTMENT_ID,HIRE_DATE
FROM employees
ORDER BY DEPARTMENT_ID ASC, HIRE_DATE desc;

/* Develop a query that lists the code, first and last name of the employees and their
respective bosses with title Employee and Boss: */

select employee.EMPLOYEE_ID as CODE, (employee.FIRST_NAME || ' '  || employee.LAST_NAME) as EMPLOYEE, (boss.FIRST_NAME || ' '  || boss.LAST_NAME) as BOSS
from employees EMPLOYEE, employees BOSS
where employee.MANAGER_ID = boss.EMPLOYEE_ID
order by employee.EMPLOYEE_ID;

/* Develop a query that lists the countries by region, the data that should show
are: the code of the region and the name of the region with the name of their countries
*/

select r.REGION_ID, r.REGION_NAME, c.COUNTRY_NAME
from regions r, countries c
where r.REGION_ID = c.REGION_ID

/* Make a query that shows the code, name, last name, start and end of the history of employee work. */

select e.employee_id as CODE, (e.first_name || ' ' || e.last_name) as NAME, j.start_date, j.end_date
from employees e, job_history j
where e.employee_id = j.employee_id

/* (2) Aggregating */

/* NB: Aggregate functions return a single result row based on groups of rows, */
/* rather than on single rows. Aggregate functions can appear in select lists and */
/* in ORDER BY and HAVING clauses. They are commonly used with the GROUP BY clause */
/* in a SELECT statement, where Oracle Database divides the rows of a queried table or */ 
/* view into groups. In a query containing a GROUP BY clause, the elements of the select */
/* list can be aggregate functions, GROUP BY expressions, constants, or expressions involving */
/* one of these. Oracle applies the aggregate functions to each group of rows and returns a */
/* single result row for each group. */

/* Display Disticnt department_id and salary values in the employee table */

SELECT DISTINCNT department_id, salary
FROM employees

/* We can also test aggregate functions by calculating the average of the maximum salaries of all */
/* the departments in the schema HR */

SELECT AVG(MAX(salary))
  FROM employees
  GROUP BY department_id;

/* (3) Subqueries */
/* A subquery answers multiple-part questions. For example, to determine who works in Taylor's department, */
/* you can first use a subquery to determine the department in which Taylor works. You can then answer the */
/* original question with the parent SELECT statement. */

/* In this example, we'll develop a query that lists the last name, the firts name and the salary */
/* of the employee with the highest salary of all departments. */

SELECT d.department_name AS DEPARTMENT,
  (e.first_name || ' ' ||e.last_name) AS NAME,
  e.salary       AS SALARY
FROM employees e,
  departments d
WHERE salary= (SELECT MAX(salary) FROM employees)
AND e.DEPARTMENT_ID = d.DEPARTMENT_ID;

/* Next, we'll develope a query that shows the department name, the last and first name of employees of only the 
departments where there are employees with name 'Jonh'. */

SELECT d.DEPARTMENT_NAME,
  (e.first_name || ' ' ||e.last_name) AS NAME
FROM employees e,
  departments d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
AND e.EMPLOYEE_ID    IN (SELECT EMPLOYEE_ID FROM employees WHERE FIRST_NAME = 'John');

/* Develop a query that lists the department code, name, surname and salary of employees with the highest salary in each department.

SELECT d.DEPARTMENT_NAME as DEPARTMENT,
  (e.first_name || ' ' ||e.last_name) AS NAME,
  e.SALARY       AS SALARY
FROM employees e,
  departments d
WHERE salary =
  (SELECT MAX(salary) FROM employees e2 WHERE e.DEPARTMENT_ID = e2.DEPARTMENT_ID)
AND e.department_id = d.department_id
ORDER BY 3 DESC;

/* (4) Functions */

/* The following example (SYS_CONNECT_BY_PATH) returns the path of employee names from employee Kochhar to all employees of Kochhar (and their employees): */

SELECT LPAD(' ', 2*level-1)||SYS_CONNECT_BY_PATH(last_name, '/') "Path"
   FROM employees
   START WITH last_name = 'Kochhar'
   CONNECT BY PRIOR employee_id = manager_id;

/* (b) Numeric function */
/* Numeric functions accept numeric input and return numeric values. */
/* The following example returns the absolute value of -15: */

SELECT ABS(-15) "Absolute"
  FROM DUAL;

/* (c) Character function */
/* The following example is run on an ASCII-based machine with the database character set defined as WE8ISO8859P1: */

SELECT CHR(67)||CHR(65)||CHR(84) "Dog"
  FROM DUAL;
/* the result under th column "Dog" is CT"


/* (5) Date format manipulation */
/* The following statement uses a date format model to return a character expression: */

SELECT TO_CHAR(SYSDATE, 'fmDDTH')||' of '||TO_CHAR
   (SYSDATE, 'fmMonth')||', '||TO_CHAR(SYSDATE, 'YYYY') "Ides" 
    FROM DUAL;

/* If FM is omitted, then the month is blank-padded to nine characters: */

SELECT TO_CHAR(SYSDATE, 'DDTH')||' of '||
   TO_CHAR(SYSDATE, 'Month')||', '||
   TO_CHAR(SYSDATE, 'YYYY') "Ides"
   FROM DUAL; 



/* In writing this SQL script, describe how you made sure the data was clean and accurate. */
/* Include at least the following concepts: */

/* (1) Deduplication */
/* (2) Accounting for null values (if null values are expected, explain why) */
/* (3) Ensuring no data that was needed was lost in joins or filtering */
/* (4) Ensuring no unreasonable values appear in the data */

/* Write helpful comments in your SQL code so someone else could read it and understand what you */
/* are doing and why */

