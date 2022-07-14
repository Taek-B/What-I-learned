-- �� View

-- �ܼ��� �� �����
CREATE VIEW EMP_V1 (������ȣ, �̸�, ��, �̸���, �����, ����)
AS
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID
FROM EMPLOYEES;

select * from EMP_V1;

-- �信 ������ �Է½� �����δ� �並 ���鶧 ����� ���̺� �Է�
insert into EMP_V1
values (333, '���', '��','Peng',SYSDATE, 'IT_PROG');

select * from employees where employee_id = 333;

-- ������ �� �����
-- �׷��Լ��� ����� ��� DML(�Է�,����,����) �Ұ� �Ҽ�����
CREATE VIEW  �μ���_����_����
AS
SELECT DEPARTMENT_ID �μ���ȣ,
    COUNT(*) ������ ,
    MAX(SALARY) �ְ�޿�,
    MIN(SALARY) �����޿�,
    ROUND(AVG(salary)) ��ձ޿�
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

SELECT * FROM �μ���_����_����;

-- OR REPLACE�� �ٿ��ָ� ���̺� �������� ���̺� ��������
CREATE OR REPLACE VIEW  �μ���_����_����
AS
SELECT DEPARTMENT_ID �μ���ȣ,
    COUNT(*) ������ ,
    ROUND(AVG(salary)) ��ձ޿�
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

SELECT * FROM �μ���_����_����;


-- �б⸸ ������ ��
-- 90�� �μ� �������� �б� ���� ��
CREATE OR REPLACE VIEW  EMP90_read (������ȣ, �̸�, ��, �̸���, �����, ����)
AS
SELECT employee_id , first_name, last_name, email, hire_date, job_id
FROM EMPLOYEES
WHERE department_id = 90
WITH READ ONLY;

select * from EMP90_read;
-- DML �۾��� �ȵ�
delete from EMP90_read;                                                                 -- �б� �����̶� ������ ��
insert into EMP90_read VALUES (777, '��', '���', 'KIMHeng', '22/05/07', 'IT_PROG');     -- �б� �����̶� ������ ��


-- �ε���
-- �ε��� ��ȸ�ϱ�(�⺻Ű ���� �ڵ����� �ε����� ������)
select *
from ALL_IND_COLUMNS
WHERE table_name = 'MEMBERS';       --�빮��

-- �ε��� �ǽ��� ���̺� �����
DROP TABLE MEMBERS;     -- ���� ���̺� ����

CREATE TABLE members(
    member_id INT,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR2(255) NOT NULL,
    PRIMARY KEY(member_id)
);

-- last_name���� �˻�
select * from members
where last_name = 'Harse';

-- EXPLAIN PLAN FOR : ���� �����
EXPLAIN PLAN FOR
select * from members
where last_name = 'Harse';

-- SQL ���� ���� Ȯ��
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
    
-- �ε��� ����� (members ���̺��� last_name ���� �����)
create index members_last_name_i
ON members(last_name);

-- �ε��� �����ϱ�
DROP INDEX members_last_name_i;


--����) ���� ������� MEMBERS ���̺��� first_name�� last_name�� ��Ƽ �ε����� ����
--     �Ʒ��� �׸�ó���� �ε������� ��ȸ �� ������ ����� ����϶�

-- ��Ƽ �ε��� (��1, ��2, ...) ���� ���� ���� �ε��� �����
CREATE INDEX members_name_i
ON members(last_name, first_name);

select *
from ALL_IND_COLUMNS
WHERE table_name = 'MEMBERS';       -- INDEX ��ȸ

-- Ǯ �������� �˻�
EXPLAIN PLAN FOR
select * from members
where last_name like 'A%' AND first_name like 'M%';     -- ���� �����
-- SQL ���� ���� Ȯ��
SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());    -- ���� ��ȸ�ϱ�
    
    
-- ������ 
-- ������ �����
CREATE SEQUENCE ������1;    -- ������ ����
DROP SEQUENCE ������1;     -- ������ ����

-- ������ ���� Ȯ��
select * from USER_SEQUENCES
where SEQUENCE_NAME='������1';

-- ������ ���� ( .NEXTVAL, .CURRVAL )
SELECT ������1.NEXTVAL FROM DUAL;      -- ������ ���� 1�̹Ƿ� ������ ������ 1�� ������
SELECT ������1.CURRVAL FROM DUAL;      -- ���簪���

-- �������� �̿��ؼ� ������ id�� �Է��� ����
-- 100000���� �����ϰ� 10�� �����ϴ� ������2�� �����

-- ���� ���̺� ����
CREATE TABLE ���� (
    emp_id NUMBER(6) PRIMARY KEY,
    name VARCHAR2(50) NOT NULL
);

-- ������2 ����
CREATE SEQUENCE ������2
START WITH 100000
INCREMENT BY 10;

-- ������2�� �̿��Ͽ� ���� ���̺� �Է��ϱ�
INSERT INTO ���� VALUES(������2.NEXTVAL, '���');
INSERT INTO ���� VALUES(������2.NEXTVAL, '�浿');
INSERT INTO ���� VALUES(������2.NEXTVAL, '���');
INSERT INTO ���� VALUES(������2.NEXTVAL, '����');
INSERT INTO ���� VALUES(������2.NEXTVAL, '����');

select * from ����;       -- ���̺� ��ȸ

-- emp_id ������ȣ�� ������1�� ������Ʈ
update ����
set emp_id = ������1.nextval;      -- ������1 : 1���� �����Ͽ� 1�� �ö󰡰� ������ ������

-- �ο�� ROWNUM
-- ������ ���°������ ��� ��
SELECT ROWNUM, EMP.*        -- EMP.* : 12��
FROM EMP 
WHERE ROWNUM <= 10;         -- WHERE : 10��

-- �߰��� � �� 6~10�� (���������� ���� ������ RN���� �ű���� �ٱ��� main�������� RN�� �߰� ������ ���)
SELECT ROWNUM, EMP.*        
FROM EMP 
WHERE ROWNUM between 6 and 10;    -- �ȳ��� (�ݵ�� ROWNUM�� 1���� ���;��ϹǷ�)

SELECT E.*        
FROM (SELECT ROWNUM AS RN, EMP.* FROM EMP) E 
WHERE RN between 6 and 10;

-- �����ѵ� �����Űܼ� �߰���ȣ ����ϱ�
SELECT ROWNUM, EMP.*
FROM EMP
WHERE ROWNUM <= 5
ORDER BY sal DESC;

-- �������� ���� ������ ���� ��� TOP 5
select * from emp order by sal decs;    -- ���� ��

-- ���������� ������ ���� �ϰ� ROWNUM���� �����Ѵ�.
select rownum, A.*
from(
    select EMPNO, ENAME, SAL FROM EMP order by sal DESC
) A
WHERE ROWNUM <= 5;