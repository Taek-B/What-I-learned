--���� ����

--Popp �������� ������� �ֱ�(����)�� ����� ���
--������ : ������ ���������� ����Ҷ��� ���������� ����� ���ϴ� �����Ϳ� ���� �ϳ��� ��µǾ�� �Ѵ�.

--()��ȣ �ȿ� ������ ���� 2���̸� ���������� ���� �� Error�� ����. 
-- WHERE last_name = 'Smith' // Error O
-- WHERE last_name = 'Popp'  // Error X
SELECT last_name �̸�, hire_date �������
FROM employees
WHERE hire_date > ( SELECT hire_date
                    FROM   employees
                    WHERE last_name = 'Smith')
order by �������;
 
-- �׷��Լ��� ����� ���������� ��� 
SELECT last_name �̸�, job_id ����, salary �޿�
FROM employees
WHERE salary =    ( SELECT min(salary)
                    FROM employees);
  
--����)  ��� 'Abel'(last_name) ���� �޿��� ���� ����� last_name , salary �� ��Ÿ�����.
--      (�������� ���)
select last_name �̸�,  salary �޿�
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');

--����) 'Bull'�� last_name�� ���� ����� �μ����� Bull���� 
--     ���� �޿��� �޴� ������� ����϶�.  (�������� ���)
select employee_id ������ȣ, last_name �̸�, department_id �μ���ȣ, salary �޿�
from employees
where salary > (select salary
                from employees
                where last_name = 'Bull')
and department_id = (select department_id
                from employees
                where last_name = 'Bull');


--����) 'Russell'�̶� last_name�� ������ȣ�� manager_id�� ������ 
--     �������� last_name, salary, manager_id�� ����Ͻÿ�.
select last_name �̸�, salary �޿�, manager_id �Ŵ���
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name='Russell' );
                    
--����) jobs ���̺� job_title�� 'Stock Manager' ��  job_id�� ���� 
--     �������� ������ Employees ���̺��� ã�Ƽ� ����Ͻÿ�.
select *
from employees
where job_id = (select job_id
                from jobs
                where job_title = 'Stock Manager');
               
                
-- ������ �������� (�������� ����� �������� ������ ���)

SELECT MIN(salary) FROM employees GROUP BY department_id;   -- �μ��� ��������

-- IN ������ : ���� �ϳ��� ��ġ�ϸ� �˻���
SELECT department_id ,employee_id, last_name
FROM employees
WHERE salary  in (SELECT MIN(salary) FROM employees GROUP BY department_id)
order by department_id;

-- ANY ������ : ���� �ϳ��� ������ �˻���
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary  < ANY ( SELECT salary FROM employees WHERE job_id = 'IT_PROG')
    AND job_id <> 'IT_PROG'
ORDER BY salary DESC;

-- ALL ������ : ���� ���� ���� �Ǿ�� �˻���
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary  < ALL ( SELECT salary FROM employees WHERE job_id = 'IT_PROG')
    AND job_id <> 'IT_PROG'
ORDER BY salary DESC;


--���� 1) �μ���ȣ(department_id)��  20���� �������� �Ŵ������̵�(manager_id)�� 
--       ���� �Ŵ����� ������  �������� ����϶�. (�� 20�� �μ��� ������ ����!)
select employee_id, first_name, job_id, salary
from employees
where manager_id  in (select manager_id
                      from employees
                      where department_id = 20);

--���� 2) job_id��  'ST_MAN'�� �������� ��� ������ ���ٵ� 
--       �޿��� ���� �������� ����϶�. (ANY)
select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary
                    from employees
                    where job_id = 'ST_MAN');

--?���� 3) ��å�� 'IT_PROG' �� ������ ���� �޿��� ���� �������� ����Ͻÿ�.(ALL)
select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                    from employees
                    where job_id='IT_PROG');


-- ���߿� ��������
SELECT employee_id, first_name, job_id, salary, manager_id
FROM employees
WHERE (manager_id, job_id) IN  (SELECT manager_id, job_id
                                FROM employees
                                WHERE first_name = 'Bruce')
AND first_name <> 'Bruce';

-- �μ��� ���� �޿� ����� ������ ���
select department_id �μ���ȣ, employee_id �����ȣ, first_name, salary
from employees
where (department_id, salary) in  (select department_id, min(salary)
                                   from employees
                                   group by department_id)
order by department_id;

--����) employees ���̺��� job_id���� ���� ���� salary�� ������ ã�ƺ���, 
--     ã�Ƴ� job_id�� salary�� �ش��ϴ� ������ first_name, job_id, salary, department_id �� 
--     ����Ͻÿ�. (salary �������� ����)
select first_name, job_id, salary, department_id
from employees
where (job_id, salary) in (select job_id, min(salary)
                           from employees
                           group by job_id)
order by salary DESC;



-- ���տ�����
select * from employees;        -- 107��
select * from job_history;      -- 10��

-- UNION�� �̿��� ������
select employee_id, job_id
from employees
union
select employee_id, job_id
from job_history;
 
-- UNION ALL�� �̿��� ������(������ �������� ����)
select employee_id, job_id
from employees
union all
select employee_id, job_id
from job_history;

-- INTERSECT�� �̿��� ������
select employee_id, job_id
from employees
INTERSECT
select employee_id, job_id
from job_history;

-- MINUS�� �̿��� ������
select employee_id, job_id
from employees
MINUS
select employee_id, job_id
from job_history;

--����) ?employees ���̺��� department_id ���հ� departments ���̺��� 
--     department_id ������ UNION �����ڸ� �̿��� ���� ������.
select department_id
from employees
UNION
select department_id
from departments;       -- 28��

--����) employees ���̺��� department_id ���հ� departments ���̺��� 
--     department_id ������ UNION ALL�����ڸ� �̿��� ���� ������.
select department_id
from employees
UNION ALL
select department_id
from departments;       -- 134�� = 107 + 27 (�ߺ����� ���ļ�?)

--����) employees ���̺��� department_id ���հ� departments ���̺��� 
--     department_id ������ �������� INTERSECT �����ڸ� �̿��� ����� ������.
select department_id
from employees
INTERSECT
select department_id
from departments;       -- 11��

--����) departments ���̺��� department_id ���տ��� employees ���̺��� 
--     department_id ������ MINUS �����ڸ� �̿��� �� ������.
select department_id
from employees
MINUS
select department_id
from departments;       -- 1��    

select department_id
from departments
MINUS
select department_id
from employees;       -- 16��    


