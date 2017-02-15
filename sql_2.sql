-- http://www.java2s.com/Code/Oracle/Analytical-Functions/DENSERANKrankitemsleavesnogapswhenthereisatie.htm
-- https://www.quora.com/Which-SQL-interview-questions-effectively-test-depth-of-experience-and-knowledge
-- http://www.bullraider.com/database/sql-tutorial/7-complex-queries-in-sql
/*
				Not Platform Specific Questions
Give examples of when you last used analytic functions and why
Give examples of when you last used recursive queries and why
How do you use SQL to check for data quality?
How do you know that your SQL performs well?
How do you measure your SQL performance?
When your SQL does not perform well what do you think about and what do you do to improve performance?
How do you feel about joins in your SQL
How often do you use sub queries
When do you think your SQL has too many lines of code?
What kinds of data models have you written SQL against
How much does your SQL change across different data models
*/
-- Find ORACLE version
SELECT * FROM V$VERSION; --it is synonym it selects data from "SYS"."V_$VERSION" 
SELECT version FROM V$INSTANCE; -- only version

-- SQL Query to find second highest salary of Employee
select MAX(Salary) from Employee WHERE Salary NOT IN (select MAX(Salary) from Employee);
-- SQL Query to find Max Salary from each department.
SELECT DeptID, MAX(Salary) FROM Employee  GROUP BY DeptID;
SELECT DeptName, MAX(Salary) FROM Employee e RIGHT JOIN Department d ON e.DeptId = d.DeptID GROUP BY DeptName; -- prints dept name
--To fetch ALTERNATE records from a table. (EVEN NUMBERED)
select * from emp where rowid in (select decode(mod(rownum,2),0,rowid, null) from emp);
--To select ALTERNATE records from a table. (ODD NUMBERED)
select * from emp where rowid in (select decode(mod(rownum,2),0,null ,rowid) from emp);
--Find the 3rd MAX salary in the emp table.
select distinct sal from emp e1 where 3 = (select count(distinct sal) from emp e2 where e1.sal <= e2.sal);
--Find the 3rd MIN salary in the emp table.
select distinct sal from emp e1 where 3 = (select count(distinct sal) from emp e2where e1.sal >= e2.sal);
--Select FIRST n records from a table
select * from emp where rownum <= &n;
--Select LAST n records from a table
select * from emp minus select * from emp where rownum <= (select count(*) - &n from emp);
--List dept no., Dept name for all the departments in which there are no employees in the department.
select * from dept where deptno not in (select deptno from emp);  
alternate solution:  select * from dept a where not exists (select * from emp b where a.deptno = b.deptno);
altertnate solution:  select empno,ename,b.deptno,dname from emp a, dept b where a.deptno(+) = b.deptno and empno is null;
--Select DISTINCT RECORDS from emp table
SELECT * FROM emp1 a WHERE rowid = (SELECT MAX(rowid) FROM EMP1 b WHERE a.id=b.id); -- DISTINCT RECORDS / DUPLICATES
--How to delete duplicate rows in a table
DELETE FROM emp1 a WHERE rowid != (SELECT MAX(rowid) FROM EMP1 b WHERE a.id=b.id); -- DELETE DUPLICATES

-- Find first day of quarter from current date in ORACLE
select 
  QUARTER
  ,add_months( FIRST_DATE, (QUARTER-1)*3 ) first_day_of_quarter
  ,last_day(add_months( FIRST_DATE, (QUARTER-1)*3+2 )) last_day_of_quarter 
from (select to_date( '01-jan-2007', 'dd-mon-yyyy' ) as FIRST_DATE,
             to_char(sysdate, 'Q') as QUARTER 
             from dual)

--Table A has 100 rows, Table B has Zero rows so number of rows returned from  below query
select a.* from a, b; -- Answer 0 rows, if a table is empty cross join will be always 0 records

--CREATE TABLE WITH DATA & WITHOUT DATA
create table emp3 as select * from emp where 1=1; -- creates table structure + data
create table emp3 as select * from emp where 1=0; -- creates table structure with NO data

--EXPLAIN PLAN
explain plan SET statement_id = 'ex_plan1' FOR
SELECT * FROM emp1 a WHERE rowid = (SELECT max(rowid) FROM EMP1 b WHERE a.id=b.id)

explain plan 
SET statement_id = 'ex_plan2' FOR
select * from emp

SELECT PLAN_TABLE_OUTPUT 
  FROM TABLE(DBMS_XPLAN.DISPLAY(NULL, 'ex_plan2','BASIC'));
  
-- AGGREGATE , ANALYTIC, Getting ALL columns from AGGREGATE functions

	-- Aggregate using analytic function, it gets all the rows
	select empno, ename, job, sal, sum(sal) over(partition by job order by empno ) as SUM_SAL from emp;
	
	-- Aggregate using GROUP BY, it retrieves only columns used in GROUP BY and only last rows of grouped window retrieved
	select job, sum(sal) from emp group by job order by job;
	
	-- Get all columns and rows from GROUP BY, uses cross join and where clause on grouped column
	select emp.empno, emp.ename, emp.job, emp.mgr, emp.hiredate, emp.sal, emp.comm, emp.deptno, e.sum_sal, e.job grouped_on from emp,
	(select job, sum(sal) sum_sal from emp group by job) e where emp.job = e.job order by emp.job;




