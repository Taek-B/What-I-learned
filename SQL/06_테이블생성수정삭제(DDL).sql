-- DDL 테이블 생성 수정 삭제

-- 테이블 생성
CREATE TABLE 테스트 (
        문자열    VARCHAR2(100),
        숫자      NUMBER,
        날짜      DATE DEFAULT SYSDATE
);

INSERT INTO 테스트 VALUES ('하나', 1, sysdate);
INSERT INTO 테스트 VALUES ('둘', 2, sysdate);
INSERT INTO 테스트 VALUES ('셋', 3, sysdate);
INSERT INTO 테스트 VALUES ('넷', 4, sysdate);

select * from 테스트;

-- 테이블 삭제하기
DROP TABLE TEST;
DROP TABLE 테스트;


--예제) product_id(number 타입), product_name(varchar2 타입, 20자리), 
--     menu_date(date 타입) 열이 있는 sample_product 이름의 테이블을 생성해 보세요.

CREATE TABLE sample_product (
        product_id      NUMBER,
        product_name    VARCHAR2(20),
        menu_date       DATE DEFAULT sysdate
);

select * from sample_product;
?

--예제) 위에서 만든 테이블을 삭제해 보세요. DESCRIBE 절로 테이블이 잘 삭제되었는지 확인하세요.
DROP TABLE sample_product;?


-- 제약 조건 열 옆에 위치
CREATE TABLE emp (
        eno       NUMBER(3), 
        emp_name  VARCHAR2(20),
        CONSTRAINT emp_eno_pk PRIMARY KEY(eno)
);

desc emp;
-- 제약조건과 함께 테이블 삭제
drop table emp CASCADE CONSTRAINT;


-- NOT NULL은 NULL값 허용안함, UNIQUE 중복 허용 안함
CREATE TABLE emp1 (
        eno       NUMBER(3) CONSTRAINT emp1_ename_pk PRIMARY KEY,
        emp_name  VARCHAR2(20) CONSTRAINT emp1_ename_nn NOT NULL,
        email     varchar2(30),
        CONSTRAINT emp1_email_uk UNIQUE (email)
);
desc emp1;
drop table emp CASCADE CONSTRAINT;

insert into emp1 values (100,'길동','kill@naver.com');
insert into emp1 values (101, '펭수','peng@naver.com');
select * from emp1;


-- check 제약조건
CREATE TABLE emp (
        eno       NUMBER(3),
        emp_name  VARCHAR2(20),
        sal       number(10),
        CONSTRAINT emp_sal_check check (sal>1000)
        -- sal 열의 제약조건으로 1000보다 큰수여야 함.
);
insert into emp3 values (200, '길동',1200);


DROP TABLE emp;

--제약조건의 이름 없이 테이블 생성 가능
CREATE TABLE emp3(
    eno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(20) NOT NULL,
    password VARCHAR2(13) UNIQUE CHECK (LENGTH(password) >= 8),
    gender VARCHAR2(6) CHECK (gender IN ('남성', '여성'))
);

INSERT INTO emp3 VALUES (1000, 'Kim', '12345678', '남성');
INSERT INTO emp3 VALUES (1010, 'Kang', '123456789', '여성');

desc emp3;
select * from emp3;
drop table emp3 CASCADE CONSTRAINT;

--예제 ) members 라는 새 테이블을 만듭니다. (제약조건 이름은 생략가능)
CREATE TABLE members (
        member_id       NUMBER(2) PRIMARY KEY,
        first_name      VARCHAR2(50) NOT NULL,
        last_name       VARCHAR2(50) NOT NULL,
        gender          VARCHAR2(5) CHECK(gender IN ('woman','man')),
        birth_day       DATE DEFAULT SYSDATE,
        email           VARCHAR2(200) UNIQUE NOT NULL
);
desc members;
SELECT * FROM members;
drop table members CASCADE CONSTRAINT;


-- 기본키 외래키 만들기
-- 참조할 테이블 부서테이블 만들기
create table dept(
    dno     NUMBER(4),
    dname   VARCHAR2(20),
    CONSTRAINT dept_dno_pk PRIMARY KEY(dno)
);
insert into dept values (1000,'개발부');

-- 부서테이블에 부서번호를 참조하는 외래키 dno를 만들자
-- 외래키는 무조건 밑에 넣어줘야 함!!!
drop table emp;
CREATE TABLE emp(
    eno       NUMBER(4) PRIMARY KEY,
    emp_name  VARCHAR2(20),
    sal       number(10),
    dno       NUMBER(4), 
    FOREIGN KEY (dno) REFERENCES dept (dno)
);

