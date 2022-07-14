-- SELECT문 조회
-- 부서 테이블에 모든 열 조회
select * from departments;
-- AS는 별칭이고 조회할 열이름만 검색가능
select department_name AS 부서이름
from departments;
-- 우선 테이블명을 from에 적고 CTRL+space 자동으로 열이름을 불러온다.
SELECT department_id 부서번호,department_id 부서이름
from departments;

-- 직원 테이블 월급
select salary 월급
from employees;
-- 전체 직원 월급에 100 추가 해서 새 열만들기
select last_name 이름, salary 월급, salary + 100 보너스월급
from employees;
-- 전체 직원 월급에 -10% 해서 새 열만들기
select last_name 이름, salary 월급, salary - salary*0.10 새월급
from employees;

-- 중복값 제거 DISTINCT
-- 직업의 종류만 조회
SELECT DISTINCT job_id 직업
FROM employees;

-- 예제1) employees테이블에서 employee_id, first_name, last_name을 출력하세요.
SELECT employee_id, first_name, last_name 
from employees;
-- 예제2) employees테이블에서 first_name, salary, salary*1.1 AS 뉴셀러리 출력하세요.
SELECT first_name, salary, salary*1.1 뉴셀러리 
from employees;
-- 예제3) employees테이블에서 employee_id는 '사원번호', first_name은 '이름', last_name은 '성'으로 출력하세요.
SELECT employee_id 사원번호, first_name 이름, last_name 성 
from employees;

-- 연결 연산자 || (문자열을 합침)
select employee_id, first_name||' '||last_name 풀네임
from employees;

-- 예제4)
select employee_id, first_name||' '||last_name 풀네임, email||'@company.com' email
from employees;

desc employees;

-- Where절 (조건문)
-- 직원들중 월급이 14000이상인 직원
SELECT *
FROM employees
WHERE salary > 14000;
-- 이름이 king인 사람
SELECT *
FROM employees
WHERE last_name = 'King';   -- 문자열은''한 따움표를 꼭 붙이고 대소문자를 가림

-- 고용일자가 2002년 6월 10일 이전인 직원
SELECT *
FROM employees
WHERE hire_date < '2002/06/10';  -- 오라클에서 문자열안에 날짜형식으로 적으면 자동 변환됨

-- Where절 예제(1~5)
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

-- 논리연산자
-- 80번부서이면서 월급이 10000보다 많은 직원 또는 60번부서 직원
SELECT last_name, department_id, salary
FROM employees
WHERE department_id = 60 OR (department_id=80 AND salary > 10000);

-- 부서번호는 80또는 60이면서 월급이 10000보다 큰 직원 
SELECT last_name, department_id, salary
FROM employees
WHERE (department_id = 60 OR department_id=80) AND salary > 10000;

-- NOT, AND, OR 연산자 예제(1~2)
SELECT *
FROM employees
WHERE salary > 4000 AND job_id ='IT_PROG';

SELECT *
FROM employees
WHERE salary > 4000 AND (job_id ='IT_PROG' OR job_id ='FI_ACCOUNT');

-- IN 연산자 OR를 여러개 쓰는 대신에 IN(a,b,c) 쓸 수 있다.
-- 월급이 2700 또는 3000또는 4000인 직원들 조회
SELECT *
FROM employees
WHERE salary IN (4000,3000,2700);

-- 예제(1~2)
SELECT *
FROM employees
WHERE salary IN (10000,17000,24000);

SELECT *
FROM employees
WHERE department_id NOT IN (30,50,80,100,110);

-- BETWEEN A and B (a와 b 사이)
SELECT *
FROM employees
WHERE salary BETWEEN 9000 AND 10000;

-- 예제(1~3)
SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 20000;

SELECT *
FROM employees
WHERE hire_date BETWEEN '2004/01/01' AND '2004/12/30';

SELECT *
FROM employees
WHERE salary NOT BETWEEN 7000 AND 17000; 

-- LIKE 연산자 문자열 조회시 명확하지 않을 경우 사용
-- #가 뒤에 있을 경우 : 이름이 대문자 B로 시작하는 모든 직원
SELECT *
FROM employees
WHERE last_name LIKE 'B%';

-- %가 앞뒤에 있을경우 : 사이값에 b가 있으면 전부 조회됨
SELECT *
FROM employees
WHERE last_name LIKE '%b%';

-- % 앞에 있을 경우 : 맨 뒷글자가 y로 끝나는 경우
SELECT *
FROM employees
WHERE last_name LIKE '%y';

-- 예제(1~5)
SELECT * FROM employees WHERE job_id LIKE '%AD%';
SELECT * FROM employees WHERE job_id LIKE '%AD___';
SELECT * FROM employees WHERE phone_number LIKE '%1234';
SELECT * FROM employees WHERE phone_number LIKE '%9' AND phone_number NOT LIKE '%3%';
SELECT * FROM employees WHERE job_id LIKE '%MGR%' OR job_id LIKE '%ASST%' ;

-- IS NULL 연산자
-- null : 값을 입력 안했을 때, 값이 없을 때( 0이나 공백''이 아니다.)
-- null을 검색하기 위해 IS NULL을 사용한다.
SELECT *
FROM employees
WHERE commission_pct IS NULL;

SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- 예제 매니저ID가 NULL인 직원을 조회하라
SELECT *
FROM employees
WHERE manager_id IS NOT NULL;

-- ORDER BY + 열 + ASC or DESC : 열의 오름차순 또는 내림차순으로 정렬
-- 월급이 큰 사람 순으로 정렬
SELECT *
FROM employees
ORDER BY last_name DESC;  -- ASC 작은순인데 생력 가능

-- 정렬 열이 2개 이상일 때 천번째 열로 정렬후 같은경우 두번째 일 정렬
-- 부서번호로 정렬한 후 사원번호로 정렬
SELECT department_id, employee_id, first_name, last_name
FROM employees
ORDER BY department_id, employee_id;

-- 연봉으로 정렬
SELECT department_id, last_name, salary*12 연봉
FROM employees
ORDER BY 연봉;

SELECT department_id, last_name, salary*12 연봉
FROM employees
ORDER BY 3 DESC;

-- 예제(1~3)
SELECT employee_id, first_name, last_name
FROM employees
ORDER BY employee_id DESC;

SELECT *
FROM employees
WHERE job_id LIKE '%CLERK%'
ORDER BY salary DESC;

SELECT employee_id 직원번호, last_name 직원이름, department_id 부서번호, salary 월급
FROM employees
WHERE employee_id BETWEEN 120 AND 150
ORDER BY 부서번호 DESC  , 월급 DESC; 

