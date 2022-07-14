-- SELECT�� ��ȸ
-- �μ� ���̺� ��� �� ��ȸ
select * from departments;
-- AS�� ��Ī�̰� ��ȸ�� ���̸��� �˻�����
select department_name AS �μ��̸�
from departments;
-- �켱 ���̺���� from�� ���� CTRL+space �ڵ����� ���̸��� �ҷ��´�.
SELECT department_id �μ���ȣ,department_id �μ��̸�
from departments;

-- ���� ���̺� ����
select salary ����
from employees;
-- ��ü ���� ���޿� 100 �߰� �ؼ� �� �������
select last_name �̸�, salary ����, salary + 100 ���ʽ�����
from employees;
-- ��ü ���� ���޿� -10% �ؼ� �� �������
select last_name �̸�, salary ����, salary - salary*0.10 ������
from employees;

-- �ߺ��� ���� DISTINCT
-- ������ ������ ��ȸ
SELECT DISTINCT job_id ����
FROM employees;

-- ����1) employees���̺��� employee_id, first_name, last_name�� ����ϼ���.
SELECT employee_id, first_name, last_name 
from employees;
-- ����2) employees���̺��� first_name, salary, salary*1.1 AS �������� ����ϼ���.
SELECT first_name, salary, salary*1.1 �������� 
from employees;
-- ����3) employees���̺��� employee_id�� '�����ȣ', first_name�� '�̸�', last_name�� '��'���� ����ϼ���.
SELECT employee_id �����ȣ, first_name �̸�, last_name �� 
from employees;

-- ���� ������ || (���ڿ��� ��ħ)
select employee_id, first_name||' '||last_name Ǯ����
from employees;

-- ����4)
select employee_id, first_name||' '||last_name Ǯ����, email||'@company.com' email
from employees;

desc employees;

-- Where�� (���ǹ�)
-- �������� ������ 14000�̻��� ����
SELECT *
FROM employees
WHERE salary > 14000;
-- �̸��� king�� ���
SELECT *
FROM employees
WHERE last_name = 'King';   -- ���ڿ���''�� ����ǥ�� �� ���̰� ��ҹ��ڸ� ����

-- ������ڰ� 2002�� 6�� 10�� ������ ����
SELECT *
FROM employees
WHERE hire_date < '2002/06/10';  -- ����Ŭ���� ���ڿ��ȿ� ��¥�������� ������ �ڵ� ��ȯ��

-- Where�� ����(1~5)
SELECT *
FROM employees
WHERE employee_id = 100;

SELECT *
FROM employees
WHERE first_name='David';

SELECT *
FROM employees
WHERE employee_id <= 105;

SELECT *
FROM job_history
WHERE start_date > '2006/03/03';

SELECT *
FROM departments
WHERE location_id != 1700;

-- ��������
-- 80���μ��̸鼭 ������ 10000���� ���� ���� �Ǵ� 60���μ� ����
SELECT last_name, department_id, salary
FROM employees
WHERE department_id = 60 OR (department_id=80 AND salary > 10000);

-- �μ���ȣ�� 80�Ǵ� 60�̸鼭 ������ 10000���� ū ���� 
SELECT last_name, department_id, salary
FROM employees
WHERE (department_id = 60 OR department_id=80) AND salary > 10000;

-- NOT, AND, OR ������ ����(1~2)
SELECT *
FROM employees
WHERE salary > 4000 AND job_id ='IT_PROG';

SELECT *
FROM employees
WHERE salary > 4000 AND (job_id ='IT_PROG' OR job_id ='FI_ACCOUNT');

-- IN ������ OR�� ������ ���� ��ſ� IN(a,b,c) �� �� �ִ�.
-- ������ 2700 �Ǵ� 3000�Ǵ� 4000�� ������ ��ȸ
SELECT *
FROM employees
WHERE salary IN (4000,3000,2700);

-- ����(1~2)
SELECT *
FROM employees
WHERE salary IN (10000,17000,24000);

SELECT *
FROM employees
WHERE department_id NOT IN (30,50,80,100,110);

-- BETWEEN A and B (a�� b ����)
SELECT *
FROM employees
WHERE salary BETWEEN 9000 AND 10000;

-- ����(1~3)
SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 20000;

SELECT *
FROM employees
WHERE hire_date BETWEEN '2004/01/01' AND '2004/12/30';

SELECT *
FROM employees
WHERE salary NOT BETWEEN 7000 AND 17000; 

-- LIKE ������ ���ڿ� ��ȸ�� ��Ȯ���� ���� ��� ���
-- #�� �ڿ� ���� ��� : �̸��� �빮�� B�� �����ϴ� ��� ����
SELECT *
FROM employees
WHERE last_name LIKE 'B%';

-- %�� �յڿ� ������� : ���̰��� b�� ������ ���� ��ȸ��
SELECT *
FROM employees
WHERE last_name LIKE '%b%';

-- % �տ� ���� ��� : �� �ޱ��ڰ� y�� ������ ���
SELECT *
FROM employees
WHERE last_name LIKE '%y';

-- ����(1~5)
SELECT * FROM employees WHERE job_id LIKE '%AD%';
SELECT * FROM employees WHERE job_id LIKE '%AD___';
SELECT * FROM employees WHERE phone_number LIKE '%1234';
SELECT * FROM employees WHERE phone_number LIKE '%9' AND phone_number NOT LIKE '%3%';
SELECT * FROM employees WHERE job_id LIKE '%MGR%' OR job_id LIKE '%ASST%' ;

-- IS NULL ������
-- null : ���� �Է� ������ ��, ���� ���� ��( 0�̳� ����''�� �ƴϴ�.)
-- null�� �˻��ϱ� ���� IS NULL�� ����Ѵ�.
SELECT *
FROM employees
WHERE commission_pct IS NULL;

SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- ���� �Ŵ���ID�� NULL�� ������ ��ȸ�϶�
SELECT *
FROM employees
WHERE manager_id IS NOT NULL;

-- ORDER BY + �� + ASC or DESC : ���� �������� �Ǵ� ������������ ����
-- ������ ū ��� ������ ����
SELECT *
FROM employees
ORDER BY last_name DESC;  -- ASC �������ε� ���� ����

-- ���� ���� 2�� �̻��� �� õ��° ���� ������ ������� �ι�° �� ����
-- �μ���ȣ�� ������ �� �����ȣ�� ����
SELECT department_id, employee_id, first_name, last_name
FROM employees
ORDER BY department_id, employee_id;

-- �������� ����
SELECT department_id, last_name, salary*12 ����
FROM employees
ORDER BY ����;

SELECT department_id, last_name, salary*12 ����
FROM employees
ORDER BY 3 DESC;

-- ����(1~3)
SELECT employee_id, first_name, last_name
FROM employees
ORDER BY employee_id DESC;

SELECT *
FROM employees
WHERE job_id LIKE '%CLERK%'
ORDER BY salary DESC;

SELECT employee_id ������ȣ, last_name �����̸�, department_id �μ���ȣ, salary ����
FROM employees
WHERE employee_id BETWEEN 120 AND 150
ORDER BY �μ���ȣ DESC  , ���� DESC; 

