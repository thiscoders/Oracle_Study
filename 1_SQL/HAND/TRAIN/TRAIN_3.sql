--1.显示部门编号、部门名字、该部门的员工数、每个部门的平均工资，
--  部门内的员工信息，包括姓名、薪水、职业；平均工资保留2位小数，千分位分隔符显示；结果按部门升序
SELECT DEPARTMENT_ID AS SDEP_ID,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID = EMP.DEPARTMENT_ID) AS SDEP_NAME,
       COUNT(EMP.EMPLOYEE_ID) AS SEMPS,
       AVG(EMP.SALARY) AS SAVG_SAL
  FROM EMPLOYEES EMP
 GROUP BY DEPARTMENT_ID;

--2.显示员工数最多的部门信息，显示部门ID、名称、部门员工数，部门的主管经理姓名
--a.显示各个部门的员工人数
SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY COUNT(EMPLOYEE_ID) DESC;
--b.获取员工最多的部门的人数
SELECT MAX(COUNT(EMPLOYEE_ID)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
--c.获取员工人数最多的部门id
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID) = (SELECT MAX(COUNT(EMPLOYEE_ID))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID);
--e.获取详细信息, it's ok!
SELECT EMP.DEPARTMENT_ID,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID = EMP.DEPARTMENT_ID) AS DEPARTMENT_NAME,
       COUNT(EMP.EMPLOYEE_ID) AS EMPLOYEES,
       (SELECT FIRST_NAME || ' ' || LAST_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID =
               (SELECT MANAGER_ID
                  FROM DEPARTMENTS
                 WHERE DEPARTMENT_ID = EMP.DEPARTMENT_ID)) AS MANAGER_NAME
  FROM EMPLOYEES EMP
 GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID) = (SELECT MAX(COUNT(EMPLOYEE_ID))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID);

--3.显示工号、姓名、薪水、部门编号、薪资，薪资与部门平均工资的差异情况；按照部门ID排序
--a.计算各个部门的平均薪资
SELECT DEPARTMENT_ID, AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID = 100;
--b.计算差异并且显示, it's ok!
SELECT EMP.EMPLOYEE_ID,
       EMP.LAST_NAME,
       EMP.DEPARTMENT_ID,
       EMP.SALARY,
       ROUND(EMP.SALARY -
             (SELECT AVG(SALARY)
                FROM EMPLOYEES
               GROUP BY DEPARTMENT_ID
              HAVING DEPARTMENT_ID = EMP.DEPARTMENT_ID),
             2) AS SALARY_GAP
  FROM EMPLOYEES EMP
 ORDER BY DEPARTMENT_ID;

--4.周几录取的人数最少，显示人名和日期
SELECT COUNT(DECODE(TO_CHAR(HIRE_DATE, 'day'), '星期一', 1, NULL))
  FROM EMPLOYEES;
--a.按照星期分组
SELECT TO_CHAR(HIRE_DATE, 'day'), COUNT(*)
  FROM EMPLOYEES
 GROUP BY TO_CHAR(HIRE_DATE, 'day');
--b.获取录取人数最少的人数
SELECT MIN(COUNT(*)) FROM EMPLOYEES GROUP BY TO_CHAR(HIRE_DATE, 'day');
--c.按照最少人数获取星期
--d.获取详细信息
SELECT EMP.EMPLOYEE_ID,
       EMP.FIRST_NAME,
       EMP.LAST_NAME,
       TO_CHAR(EMP.HIRE_DATE, 'day')
  FROM EMPLOYEES EMP
 WHERE TO_CHAR(HIRE_DATE, 'day') =
       (SELECT TO_CHAR(HIRE_DATE, 'day')
          FROM EMPLOYEES
         GROUP BY TO_CHAR(HIRE_DATE, 'day')
        HAVING COUNT(*) = (SELECT MIN(COUNT(*))
                            FROM EMPLOYEES
                           GROUP BY TO_CHAR(HIRE_DATE, 'day')));
                           
                           
--xk的练习
SELECT E.EMPLOYEE_ID, E.LAST_NAME
  FROM EMPLOYEES E,
	   (SELECT D.C, D.HIRE hire_d
		  FROM (SELECT COUNT(EMPLOYEE_ID) C, TO_CHAR(E.HIRE_DATE, 'day') HIRE
				  FROM EMPLOYEES E
				 GROUP BY TO_CHAR(E.HIRE_DATE, 'day')
				 ORDER BY C) D
		 WHERE ROWNUM < = 1) N
 WHERE TO_CHAR(E.HIRE_DATE, 'day') = N.HIRE_d;
 
                           
                           
                           
