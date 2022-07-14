--1. departments 테이블에 있는 manager_id 와 employees 테이블의 employee_id를 이용하여
--   조인하여 부서명, 매니저번호, 매니저이름 , 전화번호를 나타내어라.
SELECT d.department_name                 부서명,
       d.manager_id                      매니저번호,
       e.last_name||' '||e.first_name    "매니저이름(직원이름)",
       e.phone_number                    전화번호
FROM departments d
    JOIN employees e
        ON d.manager_id = e.employee_id;

--2. 조인을 이용하여 사원들의 직원번호(employee_id), 고용일자(hire_date), 
--   직종(job_id), 직책(job_title)을 출력하시오.
SELECT e.employee_id 직원번호,
       e.hire_date 고용일자, 
       j.job_id 직종, 
       j.job_title 직책 
FROM employees e
    JOIN jobs j
        ON e.job_id = j.job_id;
    
--3. 직책(job_title)이 'Sales Manager'인 사원들의 입사년도 그룹 별? 평균 급여를 출력하시오. 
--   입사년도를 기준으로 오름차순 정렬
--   (jobs 테이블과 조인  job_id 를 이용 , 입사년도: TO_CHAR(e.hire_date, 'YYYY'))
select TO_CHAR(e.hire_date, 'YYYY') "입사년도",
       ROUND(AVG(salary)) "평균급여"
from employees e
    join jobs j
        on e.job_id = j.job_id
where j.job_title = 'Sales Manager'
group by TO_CHAR(e.hire_date, 'YYYY')
order by TO_CHAR(e.hire_date, 'YYYY');


--4. 각각의 도시(city)에 있는 모든 부서 직원들의 평균급여를 조회하고자 한다. 
--   평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 직원수를 출력하시오.  
--   단, 도시에 근무하는 직원이 10명 이상인 곳은 제외하고 조회하시오.
--   (Tips: 테이블 관계도를 보고 우선 어떤 테이블들을 조인해야 할지 결정한후 
--   SELECT * 에 테이블들을 조인해서 문제가 없는지 확인한후 GROUP BY절과 SELECT 절 작성 )
select l.city CITY, ROUND(AVG(e.salary)), count(*) 
from employees e
    join departments d
        on e.department_id = d.department_id
    join locations l
        on d.location_id = l.location_id
group by l.city
having count(*) < 10
order by ROUND(AVG(e.salary));


--5. 자신의 매니저 보다 급여를 많이 받는 직원들의 성(last_name), 
--   급여(salary)와 매니저의 last_name과 salary를 출력하라.
select e.employee_id, e.last_name, e.salary, m.last_name, m.salary
from employees e 
    join employees m 
        on e.manager_id = m.employee_id
where e.salary > m.salary;