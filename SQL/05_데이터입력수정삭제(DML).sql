-- 데이터 입력하기 INSERT
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (300, 'Game', 100, 1700); 

select * from departments;

desc departments;       -- DEPARTMENT_ID : 기본키 // DEPARTMENT_NAME : 기본키X 하지만 필수

-- 꼭 입력해야하는 열만 입력 (입력안한 열은 널 값)
INSERT INTO departments(department_id, department_name)
VALUES (280, 'Music');

INSERT INTO employees
VALUES (207, '펭수', '김', 'Peng', '515.129.1234', SYSDATE, 'IT_PROG', 9999, NULL, 205, 300);

select * from employees;
select * from employees where employee_id = 207;

--예제 1) departments 테이블에 다음과 같이 각각의 department_id, department_name,
--       manager_id가 200, location_id가 1700인 행을 3개 입력하세요.
INSERT INTO departments(department_id, department_name, manager_id, location_id)
values (271, 'Sample Dept 1', 200, 1700);

INSERT INTO departments(department_id, department_name, manager_id, location_id)
values (272, 'Sample Dept 2', 200, 1700);

INSERT INTO departments(department_id, department_name, manager_id, location_id)
values (273, 'Sample Dept 3', 200, 1700);


-- 데이터의 수정 UPDATE : 특정행을 업데이트 하므로 WHERE 절을 작성!!!
update departments
set manager_id = 200, location_id = 1700
where department_name = 'Music';


--예제) departments 테이블에서 department_id 150부터 200까지 부서번호의 manager_ID 를 100으로 수정하라.
update departments
set manager_id = 100
where department_id BETWEEN 150 and 200;

-- 데이터의 삭제 DELETE : 특정 행을 WHERE절을 넣어서 삭제
delete from departments
where department_name = 'Music';

-- DELETE 오류(외래키 삭제 에러) :employees 테이블에 department테이블의 'Game'부서에 참조하고 있어서 삭제가 불가
-- [펭수 직원이 게임 부서이기 떄문에 게임부서를 삭제시 펭수의 부서가 없어지므로]
delete from departments
where department_name = 'Game';

-- 펭수 삭제
-- 펭수가 삭제되어야 위에 DELETE절도 오류없이 실행 가능 
delete from employees
where first_name = '펭수';

-- WHERE절이 없으면 전체 테이블 내용 삭제
delete from job_history;

update employees
set salary = 100;

-- 그전 commit 상태로 되돌아감 (초기화)
ROLLBACK;
-- 영구저장
commit;


-- 문자형 데이터 타입 VARCHAR2
desc test;

insert into test values(1, 'abcdefghij1234567890');

-- 한글 유니코드는 오라클에서 3바이트, 영어나 숫자는 1바이트
insert into test values(2, '가나다라마바');
insert into test values(3, '가나다라마바');
-- 한자리 숫자만 가능해서 삽입 불가
insert into test values(33, '가나다라마바');


insert into test values(4, '현재날짜입력',SYSDATE);
insert into test values(5, '문자열로입력','22/03/07');

-- 테이블 이름 뒤에 삽입할 (열이름)만 붙여서 value() 뒤에도 값을 안 적어도 삽입 가능하도록 함
insert into test(id,name) values(6, '날짜입력안함');

select * from test;

delete from test;



