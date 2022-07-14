-- DDL ���̺� ���� ���� ����

-- ���̺� ����
CREATE TABLE �׽�Ʈ (
        ���ڿ�    VARCHAR2(100),
        ����      NUMBER,
        ��¥      DATE DEFAULT SYSDATE
);

INSERT INTO �׽�Ʈ VALUES ('�ϳ�', 1, sysdate);
INSERT INTO �׽�Ʈ VALUES ('��', 2, sysdate);
INSERT INTO �׽�Ʈ VALUES ('��', 3, sysdate);
INSERT INTO �׽�Ʈ VALUES ('��', 4, sysdate);

select * from �׽�Ʈ;

-- ���̺� �����ϱ�
DROP TABLE TEST;
DROP TABLE �׽�Ʈ;


--����) product_id(number Ÿ��), product_name(varchar2 Ÿ��, 20�ڸ�), 
--     menu_date(date Ÿ��) ���� �ִ� sample_product �̸��� ���̺��� ������ ������.

CREATE TABLE sample_product (
        product_id      NUMBER,
        product_name    VARCHAR2(20),
        menu_date       DATE DEFAULT sysdate
);

select * from sample_product;
?

--����) ������ ���� ���̺��� ������ ������. DESCRIBE ���� ���̺��� �� �����Ǿ����� Ȯ���ϼ���.
DROP TABLE sample_product;?


-- ���� ���� �� ���� ��ġ
CREATE TABLE emp (
        eno       NUMBER(3), 
        emp_name  VARCHAR2(20),
        CONSTRAINT emp_eno_pk PRIMARY KEY(eno)
);

desc emp;
-- �������ǰ� �Բ� ���̺� ����
drop table emp CASCADE CONSTRAINT;


-- NOT NULL�� NULL�� ������, UNIQUE �ߺ� ��� ����
CREATE TABLE emp1 (
        eno       NUMBER(3) CONSTRAINT emp1_ename_pk PRIMARY KEY,
        emp_name  VARCHAR2(20) CONSTRAINT emp1_ename_nn NOT NULL,
        email     varchar2(30),
        CONSTRAINT emp1_email_uk UNIQUE (email)
);
desc emp1;
drop table emp CASCADE CONSTRAINT;

insert into emp1 values (100,'�浿','kill@naver.com');
insert into emp1 values (101, '���','peng@naver.com');
select * from emp1;


-- check ��������
CREATE TABLE emp (
        eno       NUMBER(3),
        emp_name  VARCHAR2(20),
        sal       number(10),
        CONSTRAINT emp_sal_check check (sal>1000)
        -- sal ���� ������������ 1000���� ū������ ��.
);
insert into emp3 values (200, '�浿',1200);


DROP TABLE emp;

--���������� �̸� ���� ���̺� ���� ����
CREATE TABLE emp3(
    eno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(20) NOT NULL,
    password VARCHAR2(13) UNIQUE CHECK (LENGTH(password) >= 8),
    gender VARCHAR2(6) CHECK (gender IN ('����', '����'))
);

INSERT INTO emp3 VALUES (1000, 'Kim', '12345678', '����');
INSERT INTO emp3 VALUES (1010, 'Kang', '123456789', '����');

desc emp3;
select * from emp3;
drop table emp3 CASCADE CONSTRAINT;

--���� ) members ��� �� ���̺��� ����ϴ�. (�������� �̸��� ��������)
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


-- �⺻Ű �ܷ�Ű �����
-- ������ ���̺� �μ����̺� �����
create table dept(
    dno     NUMBER(4),
    dname   VARCHAR2(20),
    CONSTRAINT dept_dno_pk PRIMARY KEY(dno)
);
insert into dept values (1000,'���ߺ�');

-- �μ����̺� �μ���ȣ�� �����ϴ� �ܷ�Ű dno�� ������
-- �ܷ�Ű�� ������ �ؿ� �־���� ��!!!
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

INSERT INTO dept VALUES (10, '���ߺ�');
INSERT INTO dept VALUES (20, '������');
INSERT INTO dept VALUES (30, 'ȸ��');
INSERT INTO dept VALUES (40, '����');
INSERT INTO dept VALUES (50, '����');

