-- 단일행 함수

-- 문자함수
-- 대소문자 변환함수
SELECT UPPER('SQL Course'),
       LOWER('SQL Course'),
       INITCAP('SQL Course')
FROM DUAL;  -- 테스트용 테이블(1행만 나옴)을 이용하여 연습

-- 문자 조작 함수
SELECT CONCAT('헬로우','월드'),
       SUBSTR('ABCDEFG',3,4),
       LENGTH('ABCDEFG'),
       INSTR('ABCDEFG','D')       
FROM DUAL;

-- 공백 없애기 TRIM(문자열) 문자열 앞뒤의 공백을 제거
SELECT TRIM('   헬로우     '), '     헬로우   ' FROM DUAL;

-- 문자형 함수 예제
SELECT department_id, last_name, department_id
FROM employees
WHERE lower(last_name) = 'higgins';   -- 대소문자가 섞여 있을 경우 변환해서 조회가능

-- 문자열 바꾸기
SELECT job_id, replace(job_id, 'ACCOUNT', 'ACCNT') 적용결과
FROM employees;

-- 예제(1~2)
SELECT last_name 이름, LOWER(last_name) LOWER적용, UPPER(last_name) UPPER적용, email 이메일, INITCAP(email) INITCAP적용
FROM employees;

SELECT job_id 직업명, SUBSTR(job_id,1,2) 앞의2개
FROM employees; 

-- 숫자 함수
-- ROUND함수는 반올림을 해서 소수점 자릿수까지 출력 (number의 소수점자리에서 +1한 자리에서  반올림)
SELECT ROUND(15.193,1) 소수첫째,
       ROUND(15.193,0) 정수,
       ROUND(15.193) 자릿수없음,
       ROUND(15.193,-1)"10의자리"
FROM DUAL;
 
-- TRUNC함수 : 버림 (number의 소수점자리까지 나타남)
SELECT TRUNC(15.193,1) 소수첫째
FROM DUAL;

-- MOD함수 : 나누기 후 나머지를 구함
-- 직원번호가 짝수인 직원들을 정렬
SELECT employee_id 짝수, last_name
FROM employees
WHERE MOD( employee_id, 2) = 0
ORDER BY employee_id;

-- 예제
SELECT salary, ROUND(salary/30) 정수, ROUND(salary/30,1) 소수1, ROUND(salary/30,-1) "10의자리"
FROM employees;

-- 날짜형 함수
SELECT sysdate FROM DUAL;
-- 날짜를 반올림 일(시간을 반올림), 월은 날짜를 반올림, 년은 월을 반올림 (반올림 하면 1로 초기화됨)
SELECT ROUND(sysdate, 'DD') 일,
       ROUND(sysdate, 'MM') 월,
       ROUND(sysdate, 'YYYY') 년도,
       MONTHS_BETWEEN('2017/10/10', '2017/07/10') 월차이,
       ADD_MONTHS('2017/07/10', 3) 애드먼쓰
FROM DUAL;
-- 날짜와 숫자 계산법
SELECT sysdate-1 어제, sysdate 오늘, sysdate+1 내일
FROM DUAL;
-- 90번 부서 직원들의 오늘까지의 근무일수는 (현재 날짜 - 고용일)
SELECT last_name 이름 , FLOOR(sysdate - hire_date) 근무일수
FROM employees
WHERE department_id = 90;

-- 근무월수가 200개월이 안된 직원들
SELECT employee_id, hire_date,
       FLOOR(MONTHS_BETWEEN(SYSDATE, hire_date)) 근무월수,
       ADD_MONTHS(hire_date,6) "6개월 추가",
       NEXT_DAY(hire_date, '금요일') Next_day,
       --1(일), 2(월), 3(화), 4(수), 5(목), 6(금), 7(토)
       LAST_DAY(hire_date) Last_day
       --달의 마지막 날
FROM employees
WHERE MONTHS_BETWEEN(sysdate, hire_date) < 200;

--예제(1~2)
SELECT sysdate 오늘, hire_date, MONTHS_BETWEEN(sysdate, hire_date) 월차이
FROM employees
WHERE department_id = 100;

SELECT hire_date, ADD_MONTHS(hire_date,3) "3개월 더한 값", ADD_MONTHS(hire_date,-3) "3개월 뺀 값" 
FROM employees
WHERE employee_id BETWEEN 100 AND 106;

-- 변화형 함수 (날짜, 숫자, 문자를 변환하는 함수)

