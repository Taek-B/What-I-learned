-- 관리자 계정(오라클관리자)으로 새로운 사용자 만들기
CREATE USER john IDENTIFIED BY 1234;     -- 새로운 유저:john / 비밀번호:1234

-- john에게 접속 권한을 주기 
-- GRANT 권한 TO 유저;
GRANT CREATE SESSION TO john;

-- 권한들의 묶음 : ROLE
-- ROLE(=CONNECT, RESOURCE, DBA) 그중에 CONNECT, RESOURCE를 신규 유저에게 주기
GRANT CONNECT, RESOURCE TO john;

-- 테이블 생성 권한
GRANt CREATE TABLE TO john;
-- 뷰 생성 권한
GRANt CREATE VIEW TO john;

GRANt CREATE VIEW TO scott;

-- 권한을 회수 / 없애는 방법
-- REVOKE 권한명 FROM 계정;

-- 뷰 생성 권한 회수
REVOKE CREATE VIEW FROM john;
-- 테이블 생성 권한 회수
REVOKE CREATE TABLE FROM john;
-- 객체 생성 수정 삭제 권한 제거
revoke resource from john;

-- 계정 삭제(관련된 모든 내용 삭제)
DROP USER john CASCADE;     -- 계정 접속 해제한 후 삭제 가능

-- 계정 비밀번호 변경
-- ALTER USER 계정명 IDENTIFIED BY 변경할비밀번호
ALTER USER john IDENTIFIED BY oracle;

-----------------------------------------------------------------------------

-- PL/SQL
-- 익명블록

-- 출력을 위한 옵셥
SET SERVEROUTPUT ON;  

BEGIN
    DBMS_OUTPUT.PUT_LINE('헬로우월드!');
END;
/       
-- 주석을 PL/SQL 옆에 달지 말기
-- 위아래 구분하기 위해 '/'를 써줌

-- := 변수에 입력
DECLARE
    l_message VARCHAR2( 100 ) := '변수에 입력';  
BEGIN
    DBMS_OUTPUT.PUT_LINE( l_message );
END;
/

DECLARE
    v_name  emp.ename%TYPE;
BEGIN
    v_name := '홍길동';
    DBMS_OUTPUT.PUT_LINE( v_name );
END;
/

-- 1
CREATE OR REPLACE PROCEDURE update_sal 
 (
    in_empno IN NUMBER
 )      
 IS 
 BEGIN 
   UPDATE emp 
   SET sal = sal  * 1.1 
   WHERE empno = in_empno; 
  -- COMMIT; 
 END update_sal; 
 / 
 
EXECUTE update_sal(7369);
EXEC UPDATE_sal(7499);

-- 2
-- adjust_salary(직원번호, 임금인상률%)
CREATE OR REPLACE PROCEDURE adjust_salary
    (
        in_empno IN emp.empno%TYPE,
        in_percent IN NUMBER
    ) 
IS
BEGIN
   -- 직원번호의 임금을 in_percent% 만큼 올림
   UPDATE emp
   SET sal = sal + sal * in_percent / 100
   WHERE empno = in_empno;
END;
/

select * from emp;
-- scott 직원의 월급을 10% 인상하라
EXECUTE adjust_salary(7839, 50);

-- 값 복구
UPDATE emp
SET sal = 5000
WHERE empno = 7839;

UPDATE emp
SET sal = 800
WHERE empno = 7369;

commit;


-- TEST 테이블에 100개의 데이터 입력
DECLARE
    v_cnt NUMBER := 1;
BEGIN
    -- 반복문(LOOP)
    LOOP
        INSERT INTO TEST(id, name)
        VALUES(v_cnt, '테스트'||to_char(v_cnt) );
    
        v_cnt := v_cnt+1;
    
        EXIT WHEN v_cnt > 100;
        -- 변수 v_cnt가 100이 넘으면 종료됨
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('데이터 입력 완료');
    DBMS_OUTPUT.PUT_LINE(v_cnt-1 || '개의 데이터가 입력되었습니다');

END; 
/

select * from TEST;