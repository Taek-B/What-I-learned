--1. departments ���̺� �ִ� manager_id �� employees ���̺��� employee_id�� �̿��Ͽ�
--   �����Ͽ� �μ���, �Ŵ�����ȣ, �Ŵ����̸� , ��ȭ��ȣ�� ��Ÿ�����.
SELECT d.department_name                 �μ���,
       d.manager_id                      �Ŵ�����ȣ,
       e.last_name||' '||e.first_name    "�Ŵ����̸�(�����̸�)",
       e.phone_number                    ��ȭ��ȣ
FROM departments d
    JOIN employees e
        ON d.manager_id = e.employee_id;

--2. ������ �̿��Ͽ� ������� ������ȣ(employee_id), �������(hire_date), 
--   ����(job_id), ��å(job_title)�� ����Ͻÿ�.
SELECT e.employee_id ������ȣ,
       e.hire_date �������, 
       j.job_id ����, 
       j.job_title ��å 
FROM employees e
    JOIN jobs j
        ON e.job_id = j.job_id;
    
--3. ��å(job_title)�� 'Sales Manager'�� ������� �Ի�⵵ �׷� ��? ��� �޿��� ����Ͻÿ�. 
--   �Ի�⵵�� �������� �������� ����
--   (jobs ���̺�� ����  job_id �� �̿� , �Ի�⵵: TO_CHAR(e.hire_date, 'YYYY'))
select TO_CHAR(e.hire_date, 'YYYY') "�Ի�⵵",
       ROUND(AVG(salary)) "��ձ޿�"
from employees e
    join jobs j
        on e.job_id = j.job_id
where j.job_title = 'Sales Manager'
group by TO_CHAR(e.hire_date, 'YYYY')
order by TO_CHAR(e.hire_date, 'YYYY');


--4. ������ ����(city)�� �ִ� ��� �μ� �������� ��ձ޿��� ��ȸ�ϰ��� �Ѵ�. 
--   ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ �������� ����Ͻÿ�.  
--   ��, ���ÿ� �ٹ��ϴ� ������ 10�� �̻��� ���� �����ϰ� ��ȸ�Ͻÿ�.
--   (Tips: ���̺� ���赵�� ���� �켱 � ���̺���� �����ؾ� ���� �������� 
--   SELECT * �� ���̺���� �����ؼ� ������ ������ Ȯ������ GROUP BY���� SELECT �� �ۼ� )
select l.city CITY, ROUND(AVG(e.salary)), count(*) 
from employees e
    join departments d
        on e.department_id = d.department_id
    join locations l
        on d.location_id = l.location_id
group by l.city
having count(*) < 10
order by ROUND(AVG(e.salary));


--5. �ڽ��� �Ŵ��� ���� �޿��� ���� �޴� �������� ��(last_name), 
--   �޿�(salary)�� �Ŵ����� last_name�� salary�� ����϶�.
select e.employee_id, e.last_name, e.salary, m.last_name, m.salary
from employees e 
    join employees m 
        on e.manager_id = m.employee_id
where e.salary > m.salary;