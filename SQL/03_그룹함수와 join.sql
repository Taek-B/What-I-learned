-- 그룹함수 (다중행 함수, 집계함수)
SELECT ROUND(AVG(salary)) 평균값,
       MAX(salary) 최대값,
       MIN(salary) 최소값, 
       SUM(salary) 합계,
       COUNT(salary) 카운트
FROM employees
WHERE job_id LIKE '%REP%';

SELECT * FROM employees WHERE job_id LIKE '%REP%';

-- 카운트 count : 행의 갯수를 출력하는데 NULL값을 제외 단(*)일때는 전체 카운트
SELECT COUNT(commission_pct)
FROM employees;

SELECT COUNT( DISTINCT department_id)
FROM employees;
-- 집계함수들은 NULL값을 제외하고 계산됨
SELECT AVG(commission_pct)
FROM employees;
-- 전체 평균(없는 사람 0)
SELECT AVG(NVL(commission_pct,0))
FROM employees;

-- GROUP BY 절 : 특정 그룹으로 나누어서 그룹함수를 사용
SELECT department_id 부서번호,
       ROUND(AVG(salary)) 평균급여
FROM employees
GROUP BY department_id
ORDER BY 부서번호; -- 부서번호로 그룹나눔

-- 그룹열이 여러개일 때 
SELECT department_id 부서번호, job_id 직종, ROUND(AVG(salary), 1) 평균월급
FROM employees
GROUP BY department_id, job_id
ORDER BY 부서번호;

-- 예제 1)  부서별 사원수, 최대급여, 최소급여, 급여합계, 평균급여를 급여합계 큰순으로 조회
SELECT department_id 부서명, 
       COUNT(*) 사원수, 
       MAX(salary) 최대급여, 
       MIN(salary) 최대급여,
       SUM(salary) 급여합계,
       ROUND(AVG(salary)) 평균급여
FROM employees
GROUP BY department_id
ORDER BY 급여합계 DESC;

-- 예제 2)  부서별, 직업별(job_id) 별로 그룹을 지어 salary 합계와 그룹별 직원의 숫자를 출력하라.
SELECT department_id 부서번호,
       job_id 직종,
       SUM(salary),
       COUNT(*) 직원수
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

-- 예제 3) 부서별로 최고 월급을 뽑아서 평균을 내고, 최저월급 또한 평균을 내어 출력하라.
SELECT ROUND(AVG(MAX(salary))) 부서별최고월급평균, 
       ROUND(AVG(MIN(salary))) 부서별최저월급평균
FROM employees
GROUP BY department_id;

-- 그룹 함수의 조건절 HAVING
SELECT department_id 부서명, COUNT(*) 사원수
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;  -- 사원수 5명이 넘는 부서

-- 예제 1) 아래 예제는 직종별 평균 월급이 $10000을 초과하는 직종에 대해서 job_id와  
-- 월급여 합계를 조회하는 예이다. 단 어카운트 매니저( AC_MGR )은 제외하고 월 급여 합계로 내림차순 정렬하시오.
SELECT job_id 직종, SUM(salary) 월급여합계
FROM employees WHERE job_id != 'AC_MGR'
GROUP BY job_id
HAVING AVG(salary) > 10000 
ORDER BY 월급여합계 DESC;

-- 예제 2) 부서번호 40을 제외한 부서별 평균 급여가 7000 이하인 부서들의 평균 급여를 출력
SELECT department_id 부서번호, ROUND(AVG(salary)) 평균급여
FROM employees
GROUP BY department_id
HAVING AVG(salary) <= 7000 AND department_id != 40;

-- 예제 3) 직종별로 월급(salary)의 합계가 13000 이상인 직종을 출력하라. 
-- 급여총액으로 내림차순으로 정렬하고, 직종(job_id)에 'REP' 들어있는 직종은 제외한다.
SELECT job_id, SUM(salary) 급여총액
FROM employees
GROUP BY job_id
HAVING SUM(salary) >= 13000 AND job_id NOT LIKE '%REP%'
ORDER BY 급여총액 DESC;

-- 조인 (JOIN)
SELECT e.employee_id 직원번호, e.last_name 직원이름,
       d.department_id 부서번호, d.department_name 부서명
FROM employees e JOIN departments d
ON e.department_id  = d.department_id;
-- 3개 테이블 조인
SELECT employee_id, city, department_name
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id
JOIN locations l
    ON d.location_id = l.location_id;

-- WHERE절은 조인 다음에 적는다.
SELECT e.employee_id, e.last_name,
       d.department_id, d.location_id
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id
WHERE d.department_id = 50
    AND e.salary > 5000;


-- 예제) 부서명(department_name) , 시티명(city), 국가명(country_name)을 나타내는 테이블을 출력합니다. 
-- 테이블들은 countries 와 departments와 locations를 조인 합니다. 
-- 조건은, 시티가 'Seattle' 혹은 'London' 이어야 하고 국가명은 앞쪽에 'United' 가 들어가야 합니다.
SELECT d.department_name 부서명, l.city 시티명, c.country_name 국가명
FROM departments d
JOIN locations l
    ON l.location_id = d.location_id
JOIN countries c
    ON c.country_id = l.country_id
WHERE l.city IN ('Seattle', 'London') AND c.country_name LIKE 'United%';

-- 자체 조인
select e.last_name 직원, e.phone_number 직원번호 , m.last_name 매니저 , m.phone_number 매니저번호
FROM employees e  
JOIN employees m
    ON e.manager_id = m.employee_id
ORDER BY m.last_name;
    
-- 외부 조인
-- LEFT OUTER JOIN
select e.last_name 직원, e.department_id 부서번호, d.department_name 부서명
FROM employees e 
LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
ORDER BY 부서번호 DESC;

-- RIGHT OUTER JOIN
select e.last_name 직원, e.department_id 부서번호, d.department_name 부서명
FROM employees e 
RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id
ORDER BY 부서번호 DESC;


-- FULL OUTER JOIN
select e.last_name 직원, e.department_id 부서번호, d.department_name 부서명
FROM employees e 
FULL OUTER JOIN departments d
    ON e.department_id = d.department_id
ORDER BY 부서번호 DESC;

-- 예제)countries , locations 테이블을 조인하여 아래와 같이 출력하시오.(지역번호로 DESC 정렬)
-- country_name 국가, country_id 국가번호, location_id 지역번호, city 도시
SELECT c.country_name 국가, c.country_id 국가번호, l.location_id 지역번호, l.city 도시
FROM countries c left OUTER JOIN locations l ON c.country_id = l.country_id
ORDER BY 지역번호 DESC;


-- 교차 조인(CROSS JOIN)
-- 예제) countries , regions 테이블을 크로스 조인하여 아래와 같이 각각의 테이블의 25행 X 4행 => 100행의 결과가 나오도록 하세요.
SELECT c.country_name 국가, r.region_name 지역이름
FROM countries c CROSS JOIN regions r; 


