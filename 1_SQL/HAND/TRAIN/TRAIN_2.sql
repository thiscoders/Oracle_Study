--汉得第一天练习
--1.根据数据字典，查询当前用户下有哪些表
SELECT * FROM USER_TABLES;

--2.查询所有员工编号，员工姓名、邮件、雇佣日期、部门、部门详细地址信息
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT EMP.EMPLOYEE_ID,
       EMP.FIRST_NAME || ' ' || EMP.LAST_NAME AS FULL_NAME,
       EMP.EMAIL,
       EMP.HIRE_DATE,
       DEP.DEPARTMENT_NAME,
       LOC.STREET_ADDRESS,
       LOC.CITY
  FROM EMPLOYEES EMP, DEPARTMENTS DEP, LOCATIONS LOC
 WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
   AND DEP.LOCATION_ID = LOC.LOCATION_ID;

--3.查询2003年入职员工员工编号，员工姓名，雇佣日期，工龄(保留2位小数)、按照First_Name升序排列
SELECT EMPLOYEE_ID,
       FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
       HIRE_DATE,
       ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12, 2) AS 工龄
  FROM EMPLOYEES
 ORDER BY FIRST_NAME;

--4.显示姓、薪水，佣金（commission） ，然后按薪水降序排列
SELECT FIRST_NAME, SALARY, COMMISSION_PCT
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL
 ORDER BY SALARY DESC;

--5.显示姓名、薪水，佣金（commission），佣金为空的，统一加上0.05;其余的加上0.03，按照薪资降序、变更后佣金升序排列
SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
       SALARY,
       COMMISSION_PCT,
       DECODE(COMMISSION_PCT, NULL, 0.05, COMMISSION_PCT + 0.03) AS NEWSA
  FROM EMPLOYEES
 ORDER BY SALARY DESC, NEWSA;

--6.显示名字以J、K、L、M开头的雇员
SELECT *
  FROM EMPLOYEES
 WHERE LOWER(SUBSTR(FIRST_NAME, 1, 1)) = 'j'
    OR LOWER(SUBSTR(FIRST_NAME, 1, 1)) = 'k'
    OR LOWER(SUBSTR(FIRST_NAME, 1, 1)) = 'l'
    OR LOWER(SUBSTR(FIRST_NAME, 1, 1)) = 'm';

--7.显示员工姓名，薪水，调整后薪水(按部门调整：IT提升30%,Salse 提升50%、其余部门提升20%)；按照调整后薪水升序排列
SELECT EMP.EMPLOYEE_ID,
       EMP.FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
       EMP.SALARY,
       DECODE(LOWER(DEP.DEPARTMENT_NAME),
              'it',
              EMP.SALARY * 1.3,
              'salse',
              EMP.SALARY * 0.5,
              EMP.SALARY * 1.2) AS NEWSAL
  FROM EMPLOYEES EMP, DEPARTMENTS DEP
 WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
 ORDER BY NEWSAL;

--8.显示各个部门名称，平均工资、最高工资、最低工资、部门人数
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
SELECT EMP.DEPARTMENT_ID,
       DEP.DEPARTMENT_ID,
       SUM(SALARY),
       AVG(SALARY),
       MAX(SALARY),
       MIN(SALARY),
       COUNT(EMP.EMPLOYEE_ID) AS 人数
  FROM EMPLOYEES EMP, DEPARTMENTS DEP
 GROUP BY EMP.DEPARTMENT_ID
HAVING EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID;

--9.显示在每月中旬雇佣的员工,显示姓名，雇佣日期
SELECT EMPLOYEE_ID AS EMP_ID,
       FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
       HIRE_DATE AS HIRE
  FROM EMPLOYEES
 WHERE TO_NUMBER(TO_CHAR(HIRE_DATE, 'dd')) BETWEEN 11 AND 20;
