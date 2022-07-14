-- 뷰 View

-- 단순한 뷰 만들기
CREATE VIEW EMP_V1 (직원번호, 이름, 성, 이메일, 고용일, 직종)
AS
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID
FROM EMPLOYEES;

select * from EMP_V1;

-- 뷰에 데이터 입력시 실제로는 뷰를 만들때 사용한 테이블에 입력
insert into EMP_V1
values (333, '펭수', '김','Peng',SYSDATE, 'IT_PROG');

select * from employees where employee_id = 333;

-- 복잡한 뷰 만들기
-- 그룹함수를 사용한 뷰는 DML(입력,수정,삭제) 불가 할수없음
CREATE VIEW  부서별_직원_보고서
AS
SELECT DEPARTMENT_ID 부서번호,
    COUNT(*) 직원수 ,
    MAX(SALARY) 최고급여,
    MIN(SALARY) 최저급여,
    ROUND(AVG(salary)) 평균급여
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

SELECT * FROM 부서별_직원_보고서;

-- OR REPLACE를 붙여주면 테이블 삭제없이 테이블 수정가능
CREATE OR REPLACE VIEW  부서별_직원_보고서
AS
SELECT DEPARTMENT_ID 부서번호,
    COUNT(*) 직원수 ,
    ROUND(AVG(salary)) 평균급여
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

SELECT * FROM 부서별_직원_보고서;


-- 읽기만 가능한 뷰
-- 90번 부서 직원들의 읽기 전용 뷰
CREATE OR REPLACE VIEW  EMP90_read (직원번호, 이름, 성, 이메일, 고용일, 직종)
AS
SELECT employee_id , first_name, last_name, email, hire_date, job_id
FROM EMPLOYEES
WHERE department_id = 90
WITH READ ONLY;

select * from EMP90_read;
-- DML 작업이 안됨
delete from EMP90_read;                                                                 -- 읽기 전용이라 오류가 뜸
insert into EMP90_read VALUES (777, '김', '행수', 'KIMHeng', '22/05/07', 'IT_PROG');     -- 읽기 전용이라 오류가 뜸


-- 인덱스
-- 인덱스 조회하기(기본키 열은 자동으로 인덱스가 생성됨)
select *
from ALL_IND_COLUMNS
WHERE table_name = 'MEMBERS';       --대문자

-- 인덱스 실습용 테이블 만들기
DROP TABLE MEMBERS;     -- 기존 테이블 삭제

CREATE TABLE members(
    member_id INT,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR2(255) NOT NULL,
    PRIMARY KEY(member_id)
);

-- last_name으로 검색
select * from members
where last_name = 'Harse';

-- EXPLAIN PLAN FOR : 보고서 만들기
EXPLAIN PLAN FOR
select * from members
where last_name = 'Harse';

-- SQL 실행 보고서 확인
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
    
-- 인덱스 만들기 (members 테이블의 last_name 열에 만들기)
create index members_last_name_i
ON members(last_name);

-- 인덱스 삭제하기
DROP INDEX members_last_name_i;


--예제) 위의 문법대로 MEMBERS 테이블의 first_name과 last_name의 멀티 인덱스를 만들어서
--     아래의 그림처럼의 인덱스들의 조회 및 성능평가 결과를 출력하라

-- 멀티 인덱스 (열1, 열2, ...) 여러 열을 같이 인데스 만들기
CREATE INDEX members_name_i
ON members(last_name, first_name);

select *
from ALL_IND_COLUMNS
WHERE table_name = 'MEMBERS';       -- INDEX 조회

-- 풀 네임으로 검색
EXPLAIN PLAN FOR
select * from members
where last_name like 'A%' AND first_name like 'M%';     -- 보고서 만들기
-- SQL 실행 보고서 확인
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());    -- 보고서 조회하기
    
    
-- 시퀀스 
-- 시퀀스 만들기
CREATE SEQUENCE 시퀀스1;    -- 시퀀스 생성
DROP SEQUENCE 시퀀스1;     -- 시퀀스 삭제

-- 시퀀스 정보 확인
select * from USER_SEQUENCES
where SEQUENCE_NAME='시퀀스1';

-- 시퀀스 사용법 ( .NEXTVAL, .CURRVAL )
SELECT 시퀀스1.NEXTVAL FROM DUAL;      -- 시퀀스 값이 1이므로 실행할 때마다 1씩 증가함
SELECT 시퀀스1.CURRVAL FROM DUAL;      -- 현재값출력

-- 시퀀스를 이용해서 직원의 id를 입력해 보자
-- 100000부터 시작하고 10씩 증가하는 시퀀스2를 만들기

-- 직원 테이블 생성
CREATE TABLE 직원 (
    emp_id NUMBER(6) PRIMARY KEY,
    name VARCHAR2(50) NOT NULL
);

-- 시퀀스2 생성
CREATE SEQUENCE 시퀀스2
START WITH 100000
INCREMENT BY 10;

-- 시퀀스2를 이용하여 직원 테이블에 입력하기
INSERT INTO 직원 VALUES(시퀀스2.NEXTVAL, '펭수');
INSERT INTO 직원 VALUES(시퀀스2.NEXTVAL, '길동');
INSERT INTO 직원 VALUES(시퀀스2.NEXTVAL, '길수');
INSERT INTO 직원 VALUES(시퀀스2.NEXTVAL, '펭헌');
INSERT INTO 직원 VALUES(시퀀스2.NEXTVAL, '펭펭');

select * from 직원;       -- 테이블 조회

-- emp_id 직원번호를 시퀀스1로 업데이트
update 직원
set emp_id = 시퀀스1.nextval;      -- 시퀀스1 : 1부터 시작하여 1씩 올라가게 생성한 시퀀스

-- 로우넘 ROWNUM
-- 위에서 몇번째까지만 출력 시
SELECT ROWNUM, EMP.*        -- EMP.* : 12행
FROM EMP 
WHERE ROWNUM <= 10;         -- WHERE : 10행

-- 중간에 몇개 행 6~10번 (서브쿼리로 먼저 순서를 RN으로 매긴다음 바깥의 main쿼리에서 RN의 중간 값들을 출력)
SELECT ROWNUM, EMP.*        
FROM EMP 
WHERE ROWNUM between 6 and 10;    -- 안나옴 (반드시 ROWNUM은 1부터 나와야하므로)

SELECT E.*        
FROM (SELECT ROWNUM AS RN, EMP.* FROM EMP) E 
WHERE RN between 6 and 10;

-- 정렬한뒤 순서매겨서 중간번호 출력하기
SELECT ROWNUM, EMP.*
FROM EMP
WHERE ROWNUM <= 5
ORDER BY sal DESC;

-- 직원들중 가장 월급이 많은 사람 TOP 5
select * from emp order by sal decs;    -- 오류 뜸

-- 서브쿼리에 정렬을 먼저 하고 ROWNUM으로 제한한다.
select rownum, A.*
from(
    select EMPNO, ENAME, SAL FROM EMP order by sal DESC
) A
WHERE ROWNUM <= 5;