-- 숫자를 문자로 변환
-- 콤마 예제
SELECT TO_CHAR(12345678,'999,999,999') comma 
FROM DUAL;
-- 소숫점 예제  
SELECT TO_CHAR(123.45678,'999,999,999.99') period 
FROM DUAL; 
-- $ 표시 예제
SELECT TO_CHAR(12345678,'$999,999,999') dollar  
FROM DUAL;
-- Local 화폐 표시 예제 (한국의 경우 ￦로 자동 변환 됨)
SELECT TO_CHAR(12345678,'L999,999,999') local  
FROM DUAL;
-- 왼쪽에 0을 삽입
SELECT TO_CHAR(123,'09999') zero 
FROM DUAL;  
-- 16진수로 변환
SELECT TO_CHAR(123,'XXXX') hexadecimal  
FROM DUAL;

-- 날짜를 문자로 변환
-- 년,월,일,시,분,초 예제
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "sysdate"
FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') "현재날짜"
FROM DUAL; 

-- 예제(1~2)
SELECT employee_id, TO_CHAR(hire_date, 'MM/DD') 입사월
FROM employees
WHERE department_id = 100;

SELECT last_name 이름, TO_CHAR(salary,'$99,999.99')  월급
FROM employees
WHERE salary > 10000
ORDER BY salary DESC;

-- TO_DATE 문자열을 날짜로 변환
-- DATE 타입으로 변환하는 예제
SELECT TO_DATE('2011-01-01','YYYY-MM-DD')
FROM DUAL;

-- TO_NUMBER 문자열을 숫자로 변환
SELECT TO_NUMBER('01210616') + 10
FROM DUAL; 

-- NULL 관련 함수
-- NVL함수 : NULL값을 다른 값으로 바꿀 때 사용
SELECT last_name, NVL(manager_id, 0) 매니저
FROM employees
WHERE last_name = 'King';

-- NVL2( 값, 첫번째, 두번째) => 만약 값이 NULL이 아닐 경우에는 첫번째 값을 반환 하고, NULL일 경우에는 두번째 값을 반환 한다.
SELECT last_name, NVL2(manager_id, 1, 0) 매니저
FROM employees
WHERE last_name = 'King';

-- 예제) employees 테이블에서 아래와 같이 이름, 월급(salary),커미션(commission_pct)를  NVL 함수사용, 연봉은 ( 월급*12) + (월급*12*커미션) 이다.
SELECT last_name 이름, salary 월급, NVL(commission_pct, 0) 커미션,
       (salary*12)+ NVL(commission_pct,0)*(salary*12) 연봉
FROM employees ORDER BY 연봉 DESC;

-- 예제) 위의 예제에 더하여 연봉계산은 NVL2 함수를 사용하여 커미션이 있을때와 없을때 계산방법을 나타냅니다.
SELECT last_name 이름, salary 월급, NVL(commission_pct, 0) 커미션,
       (salary*12)+ NVL(commission_pct,0)*(salary*12) 연봉,
       NVL2(commission_pct, 'SAL+COMM','COMM') 연봉계산
FROM employees ORDER BY 연봉 DESC;

-- 디코드 decode 함수
SELECT last_name 이름, job_id, salary,
    DECODE(job_id, 'IT_PROG',  salary * 1.10,
                   'ST_CLERK', salary * 1.15,
                   'SA_REP',   salary * 1.20,
                               salary)  "수정월급"
FROM employees;

-- 예제) employees 테이블에서 DECODE 함수를 이용해서 월급에 따른 세율을 나타내세요.
-- TRUNC( salary / 2000 ) 의 값이 0일때 0%, 1일때  9%, ...
SELECT last_name 이름, job_id 직무, salary 월급,
       DECODE( TRUNC(salary/2000), 0, 0,
                                   1, 0.09,
                                   2, 0.2,
                                   3, 0.3,
                                   4, 0.4,
                                   5, 0.42,
                                   6, 0.44,
                                      0.45) 세율
FROM employees;

-- CASE함수
SELECT last_name 이름, job_id, salary,
    CASE  WHEN salary<5000   THEN 'Low'
          WHEN salary<10000  THEN 'Medium'
          WHEN salary<20000  THEN 'Good'
          ELSE                    'Excellent'  
    END "급여 수준"
FROM employees;

-- 예제) employees 테이블에서 job_id가 IT_PROG라면 employee_id, first_name, last_name, salary를
--      출력하되 salary가 9000 이상이면 ‘상위급여’, 6000과 8999 사이면 ‘중위급여’, 그 외는 ‘하위급여’라고 출력하세요.
SELECT employee_id, first_name, last_name, salary,
    CASE WHEN salary >= 9000 THEN '상위급여'
         WHEN salary >= 6000 THEN '중위급여'
         ELSE                     '하위급여'
    END "급여등급"
FROM employees WHERE job_id='IT_PROG';