SELECT * FROM dept;

INSERT INTO emp VALUES (1010, '�浿', 200, 10);  -- �μ���ȣ�� ���� �� Error�� ��
INSERT INTO emp VALUES (1020, '���', 180, 20);
INSERT INTO emp VALUES (1030, '����', 220, 30);
INSERT INTO emp VALUES (1040, '���', 250, 40);
INSERT INTO emp VALUES (1050, '����', 300, 50);

SELECT * FROM emp;

-- ���������� ��ȸ�ϴ� ���
-- ALL_CONSTRAINTS : �ڵ������� ������� �������Ǳ��� ����
SELECT *
FROM ALL_CONSTRAINTS
WHERE constraint_type='R' ;   --���̺� ���� �빮��!


-- ���� ���� �߰�
-- 1) �������̺� �����
--  ======================================================================
CREATE TABLE ���� 
(
  CNO VARCHAR2(2), 
  CNAME VARCHAR2(20) 
);

INSERT INTO ���� VALUES ('01','�����ͺ��̽�');
INSERT INTO ���� VALUES ('02','���α׷���');
INSERT INTO ���� VALUES ('03','�ڹ�');
select * from ����;

-- �л����̺� �����
CREATE TABLE �л�(
    sno VARCHAR2(4),
    sname VARCHAR2(50),
    cno VARCHAR2(2)
);
INSERT INTO �л� VALUES ('0414', 'ȫ�浿', '01');
INSERT INTO �л� VALUES ('0415', '�Ӳ���', '02');
INSERT INTO �л� VALUES ('0416', '�̼���', '03');
select * from �л�;
--  ======================================================================

-- ������ ���� �л�, ���� ���̺� ���������� �߰�����
-- �⺻Ű �߰�
alter table ����
add constraint class_cno_pk primary key (cno); -- �������̺� cno���� �⺻Ű�� �߰�
alter table �л�
add constraint student_sno_pk primary key (sno); -- �л����̺� sno���� �⺻Ű�� �߰�

-- ����ũ �߰�
ALTER TABLE ����
ADD CONSTRAINT class_cname_uk UNIQUE (cname);   -- �������̺� cname�� ����ũ �߰�
--NOT NULL �߰� (MODIFY)
ALTER TABLE �л�
MODIFY sname CONSTRAINT student_sname_nn NOT NULL;
-- �ܷ�Ű�� �л� ���̺� �߰�
ALTER TABLE �л�
ADD CONSTRAINT student_cno_fk Foreign key (cno) references ����(cno);

-- ���� ���� ����
alter table ����
drop primary key cascade; -- CASCADE : ������ ����Ǵ� ���������� ���� ����

alter table ����
drop unique(cname);

alter table �л�
drop primary key;

alter table �л�
drop constraint STUDENT_SNAME_NN;


DROP TABLE emp3;        -- ���̺� ��������

-- CREATE TABLE ���̺��̸� AS select��
-- select���� ����� ���� ���� ���̺� ����
CREATE TABLE EMP_TEMP
AS
SELECT * FROM employees
where 1 != 1;           -- �׻�����̹Ƿ� �������̺��� �������� ����Ǿ� �����
-- �ƹ��� �����͵� �Է��� �ȵǴ� ��� �� ������ ��

select * from EMP_TEMP;

-- ���ϴ� ���� �ุ �����ϱ�
CREATE TABLE EMP80
AS
SELECT employee_id ������ȣ, last_name �̸�, salary*12 ����, hire_date ������� 
FROM employees
where department_id = 80;

select * from EMP80;

-- ����) employees ���̺��� job_id �� 'ST_MAN' �� �������� �� ���̺� stmans �� ����� �Է��϶�. 
--      �� ���̺��� �÷� �̸���  id , job , sal ( ���� ���̺���  employee_id, job_id, salary)
create table stmans
as
select employee_id, job_id, salary
from employees
where job_id = 'ST_MAN';

select * from stmans;