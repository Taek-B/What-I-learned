-- ������ ����(����Ŭ������)���� ���ο� ����� �����
CREATE USER john IDENTIFIED BY 1234;     -- ���ο� ����:john / ��й�ȣ:1234

-- john���� ���� ������ �ֱ� 
-- GRANT ���� TO ����;
GRANT CREATE SESSION TO john;

-- ���ѵ��� ���� : ROLE
-- ROLE(=CONNECT, RESOURCE, DBA) ���߿� CONNECT, RESOURCE�� �ű� �������� �ֱ�
GRANT CONNECT, RESOURCE TO john;

-- ���̺� ���� ����
GRANt CREATE TABLE TO john;
-- �� ���� ����
GRANt CREATE VIEW TO john;

GRANt CREATE VIEW TO scott;

-- ������ ȸ�� / ���ִ� ���
-- REVOKE ���Ѹ� FROM ����;

-- �� ���� ���� ȸ��
REVOKE CREATE VIEW FROM john;
-- ���̺� ���� ���� ȸ��
REVOKE CREATE TABLE FROM john;
-- ��ü ���� ���� ���� ���� ����
revoke resource from john;

-- ���� ����(���õ� ��� ���� ����)
DROP USER john CASCADE;     -- ���� ���� ������ �� ���� ����

-- ���� ��й�ȣ ����
-- ALTER USER ������ IDENTIFIED BY �����Һ�й�ȣ
ALTER USER john IDENTIFIED BY oracle;

-----------------------------------------------------------------------------

-- PL/SQL
-- �͸���

-- ����� ���� �ɼ�
SET SERVEROUTPUT ON;  

BEGIN
    DBMS_OUTPUT.PUT_LINE('��ο����!');
END;
/       
-- �ּ��� PL/SQL ���� ���� ����
-- ���Ʒ� �����ϱ� ���� '/'�� ����

-- := ������ �Է�
DECLARE
    l_message VARCHAR2( 100 ) := '������ �Է�';  
BEGIN
    DBMS_OUTPUT.PUT_LINE( l_message );
END;
/

DECLARE
    v_name  emp.ename%TYPE;
BEGIN
    v_name := 'ȫ�浿';
    DBMS_OUTPUT.PUT_LINE( v_name );
END;
/

-- 1
CREATE OR REPLACE PROCEDURE update_sal 
 (
    in_empno IN NUMBER
 )      
 IS 
 BEGIN 
   UPDATE emp 
   SET sal = sal  * 1.1 
   WHERE empno = in_empno; 
  -- COMMIT; 
 END update_sal; 
 / 
 
EXECUTE update_sal(7369);
EXEC UPDATE_sal(7499);

-- 2
-- adjust_salary(������ȣ, �ӱ��λ��%)
CREATE OR REPLACE PROCEDURE adjust_salary
    (
        in_empno IN emp.empno%TYPE,
        in_percent IN NUMBER
    ) 
IS
BEGIN
   -- ������ȣ�� �ӱ��� in_percent% ��ŭ �ø�
   UPDATE emp
   SET sal = sal + sal * in_percent / 100
   WHERE empno = in_empno;
END;
/

select * from emp;
-- scott ������ ������ 10% �λ��϶�
EXECUTE adjust_salary(7839, 50);

-- �� ����
UPDATE emp
SET sal = 5000
WHERE empno = 7839;

UPDATE emp
SET sal = 800
WHERE empno = 7369;

commit;


-- TEST ���̺� 100���� ������ �Է�
DECLARE
    v_cnt NUMBER := 1;
BEGIN
    -- �ݺ���(LOOP)
    LOOP
        INSERT INTO TEST(id, name)
        VALUES(v_cnt, '�׽�Ʈ'||to_char(v_cnt) );
    
        v_cnt := v_cnt+1;
    
        EXIT WHEN v_cnt > 100;
        -- ���� v_cnt�� 100�� ������ �����
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('������ �Է� �Ϸ�');
    DBMS_OUTPUT.PUT_LINE(v_cnt-1 || '���� �����Ͱ� �ԷµǾ����ϴ�');

END; 
/

select * from TEST;