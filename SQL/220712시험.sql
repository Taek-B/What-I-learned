-- 1
desc emp;

-- 2
select * from emp
where deptno=30 and job='SALESMAN';

-- 3
select * from emp
where sal between 2000 and 3000;

-- 4
create table EMP_TEMP
as
select * from emp
where 1 != 1;
select * from EMP_TEMP;

-- 5
insert into EMP_TEMP
values (9999, '홍길동', 'PRESIDENT', NULL, '01/01/01',500,1000,10);
select * from EMP_TEMP;

-- 6
create table DEPT_TEMP2
as
select * from dept;
select * from dept_temp2;

-- 7
update dept_temp2
set dname='DATABASE', loc='SEOUL'
where deptno=40;
select * from dept_temp2;

-- 8
delete from dept_temp2;
ROLLBACK;

-- 9
select * from emp
where ename = UPPER('smith');

-- 10
select * from emp
where LENGTH(ename) <= 4;

-- 11
select SUBSTR(job,0,3) from emp;

-- 12
select * from emp
where hiredate > '81/06/01';

-- 13
select empno 사원번호, 
       ename 사원이름, 
       sal 월급, 
       NVL(comm,0) 추가수당, 
       (sal*12 + NVL(comm,0))연봉
from emp;

-- 14
select count(DISTINCT job)
from emp;

-- 15
select ename 사원이름, dname 부서이름
from emp e
    join dept d
        on d.deptno = e.deptno
where sal >= 3000;

-- 16
select * 
from emp
where sal < (select sal
             from emp
             where ename='MARTIN');

-- 17             
-- 단일행
select * 
from emp
where sal > (select sal
             from emp
             where deptno=30);

-- 다중행       
select * 
from emp
where sal > all (select sal
                 from emp
                 where deptno=30);             

-- 18
select * 
from emp
    join salgrade
        on sal between losal and hisal
where grade = 3 and deptno = 30;

-- 19
create table EMP_DDL(
        EMPNO NUMBER(4),
        ENAME VARCHAR2(10),
        JOB VARCHAR2(9),
        MGR NUMBER(4),
        HIREDATE DATE,
        SAL NUMBER(7,2),
        COMM NUMBER(7,2),
        DEPTNO NUMBER(2)
);
DESC EMP_DDL;

-- 20
CREATE VIEW EMP_V3 (직원번호, 이름, 직업, 고용일자, 월급, 부서번호)
AS
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO
FROM EMP;
select * from EMP_V3;