select * from dept;
delete from dept;

INSERT INTO dept VALUES (10, '개발부');
INSERT INTO dept VALUES (20, '영업부');
INSERT INTO dept VALUES (30, '회계');
INSERT INTO dept VALUES (40, '관리');
INSERT INTO dept VALUES (50, '안전');

SELECT * FROM dept;

INSERT INTO emp VALUES (1010, '길동', 200, 10);  -- 부서번호가 없을 시 Error가 뜸
INSERT INTO emp VALUES (1020, '길순', 180, 20);
INSERT INTO emp VALUES (1030, '길촌', 220, 30);
INSERT INTO emp VALUES (1040, '길수', 250, 40);
INSERT INTO emp VALUES (1050, '사장', 300, 50);

SELECT * FROM emp;

-- 제약조건을 조회하는 방법
-- ALL_CONSTRAINTS : 자동적으로 만들어진 제약조건까지 포함
SELECT *
FROM ALL_CONSTRAINTS
WHERE constraint_type='R' ;   --테이블 명은 대문자!


-- 제약 조건 추가
-- 1) 수업테이블 만들기
--  ======================================================================
CREATE TABLE 수업 
(
  CNO VARCHAR2(2), 
  CNAME VARCHAR2(20) 
);

INSERT INTO 수업 VALUES ('01','데이터베이스');
INSERT INTO 수업 VALUES ('02','프로그래밍');
INSERT INTO 수업 VALUES ('03','자바');
select * from 수업;

-- 학생테이블 만들기
CREATE TABLE 학생(
    sno VARCHAR2(4),
    sname VARCHAR2(50),
    cno VARCHAR2(2)
);
INSERT INTO 학생 VALUES ('0414', '홍길동', '01');
INSERT INTO 학생 VALUES ('0415', '임꺽정', '02');
INSERT INTO 학생 VALUES ('0416', '이순신', '03');
select * from 학생;
--  ======================================================================

-- 위에서 만든 학생, 수업 테이블에 제약조건을 추가하자
-- 기본키 추가
alter table 수업
add constraint class_cno_pk primary key (cno); -- 수업테이블에 cno열이 기본키로 추가
alter table 학생
add constraint student_sno_pk primary key (sno); -- 학생테이블에 sno열이 기본키로 추가

-- 유니크 추가
ALTER TABLE 수업
ADD CONSTRAINT class_cname_uk UNIQUE (cname);   -- 수업테이블에 cname에 유니크 추가
--NOT NULL 추가 (MODIFY)
ALTER TABLE 학생
MODIFY sname CONSTRAINT student_sname_nn NOT NULL;
-- 외래키를 학생 테이블에 추가
ALTER TABLE 학생
ADD CONSTRAINT student_cno_fk Foreign key (cno) references 수업(cno);

-- 제약 조건 삭제
alter table 수업
drop primary key cascade; -- CASCADE : 삭제시 관계되는 제약조건을 같이 삭제

alter table 수업
drop unique(cname);

alter table 학생
drop primary key;

alter table 학생
drop constraint STUDENT_SNAME_NN;


DROP TABLE emp3;        -- 테이블 삭제해줌

-- CREATE TABLE 테이블이름 AS select문
-- select문의 결과를 새로 만든 테이블에 저장
CREATE TABLE EMP_TEMP
AS
SELECT * FROM employees
where 1 != 1;           -- 항상거짓이므로 직원테이블의 열구조만 복사되어 저장됨
-- 아무런 데이터도 입력이 안되는 대신 열 구조만 들어감

select * from EMP_TEMP;

-- 원하는 열과 행만 복사하기
CREATE TABLE EMP80
AS
SELECT employee_id 직원번호, last_name 이름, salary*12 연봉, hire_date 고용일자 
FROM employees
where department_id = 80;

select * from EMP80;

-- 예제) employees 테이블의 job_id 가 'ST_MAN' 인 직원들을 새 테이블 stmans 를 만들어 입력하라. 
--      단 테이블의 컬럼 이름은  id , job , sal ( 직원 테이블의  employee_id, job_id, salary)
create table stmans
as
select employee_id, job_id, salary
from employees
where job_id = 'ST_MAN';

select * from stmans;