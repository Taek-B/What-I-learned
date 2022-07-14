--1. 부서별 직원수
select d.department_name, count(*)
from employees e
    join departments d 
        on e.department_id = d.department_id
group by d.department_name
order by d.department_name DESC;


--2. 부서별 평균 급여(salary)
select d.department_name, ROUND(AVG(e.salary),-1)
from employees e
    join departments d
        on e.department_id = d.department_id
group by d.department_name
order by ROUND(AVG(e.salary),-1)DESC;


--3. 직책별 평균 급여(평균급여 기준 상위 7개 직책만)
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



--4. 자신의 매니저 보다 더 많은 급여를 받는 사람 목록
select e.employee_id, e.last_name, e.salary
from employees e 
    join employees m 
        on e.manager_id = m.employee_id
where e.salary > m.salary;


--5. Job title이 Sales Representative인 직원 중에서, 급여가 9000~10000인 직원들의
--   이름과 급여를 출력하시오
select e.first_name ||' '|| e.last_name EMP_NAME, e.salary 
from employees e
    join jobs j
        on e.job_id = j.job_id
where j.job_title = 'Sales Representative' and (salary between 9000 and 10000)
order by e.salary desc;


--6. 급여 총합이 가장 높은 직급순으로 급여 총합을 출력하시오.
--(단, 급여총합이 30,000 이상인 직급만 출력할 것)
select j.job_title, SUM(e.salary)
from employees e
    join jobs j
        on e.job_id = j.job_id
group by j.job_title
having SUM(e.salary) > 30000
order by SUM(e.salary) DESC;


--7. 각 도시별 평균 연봉(급여)가 높은순으로 상위 3개 도시를 출력하시오.
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


--8. 직책(Job Title)이 'Sales Manager'인 사원들의 입사년도(hire_date)별 평균 급여를 출력하시오.
--   출력 시 년도를 기준으로 오름차순 정렬하시오.
select TO_CHAR(e.hire_date,'YYYY') "HIRE_YEAR", ROUND(AVG(e.salary)) AVG_SAL
from employees e
    join jobs j
        on e.job_id = j.job_id
where j.job_title = 'Sales Manager'
group by TO_CHAR(e.hire_date,'YYYY')
order by TO_CHAR(e.hire_date,'YYYY');


--9. 각 도시(city)에 있는 모든 부서 직원들의 평균급여를 조회하고자 한다. 
--   평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 직원수를 출력하시오. 
--   단, 도시에 근무하는 직원이 10명 이상인 곳은 제외하고 조회하시오.
select l.city CITY, ROUND(AVG(e.salary)), count(*) 
from employees e
    join departments d
        on e.department_id = d.department_id
    join locations l
        on d.location_id = l.location_id
group by l.city
having count(*) < 10
order by ROUND(AVG(e.salary));


--10. ‘Public Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든사원의 사번과 이름을 출력하시오. 
--    (현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 않는다)
select e.employee_id, e.first_name || ' ' || e.last_name EMP_NAME
from employees e 
    join job_history h
        on e.employee_id = h.employee_id
where h.job_id = any( select job_id
                      from jobs
                      where job_title = 'Public Accountant');

--11. 2007년에 입사(hire_date)한 직원들의 사번(employee_id), 이름(first_name),
--    성(last_name), 부서명(department_name)을 조회합니다.  
--    이때, 부서에 배치되지 않은 직원의 경우, ‘<Not Assigned>’로 출력하시오.
select e.employee_id 사번, e.first_name 이름, e.last_name 성, NVL(d.department_name,'<Not Assigned>') 부서명
from employees e
   LEFT OUTER join departments d
        on e.department_id = d.department_id
where e.hire_date between '07/01/01' and '07/12/31'
order by e.employee_id;


--12. 부서별로 가장 적은 급여를 받고 있는 직원의 이름, 부서이름, 급여를 출력하시오. 
--    이름은 last_name만 출력하며, 부서이름으로 오름차순 정렬하고, 
--    부서가 같은 경우 이름을 기준 으로 오름차순 정렬하여 출력합니다.
select d.department_name, e.employee_id, e.last_name, e.salary
from employees e
    join departments d
        on e.department_id = d.department_id
where (d.department_id, e.salary) in (select department_id, MIN(salary)
                                      from employees
                                      group by department_id)     
order by d.department_id, e.last_name;
 
 
--13. EMPLOYEES 테이블에서 급여를 많이 받는 순서대로 조회했을 때 6번째부터 10 번째까지
--    직원의 last_name, first_name, salary를 조회하는 sql문장을 작성하시오.
select B.last_name, B.first_name, B.salary 
from(
    select rownum as RN, A.*
    from (
        select * from employees order by salary DESC
    ) A -- 정렬
) B     -- 순서RN
where RN between 6 and 10;  -- 6번째 10번째까지만 출력


--14) ‘Sales’ 부서에 속한 직원의 이름(first_name), 급여(salary), 
--    부서이름(department_name)을 조회하시오. 
--    단, 급여는 100번 부서의 평균보다 적게 받는 직원 정보만 출력되어야 한다.
select first_name, salary, department_name
from employees e
    join departments d
        on e.department_id = d.department_id
where department_name = 'Sales' and salary < (select AVG(salary)
                                             from employees
                                             where department_id=100);

--15) 부서별 입사월별 직원수를 출력하시오. 
--    단, 직원수가 5명 이상인 부서만 출력되어야 하며 출력결과는 부서이름 순으로 한다. 
--    (결과에서 5명이상 또는 부서원 5명이상)
select d.department_name, TO_CHAR(e.hire_date,'MM'), count(*) 
from employees e
    join departments d
        on e.department_id = d.department_id
group by d.department_name, TO_CHAR(e.hire_date,'MM')
having count(*) >= 5
order by d.department_name;

--16) 커미션(commission_pct)을 가장 많이 받은 상위 4명의 
--    부서명(department_name), 직원명 (first_name), 급여(salary),
--    커미션(commission_pct) 정보를 조회하시오. 
--    출력결과는 커미션을 많이 받는 순서로 출력하되 동일한 커미션에 대해서는 급여가 높은
--    직원이 먼저 출력 되게 한다.
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