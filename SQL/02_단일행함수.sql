-- ������ �Լ�

-- �����Լ�
-- ��ҹ��� ��ȯ�Լ�
SELECT UPPER('SQL Course'),
       LOWER('SQL Course'),
       INITCAP('SQL Course')
FROM DUAL;  -- �׽�Ʈ�� ���̺�(1�ุ ����)�� �̿��Ͽ� ����

-- ���� ���� �Լ�
SELECT CONCAT('��ο�','����'),
       SUBSTR('ABCDEFG',3,4),
       LENGTH('ABCDEFG'),
       INSTR('ABCDEFG','D')       
FROM DUAL;

-- ���� ���ֱ� TRIM(���ڿ�) ���ڿ� �յ��� ������ ����
SELECT TRIM('   ��ο�     '), '     ��ο�   ' FROM DUAL;

-- ������ �Լ� ����
SELECT department_id, last_name, department_id
FROM employees
WHERE lower(last_name) = 'higgins';   -- ��ҹ��ڰ� ���� ���� ��� ��ȯ�ؼ� ��ȸ����

-- ���ڿ� �ٲٱ�
SELECT job_id, replace(job_id, 'ACCOUNT', 'ACCNT') ������
FROM employees;

-- ����(1~2)
SELECT last_name �̸�, LOWER(last_name) LOWER����, UPPER(last_name) UPPER����, email �̸���, INITCAP(email) INITCAP����
FROM employees;

SELECT job_id ������, SUBSTR(job_id,1,2) ����2��
FROM employees; 

-- ���� �Լ�
-- ROUND�Լ��� �ݿø��� �ؼ� �Ҽ��� �ڸ������� ��� (number�� �Ҽ����ڸ����� +1�� �ڸ�����  �ݿø�)
SELECT ROUND(15.193,1) �Ҽ�ù°,
       ROUND(15.193,0) ����,
       ROUND(15.193) �ڸ�������,
       ROUND(15.193,-1)"10���ڸ�"
FROM DUAL;
 
-- TRUNC�Լ� : ���� (number�� �Ҽ����ڸ����� ��Ÿ��)
SELECT TRUNC(15.193,1) �Ҽ�ù°
FROM DUAL;

-- MOD�Լ� : ������ �� �������� ����
-- ������ȣ�� ¦���� �������� ����
SELECT employee_id ¦��, last_name
FROM employees
WHERE MOD( employee_id, 2) = 0
ORDER BY employee_id;

-- ����
SELECT salary, ROUND(salary/30) ����, ROUND(salary/30,1) �Ҽ�1, ROUND(salary/30,-1) "10���ڸ�"
FROM employees;

-- ��¥�� �Լ�
SELECT sysdate FROM DUAL;
-- ��¥�� �ݿø� ��(�ð��� �ݿø�), ���� ��¥�� �ݿø�, ���� ���� �ݿø� (�ݿø� �ϸ� 1�� �ʱ�ȭ��)
SELECT ROUND(sysdate, 'DD') ��,
       ROUND(sysdate, 'MM') ��,
       ROUND(sysdate, 'YYYY') �⵵,
       MONTHS_BETWEEN('2017/10/10', '2017/07/10') ������,
       ADD_MONTHS('2017/07/10', 3) �ֵ�վ�
FROM DUAL;
-- ��¥�� ���� ����
SELECT sysdate-1 ����, sysdate ����, sysdate+1 ����
FROM DUAL;
-- 90�� �μ� �������� ���ñ����� �ٹ��ϼ��� (���� ��¥ - �����)
SELECT last_name �̸� , FLOOR(sysdate - hire_date) �ٹ��ϼ�
FROM employees
WHERE department_id = 90;

-- �ٹ������� 200������ �ȵ� ������
SELECT employee_id, hire_date,
       FLOOR(MONTHS_BETWEEN(SYSDATE, hire_date)) �ٹ�����,
       ADD_MONTHS(hire_date,6) "6���� �߰�",
       NEXT_DAY(hire_date, '�ݿ���') Next_day,
       --1(��), 2(��), 3(ȭ), 4(��), 5(��), 6(��), 7(��)
       LAST_DAY(hire_date) Last_day
       --���� ������ ��
FROM employees
WHERE MONTHS_BETWEEN(sysdate, hire_date) < 200;

--����(1~2)
SELECT sysdate ����, hire_date, MONTHS_BETWEEN(sysdate, hire_date) ������
FROM employees
WHERE department_id = 100;

SELECT hire_date, ADD_MONTHS(hire_date,3) "3���� ���� ��", ADD_MONTHS(hire_date,-3) "3���� �� ��" 
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

-- ��ȭ�� �Լ� (��¥, ����, ���ڸ� ��ȯ�ϴ� �Լ�)

