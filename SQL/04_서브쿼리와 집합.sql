--서브 쿼리

--Popp 직원보다 고용일이 최근(이후)에 고용한 사람
--주의점 : 단일행 서브쿼리를 사용할때는 서브쿼리의 결과가 비교하는 데이터와 같고 하나만 출력되어야 한다.

--()괄호 안에 수식이 값이 2개이면 서브쿼리로 썼을 때 Error가 난다. 
-- WHERE last_name = 'Smith' // Error O
-- WHERE last_name = 'Popp'  // Error X
SELECT last_name 이름, hire_date 고용일자
FROM employees
WHERE hire_date > ( SELECT hire_date
                    FROM   employees
                    WHERE last_name = 'Smith')
order by 고용일자;
 
-- 그룹함수의 결과를 서브쿼리로 사용 
SELECT last_name 이름, job_id 직종, salary 급여
FROM employees
WHERE salary =    ( SELECT min(salary)
                    FROM employees);
  
--예제)  사원 'Abel'(last_name) 보다 급여가 많은 사원의 last_name , salary 를 나타내어라.
--      (서브쿼리 사용)
select last_name 이름,  salary 급여
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');

--예제) 'Bull'란 last_name을 가진 사원의 부서에서 Bull보다 
--     높은 급여를 받는 사원들을 출력하라.  (서브쿼리 사용)
select employee_id 직원번호, last_name 이름, department_id 부서번호, salary 급여
from employees
where salary > (select salary
                from employees
                where last_name = 'Bull')
and department_id = (select department_id
                from employees
                where last_name = 'Bull');


--예제) 'Russell'이란 last_name의 직원번호를 manager_id로 가지는 
--     직원들의 last_name, salary, manager_id를 출력하시오.
select last_name 이름, salary 급여, manager_id 매니저
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name='Russell' );
                    
--예제) jobs 테이블에 job_title이 'Stock Manager' 의  job_id를 가진 
--     직원들의 정보를 Employees 테이블에서 찾아서 출력하시오.
select *
from employees
where job_id = (select job_id
                from jobs
                where job_title = 'Stock Manager');
               
                
-- 다중행 서브쿼리 (서브쿼리 결과가 여러개의 행으로 출력)

SELECT MIN(salary) FROM employees GROUP BY department_id;   -- 부서별 최저월급

-- IN 연산자 : 값이 하나만 일치하면 검색됨
SELECT department_id ,employee_id, last_name
FROM employees
WHERE salary  in (SELECT MIN(salary) FROM employees GROUP BY department_id)
order by department_id;

-- ANY 연산자 : 값이 하나라도 맞으면 검색됨
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary  < ANY ( SELECT salary FROM employees WHERE job_id = 'IT_PROG')
    AND job_id <> 'IT_PROG'
ORDER BY salary DESC;

-- ALL 연산자 : 값이 전부 참이 되어야 검색됨
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary  < ALL ( SELECT salary FROM employees WHERE job_id = 'IT_PROG')
    AND job_id <> 'IT_PROG'
ORDER BY salary DESC;


--예제 1) 부서번호(department_id)가  20번인 직원들의 매니저아이디(manager_id)와 
--       같은 매니저를 가지는  직원들을 출력하라. (단 20번 부서의 직원은 제외!)
select employee_id, first_name, job_id, salary
from employees
where manager_id  in (select manager_id
                      from employees
                      where department_id = 20);

--예제 2) job_id가  'ST_MAN'인 직원들중 어느 한직원 보다도 
--       급여가 작은 직원들을 출력하라. (ANY)
select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary
                    from employees
                    where job_id = 'ST_MAN');

--?예제 3) 직책이 'IT_PROG' 인 직원들 보다 급여가 작은 직원들을 출력하시오.(ALL)
select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                    from employees
                    where job_id='IT_PROG');


-- 다중열 서브쿼리
SELECT employee_id, first_name, job_id, salary, manager_id
FROM employees
WHERE (manager_id, job_id) IN  (SELECT manager_id, job_id
                                FROM employees
                                WHERE first_name = 'Bruce')
AND first_name <> 'Bruce';

-- 부서별 최저 급여 사원의 정보를 출력
select department_id 부서번호, employee_id 사원번호, first_name, salary
from employees
where (department_id, salary) in  (select department_id, min(salary)
                                   from employees
                                   group by department_id)
order by department_id;

--예제) employees 테이블에서 job_id별로 가장 낮은 salary가 얼마인지 찾아보고, 
--     찾아낸 job_id별 salary에 해당하는 직원의 first_name, job_id, salary, department_id 를 
--     출력하시오. (salary 내림차순 정렬)
select first_name, job_id, salary, department_id
from employees
where (job_id, salary) in (select job_id, min(salary)
                           from employees
                           group by job_id)
order by salary DESC;



-- 집합연산자
select * from employees;        -- 107행
select * from job_history;      -- 10행

-- UNION을 이용한 합집합
select employee_id, job_id
from employees
union
select employee_id, job_id
from job_history;
 
-- UNION ALL을 이용한 합집합(교집합 제거하지 않음)
select employee_id, job_id
from employees
union all
select employee_id, job_id
from job_history;

-- INTERSECT을 이용한 교집합
select employee_id, job_id
from employees
INTERSECT
select employee_id, job_id
from job_history;

-- MINUS를 이용한 차집합
select employee_id, job_id
from employees
MINUS
select employee_id, job_id
from job_history;

--예제) ?employees 테이블의 department_id 집합과 departments 테이블의 
--     department_id 집합을 UNION 연산자를 이용해 합쳐 보세요.
select department_id
from employees
UNION
select department_id
from departments;       -- 28행

--예제) employees 테이블의 department_id 집합과 departments 테이블의 
--     department_id 집합을 UNION ALL연산자를 이용해 합쳐 보세요.
select department_id
from employees
UNION ALL
select department_id
from departments;       -- 134행 = 107 + 27 (중복까지 합쳐서?)

--예제) employees 테이블의 department_id 집합과 departments 테이블의 
--     department_id 집합의 교집합을 INTERSECT 연산자를 이용해 출력해 보세요.
select department_id
from employees
INTERSECT
select department_id
from departments;       -- 11행

--예제) departments 테이블의 department_id 집합에서 employees 테이블의 
--     department_id 집합을 MINUS 연산자를 이용해 빼 보세요.
select department_id
from employees
MINUS
select department_id
from departments;       -- 1행    

select department_id
from departments
MINUS
select department_id
from employees;       -- 16행    


