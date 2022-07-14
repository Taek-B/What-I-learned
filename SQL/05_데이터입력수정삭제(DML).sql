-- ������ �Է��ϱ� INSERT
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (300, 'Game', 100, 1700); 

select * from departments;

desc departments;       -- DEPARTMENT_ID : �⺻Ű // DEPARTMENT_NAME : �⺻ŰX ������ �ʼ�

-- �� �Է��ؾ��ϴ� ���� �Է� (�Է¾��� ���� �� ��)
INSERT INTO departments(department_id, department_name)
VALUES (280, 'Music');

INSERT INTO employees
VALUES (207, '���', '��', 'Peng', '515.129.1234', SYSDATE, 'IT_PROG', 9999, NULL, 205, 300);

select * from employees;
select * from employees where employee_id = 207;

--���� 1) departments ���̺� ������ ���� ������ department_id, department_name,
--       manager_id�� 200, location_id�� 1700�� ���� 3�� �Է��ϼ���.
INSERT INTO departments(department_id, department_name, manager_id, location_id)
values (271, 'Sample Dept 1', 200, 1700);

INSERT INTO departments(department_id, department_name, manager_id, location_id)
values (272, 'Sample Dept 2', 200, 1700);

INSERT INTO departments(department_id, department_name, manager_id, location_id)
values (273, 'Sample Dept 3', 200, 1700);


-- �������� ���� UPDATE : Ư������ ������Ʈ �ϹǷ� WHERE ���� �ۼ�!!!
update departments
set manager_id = 200, location_id = 1700
where department_name = 'Music';


--����) departments ���̺��� department_id 150���� 200���� �μ���ȣ�� manager_ID �� 100���� �����϶�.
update departments
set manager_id = 100
where department_id BETWEEN 150 and 200;

-- �������� ���� DELETE : Ư�� ���� WHERE���� �־ ����
delete from departments
where department_name = 'Music';

-- DELETE ����(�ܷ�Ű ���� ����) :employees ���̺� department���̺��� 'Game'�μ��� �����ϰ� �־ ������ �Ұ�
-- [��� ������ ���� �μ��̱� ������ ���Ӻμ��� ������ ����� �μ��� �������Ƿ�]
delete from departments
where department_name = 'Game';

-- ��� ����
-- ����� �����Ǿ�� ���� DELETE���� �������� ���� ���� 
delete from employees
where first_name = '���';

-- WHERE���� ������ ��ü ���̺� ���� ����
delete from job_history;

update employees
set salary = 100;

-- ���� commit ���·� �ǵ��ư� (�ʱ�ȭ)
ROLLBACK;
-- ��������
commit;


-- ������ ������ Ÿ�� VARCHAR2
desc test;

insert into test values(1, 'abcdefghij1234567890');

-- �ѱ� �����ڵ�� ����Ŭ���� 3����Ʈ, ��� ���ڴ� 1����Ʈ
insert into test values(2, '�����ٶ󸶹�');
insert into test values(3, '�����ٶ󸶹�');
-- ���ڸ� ���ڸ� �����ؼ� ���� �Ұ�
insert into test values(33, '�����ٶ󸶹�');


insert into test values(4, '���糯¥�Է�',SYSDATE);
insert into test values(5, '���ڿ����Է�','22/03/07');

-- ���̺� �̸� �ڿ� ������ (���̸�)�� �ٿ��� value() �ڿ��� ���� �� ��� ���� �����ϵ��� ��
insert into test(id,name) values(6, '��¥�Է¾���');

select * from test;

delete from test;