-- ���ڸ� ���ڷ� ��ȯ
-- �޸� ����
SELECT TO_CHAR(12345678,'999,999,999') comma 
FROM DUAL;
-- �Ҽ��� ����  
SELECT TO_CHAR(123.45678,'999,999,999.99') period 
FROM DUAL; 
-- $ ǥ�� ����
SELECT TO_CHAR(12345678,'$999,999,999') dollar  
FROM DUAL;
-- Local ȭ�� ǥ�� ���� (�ѱ��� ��� �ܷ� �ڵ� ��ȯ ��)
SELECT TO_CHAR(12345678,'L999,999,999') local  
FROM DUAL;
-- ���ʿ� 0�� ����
SELECT TO_CHAR(123,'09999') zero 
FROM DUAL;  
-- 16������ ��ȯ
SELECT TO_CHAR(123,'XXXX') hexadecimal  
FROM DUAL;

-- ��¥�� ���ڷ� ��ȯ
-- ��,��,��,��,��,�� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "sysdate"
FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') "���糯¥"
FROM DUAL; 

-- ����(1~2)
SELECT employee_id, TO_CHAR(hire_date, 'MM/DD') �Ի��
FROM employees
WHERE department_id = 100;

SELECT last_name �̸�, TO_CHAR(salary,'$99,999.99')  ����
FROM employees
WHERE salary > 10000
ORDER BY salary DESC;

-- TO_DATE ���ڿ��� ��¥�� ��ȯ
-- DATE Ÿ������ ��ȯ�ϴ� ����
SELECT TO_DATE('2011-01-01','YYYY-MM-DD')
FROM DUAL;

-- TO_NUMBER ���ڿ��� ���ڷ� ��ȯ
SELECT TO_NUMBER('01210616') + 10
FROM DUAL; 

-- NULL ���� �Լ�
-- NVL�Լ� : NULL���� �ٸ� ������ �ٲ� �� ���
SELECT last_name, NVL(manager_id, 0) �Ŵ���
FROM employees
WHERE last_name = 'King';

-- NVL2( ��, ù��°, �ι�°) => ���� ���� NULL�� �ƴ� ��쿡�� ù��° ���� ��ȯ �ϰ�, NULL�� ��쿡�� �ι�° ���� ��ȯ �Ѵ�.
SELECT last_name, NVL2(manager_id, 1, 0) �Ŵ���
FROM employees
WHERE last_name = 'King';

-- ����) employees ���̺��� �Ʒ��� ���� �̸�, ����(salary),Ŀ�̼�(commission_pct)��  NVL �Լ����, ������ ( ����*12) + (����*12*Ŀ�̼�) �̴�.
SELECT last_name �̸�, salary ����, NVL(commission_pct, 0) Ŀ�̼�,
       (salary*12)+ NVL(commission_pct,0)*(salary*12) ����
FROM employees ORDER BY ���� DESC;

-- ����) ���� ������ ���Ͽ� ��������� NVL2 �Լ��� ����Ͽ� Ŀ�̼��� �������� ������ ������� ��Ÿ���ϴ�.
SELECT last_name �̸�, salary ����, NVL(commission_pct, 0) Ŀ�̼�,
       (salary*12)+ NVL(commission_pct,0)*(salary*12) ����,
       NVL2(commission_pct, 'SAL+COMM','COMM') �������
FROM employees ORDER BY ���� DESC;

-- ���ڵ� decode �Լ�
SELECT last_name �̸�, job_id, salary,
    DECODE(job_id, 'IT_PROG',  salary * 1.10,
                   'ST_CLERK', salary * 1.15,
                   'SA_REP',   salary * 1.20,
                               salary)  "��������"
FROM employees;

-- ����) employees ���̺��� DECODE �Լ��� �̿��ؼ� ���޿� ���� ������ ��Ÿ������.
-- TRUNC( salary / 2000 ) �� ���� 0�϶� 0%, 1�϶�  9%, ...
SELECT last_name �̸�, job_id ����, salary ����,
       DECODE( TRUNC(salary/2000), 0, 0,
                                   1, 0.09,
                                   2, 0.2,
                                   3, 0.3,
                                   4, 0.4,
                                   5, 0.42,
                                   6, 0.44,
                                      0.45) ����
FROM employees;

-- CASE�Լ�
SELECT last_name �̸�, job_id, salary,
    CASE  WHEN salary<5000   THEN 'Low'
          WHEN salary<10000  THEN 'Medium'
          WHEN salary<20000  THEN 'Good'
          ELSE                    'Excellent'  
    END "�޿� ����"
FROM employees;

-- ����) employees ���̺��� job_id�� IT_PROG��� employee_id, first_name, last_name, salary��
--      ����ϵ� salary�� 9000 �̻��̸� �������޿���, 6000�� 8999 ���̸� �������޿���, �� �ܴ� �������޿������ ����ϼ���.
SELECT employee_id, first_name, last_name, salary,
    CASE WHEN salary >= 9000 THEN '�����޿�'
         WHEN salary >= 6000 THEN '�����޿�'
         ELSE                     '�����޿�'
    END "�޿����"
FROM employees WHERE job_id='IT_PROG';