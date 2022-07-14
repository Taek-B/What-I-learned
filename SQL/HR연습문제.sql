--1. �μ��� ������
select d.department_name, count(*)
from employees e
    join departments d 
        on e.department_id = d.department_id
group by d.department_name
order by d.department_name DESC;


--2. �μ��� ��� �޿�(salary)
select d.department_name, ROUND(AVG(e.salary),-1)
from employees e
    join departments d
        on e.department_id = d.department_id
group by d.department_name
order by ROUND(AVG(e.salary),-1)DESC;


--3. ��å�� ��� �޿�(��ձ޿� ���� ���� 7�� ��å��)
select rownum, A.*
from(
    select j.job_title, ROUND(AVG(salary))
    from employees e
        join jobs j
            on e.job_id = j.job_id
    
    group by j.job_title
    order by ROUND(AVG(salary)) DESC
) A
where rownum <=7;



--4. �ڽ��� �Ŵ��� ���� �� ���� �޿��� �޴� ��� ���
select e.employee_id, e.last_name, e.salary
from employees e 
    join employees m 
        on e.manager_id = m.employee_id
where e.salary > m.salary;


--5. Job title�� Sales Representative�� ���� �߿���, �޿��� 9000~10000�� ��������
--   �̸��� �޿��� ����Ͻÿ�
select e.first_name ||' '|| e.last_name EMP_NAME, e.salary 
from employees e
    join jobs j
        on e.job_id = j.job_id
where j.job_title = 'Sales Representative' and (salary between 9000 and 10000)
order by e.salary desc;


--6. �޿� ������ ���� ���� ���޼����� �޿� ������ ����Ͻÿ�.
--(��, �޿������� 30,000 �̻��� ���޸� ����� ��)
select j.job_title, SUM(e.salary)
from employees e
    join jobs j
        on e.job_id = j.job_id
group by j.job_title
having SUM(e.salary) > 30000
order by SUM(e.salary) DESC;


--7. �� ���ú� ��� ����(�޿�)�� ���������� ���� 3�� ���ø� ����Ͻÿ�.
select rownum, A.*
from(
    select l.city , ROUND(AVG(salary))
    from employees e
       join departments d
            on e.department_id = d.department_id
        join locations l
            on d.location_id = l.location_id
        group by l.city
        order by ROUND(AVG(salary)) DESC
) A
where rownum <= 3;


--8. ��å(Job Title)�� 'Sales Manager'�� ������� �Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�.
--   ��� �� �⵵�� �������� �������� �����Ͻÿ�.
select TO_CHAR(e.hire_date,'YYYY') "HIRE_YEAR", ROUND(AVG(e.salary)) AVG_SAL
from employees e
    join jobs j
        on e.job_id = j.job_id
where j.job_title = 'Sales Manager'
group by TO_CHAR(e.hire_date,'YYYY')
order by TO_CHAR(e.hire_date,'YYYY');


--9. �� ����(city)�� �ִ� ��� �μ� �������� ��ձ޿��� ��ȸ�ϰ��� �Ѵ�. 
--   ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ �������� ����Ͻÿ�. 
--   ��, ���ÿ� �ٹ��ϴ� ������ 10�� �̻��� ���� �����ϰ� ��ȸ�Ͻÿ�.
select l.city CITY, ROUND(AVG(e.salary)), count(*) 
from employees e
    join departments d
        on e.department_id = d.department_id
    join locations l
        on d.location_id = l.location_id
group by l.city
having count(*) < 10
order by ROUND(AVG(e.salary));


--10. ��Public Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ������� ����� �̸��� ����Ͻÿ�. 
--    (���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ��� ���� �ʴ´�)
select e.employee_id, e.first_name || ' ' || e.last_name EMP_NAME
from employees e 
    join job_history h
        on e.employee_id = h.employee_id
where h.job_id = any( select job_id
                      from jobs
                      where job_title = 'Public Accountant');

--11. 2007�⿡ �Ի�(hire_date)�� �������� ���(employee_id), �̸�(first_name),
--    ��(last_name), �μ���(department_name)�� ��ȸ�մϴ�.  
--    �̶�, �μ��� ��ġ���� ���� ������ ���, ��<Not Assigned>���� ����Ͻÿ�.
select e.employee_id ���, e.first_name �̸�, e.last_name ��, NVL(d.department_name,'<Not Assigned>') �μ���
from employees e
   LEFT OUTER join departments d
        on e.department_id = d.department_id
where e.hire_date between '07/01/01' and '07/12/31'
order by e.employee_id;


--12. �μ����� ���� ���� �޿��� �ް� �ִ� ������ �̸�, �μ��̸�, �޿��� ����Ͻÿ�. 
--    �̸��� last_name�� ����ϸ�, �μ��̸����� �������� �����ϰ�, 
--    �μ��� ���� ��� �̸��� ���� ���� �������� �����Ͽ� ����մϴ�.
select d.department_name, e.employee_id, e.last_name, e.salary
from employees e
    join departments d
        on e.department_id = d.department_id
where (d.department_id, e.salary) in (select department_id, MIN(salary)
                                      from employees
                                      group by department_id)     
order by d.department_id, e.last_name;
 
 
--13. EMPLOYEES ���̺��� �޿��� ���� �޴� ������� ��ȸ���� �� 6��°���� 10 ��°����
--    ������ last_name, first_name, salary�� ��ȸ�ϴ� sql������ �ۼ��Ͻÿ�.
select B.last_name, B.first_name, B.salary 
from(
    select rownum as RN, A.*
    from (
        select * from employees order by salary DESC
    ) A -- ����
) B     -- ����RN
where RN between 6 and 10;  -- 6��° 10��°������ ���


--14) ��Sales�� �μ��� ���� ������ �̸�(first_name), �޿�(salary), 
--    �μ��̸�(department_name)�� ��ȸ�Ͻÿ�. 
--    ��, �޿��� 100�� �μ��� ��պ��� ���� �޴� ���� ������ ��µǾ�� �Ѵ�.
select first_name, salary, department_name
from employees e
    join departments d
        on e.department_id = d.department_id
where department_name = 'Sales' and salary < (select AVG(salary)
                                             from employees
                                             where department_id=100);

--15) �μ��� �Ի���� �������� ����Ͻÿ�. 
--    ��, �������� 5�� �̻��� �μ��� ��µǾ�� �ϸ� ��°���� �μ��̸� ������ �Ѵ�. 
--    (������� 5���̻� �Ǵ� �μ��� 5���̻�)
select d.department_name, TO_CHAR(e.hire_date,'MM'), count(*) 
from employees e
    join departments d
        on e.department_id = d.department_id
group by d.department_name, TO_CHAR(e.hire_date,'MM')
having count(*) >= 5
order by d.department_name;

--16) Ŀ�̼�(commission_pct)�� ���� ���� ���� ���� 4���� 
--    �μ���(department_name), ������ (first_name), �޿�(salary),
--    Ŀ�̼�(commission_pct) ������ ��ȸ�Ͻÿ�. 
--    ��°���� Ŀ�̼��� ���� �޴� ������ ����ϵ� ������ Ŀ�̼ǿ� ���ؼ��� �޿��� ����
--    ������ ���� ��� �ǰ� �Ѵ�.
select rownum, A.*
from(
    select d.department_name, e.first_name, e.salary, e.commission_pct
    from employees e
        join departments d
            on e.department_id = d.department_id
    where e.commission_pct IS NOT NULL
    order by e.commission_pct DESC, e.salary DESC
    ) A
where rownum <=4;