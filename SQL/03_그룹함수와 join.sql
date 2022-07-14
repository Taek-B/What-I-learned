-- �׷��Լ� (������ �Լ�, �����Լ�)
SELECT ROUND(AVG(salary)) ��հ�,
       MAX(salary) �ִ밪,
       MIN(salary) �ּҰ�, 
       SUM(salary) �հ�,
       COUNT(salary) ī��Ʈ
FROM employees
WHERE job_id LIKE '%REP%';

SELECT * FROM employees WHERE job_id LIKE '%REP%';

-- ī��Ʈ count : ���� ������ ����ϴµ� NULL���� ���� ��(*)�϶��� ��ü ī��Ʈ
SELECT COUNT(commission_pct)
FROM employees;

SELECT COUNT( DISTINCT department_id)
FROM employees;
-- �����Լ����� NULL���� �����ϰ� ����
SELECT AVG(commission_pct)
FROM employees;
-- ��ü ���(���� ��� 0)
SELECT AVG(NVL(commission_pct,0))
FROM employees;

-- GROUP BY �� : Ư�� �׷����� ����� �׷��Լ��� ���
SELECT department_id �μ���ȣ,
       ROUND(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY department_id
ORDER BY �μ���ȣ; -- �μ���ȣ�� �׷쳪��

-- �׷쿭�� �������� �� 
SELECT department_id �μ���ȣ, job_id ����, ROUND(AVG(salary), 1) ��տ���
FROM employees
GROUP BY department_id, job_id
ORDER BY �μ���ȣ;

-- ���� 1)  �μ��� �����, �ִ�޿�, �ּұ޿�, �޿��հ�, ��ձ޿��� �޿��հ� ū������ ��ȸ
SELECT department_id �μ���, 
       COUNT(*) �����, 
       MAX(salary) �ִ�޿�, 
       MIN(salary) �ִ�޿�,
       SUM(salary) �޿��հ�,
       ROUND(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY department_id
ORDER BY �޿��հ� DESC;

-- ���� 2)  �μ���, ������(job_id) ���� �׷��� ���� salary �հ�� �׷캰 ������ ���ڸ� ����϶�.
SELECT department_id �μ���ȣ,
       job_id ����,
       SUM(salary),
       COUNT(*) ������
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

-- ���� 3) �μ����� �ְ� ������ �̾Ƽ� ����� ����, �������� ���� ����� ���� ����϶�.
SELECT ROUND(AVG(MAX(salary))) �μ����ְ�������, 
       ROUND(AVG(MIN(salary))) �μ��������������
FROM employees
GROUP BY department_id;

-- �׷� �Լ��� ������ HAVING
SELECT department_id �μ���, COUNT(*) �����
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;  -- ����� 5���� �Ѵ� �μ�

-- ���� 1) �Ʒ� ������ ������ ��� ������ $10000�� �ʰ��ϴ� ������ ���ؼ� job_id��  
-- ���޿� �հ踦 ��ȸ�ϴ� ���̴�. �� ��ī��Ʈ �Ŵ���( AC_MGR )�� �����ϰ� �� �޿� �հ�� �������� �����Ͻÿ�.
SELECT job_id ����, SUM(salary) ���޿��հ�
FROM employees WHERE job_id != 'AC_MGR'
GROUP BY job_id
HAVING AVG(salary) > 10000 
ORDER BY ���޿��հ� DESC;

-- ���� 2) �μ���ȣ 40�� ������ �μ��� ��� �޿��� 7000 ������ �μ����� ��� �޿��� ���
SELECT department_id �μ���ȣ, ROUND(AVG(salary)) ��ձ޿�
FROM employees
GROUP BY department_id
HAVING AVG(salary) <= 7000 AND department_id != 40;

-- ���� 3) �������� ����(salary)�� �հ谡 13000 �̻��� ������ ����϶�. 
-- �޿��Ѿ����� ������������ �����ϰ�, ����(job_id)�� 'REP' ����ִ� ������ �����Ѵ�.
SELECT job_id, SUM(salary) �޿��Ѿ�
FROM employees
GROUP BY job_id
HAVING SUM(salary) >= 13000 AND job_id NOT LIKE '%REP%'
ORDER BY �޿��Ѿ� DESC;

-- ���� (JOIN)
SELECT e.employee_id ������ȣ, e.last_name �����̸�,
       d.department_id �μ���ȣ, d.department_name �μ���
FROM employees e JOIN departments d
ON e.department_id  = d.department_id;
-- 3�� ���̺� ����
SELECT employee_id, city, department_name
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id
JOIN locations l
    ON d.location_id = l.location_id;

-- WHERE���� ���� ������ ���´�.
SELECT e.employee_id, e.last_name,
       d.department_id, d.location_id
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id
WHERE d.department_id = 50
    AND e.salary > 5000;


-- ����) �μ���(department_name) , ��Ƽ��(city), ������(country_name)�� ��Ÿ���� ���̺��� ����մϴ�. 
-- ���̺���� countries �� departments�� locations�� ���� �մϴ�. 
-- ������, ��Ƽ�� 'Seattle' Ȥ�� 'London' �̾�� �ϰ� �������� ���ʿ� 'United' �� ���� �մϴ�.
SELECT d.department_name �μ���, l.city ��Ƽ��, c.country_name ������
FROM departments d
JOIN locations l
    ON l.location_id = d.location_id
JOIN countries c
    ON c.country_id = l.country_id
WHERE l.city IN ('Seattle', 'London') AND c.country_name LIKE 'United%';

-- ��ü ����
select e.last_name ����, e.phone_number ������ȣ , m.last_name �Ŵ��� , m.phone_number �Ŵ�����ȣ
FROM employees e  
JOIN employees m
    ON e.manager_id = m.employee_id
ORDER BY m.last_name;
    
-- �ܺ� ����
-- LEFT OUTER JOIN
select e.last_name ����, e.department_id �μ���ȣ, d.department_name �μ���
FROM employees e 
LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
ORDER BY �μ���ȣ DESC;

-- RIGHT OUTER JOIN
select e.last_name ����, e.department_id �μ���ȣ, d.department_name �μ���
FROM employees e 
RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id
ORDER BY �μ���ȣ DESC;


-- FULL OUTER JOIN
select e.last_name ����, e.department_id �μ���ȣ, d.department_name �μ���
FROM employees e 
FULL OUTER JOIN departments d
    ON e.department_id = d.department_id
ORDER BY �μ���ȣ DESC;

-- ����)countries , locations ���̺��� �����Ͽ� �Ʒ��� ���� ����Ͻÿ�.(������ȣ�� DESC ����)
-- country_name ����, country_id ������ȣ, location_id ������ȣ, city ����
SELECT c.country_name ����, c.country_id ������ȣ, l.location_id ������ȣ, l.city ����
FROM countries c left OUTER JOIN locations l ON c.country_id = l.country_id
ORDER BY ������ȣ DESC;


-- ���� ����(CROSS JOIN)
-- ����) countries , regions ���̺��� ũ�ν� �����Ͽ� �Ʒ��� ���� ������ ���̺��� 25�� X 4�� => 100���� ����� �������� �ϼ���.
SELECT c.country_name ����, r.region_name �����̸�
FROM countries c CROSS JOIN regions r; 


