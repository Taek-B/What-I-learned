--1. ����) �μ���ȣ�� 10���� �μ��� ��� �� �����ȣ, �̸�, ������ ����϶�
select empno, ename, sal
from emp
where deptno = 10;

--2. ����) �����ȣ�� 7369�� ��� �� �̸�, �Ի���, �μ���ȣ�� ����϶�.
select ename,hiredate,deptno
from emp
where empno = 7369;

--3. ����) �̸��� ALLEN�� ����� ��� ������ ����϶�.
select *
from emp
where ename = 'ALLEN';

--4. ����) �Ի����� 81/02/20�� ����� �̸�, �μ���ȣ, ������ ����϶�.
select ename, deptno, sal
from emp
where hiredate=TO_DATE('1981-02-20','YY/MM/DD'); 


--5. ����) ������ MANAGER�� �ƴ� ����� ��� ������ ����϶�.
select *
from emp
where job != 'MANAGER';

--6. ����) �Ի����� 81/04/02 ���Ŀ� �Ի��� ����� ������ ����϶�.
select *
from emp
where hiredate >='81/04/02';

--7. ����) �޿��� $800 �̻��� ����� �̸�, �޿�, �μ���ȣ�� ����϶�.
select ename, sal, deptno
from emp
where sal >= 800;

--8. ����) �μ���ȣ�� 20�� �̻��� ����� ��� ������ ����϶�.
select *
from emp
where deptno >= 20;

--9. ����) �̸��� K�� �����ϴ� ������� ���� �̸��� ���� ����� ��� ������ ����϶�.
--   (���ڿ� �񱳽� ���ĺ������� ö�� �� �� 'B'>'A')
select *
from emp
where ename > 'L';

--10. ����) �Ի����� 81/12/09 ���� ���� �Ի��� ������� ��� ������ ����϶�.
select *
from emp
where hiredate <= '81/12/09' ;

--11. ����) ������ȣ�� 7698���� �۰ų� ���� ������� ������ȣ�� �̸��� ����϶�.
select empno, ename
from emp
where empno <= 7698;

--12. ����) �Ի����� 81/04/02 ���� ���ų� �ʰ� 82/12/09 ���� ���ų� ���� ����� �̸�,����, �μ���ȣ�� ����϶�.
select ename, sal, deptno
from emp
where hiredate BETWEEN '81/04/02' and '82/12/09';

--13. ����) �޿��� $1,600���� ũ�� $3,000���� ���� ������ �̸�, ����, �޿��� ����϶�.
select ename, job, sal
from emp
where sal > 1600 and sal < 3000;

--14. ����) ������ȣ�� 7654�� 7782 ���̰� �ƴ� ������ ��� ������ ����϶�.
select *
from emp
where empno NOT BETWEEN 7654 and 7782;

--15. ����) �̸��� B�� J ������ ��� ������ ������ ����϶�.
select *
from emp
where ename BETWEEN 'B' and 'J';

--16. ����) �Ի����� 81���� �ƴ� ��� ������ ��� ������ ����϶�.
select *
from emp
where hiredate NOT LIKE '81%';

select *
from emp
where TO_CHAR(hiredate,'YYYY') != '1981';

--17. ����) ������ MANAGER�̰ų� SALESMAN�� ������ ��� ������ ����϶�
select *
from emp
where job in ('MANAGER','SALESMAN');

--18. ����) �μ���ȣ�� 20, 30���� ������ ��� ������ �̸�, �����ȣ, �μ���ȣ�� ����϶�.
select ename, empno, deptno
from emp
where deptno not in (20,30);

--19. ����) �̸��� S�� �����ϴ� �������� �����ȣ, �̸�, �Ի���, �μ���ȣ�� ����϶�.
select empno, ename, hiredate, deptno
from emp
where ename like 'S%';

--20. ����) �Ի����� 81�⵵�� ����� ��� ������ ����϶�
select *
from emp
where hiredate LIKE '81%';

--21. ����) �̸� �� S�ڰ� �� �ִ� ����� ��� ������ ����϶�.
select *
from emp
where ename LIKE '%S%';

--22. ����) �̸��� M�� �����ϰ� ������ ���ڰ� N�� ����� ��� ������ ����϶�
--(��, �̸��� ��ü 6�ڸ��̴�. �ڸ����� �̿��� ���ϵ�ī�� '_' �� �̿�)
select *
from emp
where ename like 'M____N' ;

select *
from emp
where ename like 'M%' and ename like '%N';

--23. ����) �̸��� ù ��° ���ڴ� �������, �� ��° ���ڰ� A�� ����� ������ ����϶�.
select *
from emp
WHERE ename like '_A%';

--24. ����) Ŀ�̼��� NULL�� ����� ������ ����϶�.  ( IS NULL �Ǵ� IS NOT NULL ���)
select *
from emp
where comm IS NULL;

--25. ����) Ŀ�̼��� NULL�� �ƴ� ����� ��� ������ ����϶�. ( IS NULL �Ǵ� IS NOT NULL ���)
select *
from emp
where comm IS NOT NULL;

--26. ����) �μ��� 30�� �μ��̰� �޿��� $1,500 �̻��� ����� �̸�, �μ� ,������ ����϶�.
select ename,deptno,sal
from emp
where deptno=30 and sal >= 1500;

--27. ����) �̸��� ù ���ڰ� K�� �����ϰų� �μ���ȣ�� 30�� ����� �����ȣ, �̸�, �μ���ȣ�� ����϶�.
select empno, ename, deptno
from emp
where ename LIKE 'K%' OR deptno = 30;

--28. ����) �޿��� $1,500 �̻��̰� �μ���ȣ�� 30���� ��� �� ������MANAGER�� ����� ������ ����϶�
select *
from emp
where sal >=1500 and deptno=30 and job = 'MANAGER';

--?29. ����) �μ���ȣ�� 30�� ����� ��� ������ ����ϰ� ������ȣ�� SORT(����)�϶�.
select *
from emp
where deptno=30
order by empno;

--30. ����) �������� �޿��� ���� ������ SORT(����) �϶�.
select *
from emp
order by sal desc;

--31. ����) �μ���ȣ�� ASCENDING SORT�� �� �޿��� ���� ��� ������ ����϶�.
--( �Ѱ� �̻��� ���� ���Ľ� �޸�(,)�� ����մϴ�.)
select *
from emp 
order by deptno ASC , sal desc;


--32. ����) �μ���ȣ�� DESCENDING SORT�ϰ�, �̸� ������ ASCENDING SORT �޿� ������ DESCENDING SORT �϶�.
select deptno, ename, sal
from emp
order by deptno desc, ename, sal desc;

--33. 10���μ��� ��� �������� �޿��� 13%�� ���ʽ��� �����ϱ�� �Ͽ���. �̸�, �޿�, ���ʽ��ݾ�, �μ���ȣ�� ����϶�
--( �Ҽ����� �ݿø���.)
select ename, sal, ROUND(sal*0.13) ���ʽ�, deptno
from emp
where deptno=10;

--34. ������ �̸�, �޿�, Ŀ�̼�, �Ѿ�(�޿�+Ŀ�̼�)�� ���Ͽ� �Ѿ��� ���� ������ ����Ͽ���.
--(��, Ŀ�̼��� null�� ����� 0���� �ؼ� ����.)
select ename, sal, NVL(comm,0), sal+NVL(comm,0) �Ѿ�
from emp
order by �Ѿ� desc;

--35. �޿��� $1,500���� $3,000 ������ ����� ���ؼ��� �޿��� 15%�� ȸ��� �����ϱ�� �Ͽ���.
--��� ����� �̸�, �޿�, ȸ��(�Ҽ����� 2�ڸ����� �ݿø�)�� ����Ͽ���.
--(��, ȸ��� �޷�ǥ��$�� �����ϰ� �Ҽ��� 1�ڸ����� ���)
select ename, sal, TO_CHAR((sal*0.15),'$9999.9') ȸ��
from emp
where sal BETWEEN 1500 and 3000;


--36. ������� 5���� �Ѵ� �μ��� �μ���� ����� ��ȸ (�����ʿ�)
select d.dname, count(*)
from emp e    
join dept d
    on d.deptno = e.deptno
group by d.dname
having count(*) > 5;


--37. ������ �޿��հ谡  5000�� �ʰ��ϴ� �� ������ ���ؼ� ������  �޿� �հ踦 ��ȸ  
--�� �Ǹſ�('SALESMAN')�� ����
select e.job , sum(sal)
from emp e join dept d
    on d.deptno = e.deptno
group by e.job
HAVING e.job != 'SALESMAN' AND SUM(sal) >5000;

--38. ������� �����ȣ(empno), �����(ename), �޿�(sal), �޿����(grade)�� ����Ͻÿ�.
--(���̺� salgrade �� ���� ���� )
select e.empno, e.ename, e.sal, s.grade
from emp e
    join salgrade s
        on e.sal between s.losal and s.hisal;
    
--39.  �μ���(deptno)�� ����� ���� Ŀ�̼�(comm)�� ���� ����� ���� ����Ͽ� ���ÿ�?
select d.deptno ,count(*) as ����� ,count(e.comm) as "Ŀ�̼� ���� �����"
from emp e join dept d
    on d.deptno = e.deptno
group by d.deptno;

--40.  �μ���ȣ(deptno)�� 10�� '�ѹ���', 20�� '���ߺ�', 30�� ������'��� �Ͽ� 
--�̸�, �μ���ȣ, �μ��� ������ ����Ͽ� ���ÿ�. (decode �� case �Լ� ���)
--(1)
select e.ename, d.deptno,
    case when d.deptno=10 then '�ѹ���'
         when d.deptno=20 then '���ߺ�'
         else                  '������'
    end "�μ���"
from emp e 
    join dept d
        on d.deptno = e.deptno;
--(2)       
select e.ename, d.deptno,
    decode(d.deptno, 10, '�ѹ���'
                   , 20, '���ߺ�'
                   , 30, '������'
                       , '') �μ���
from emp e 
    join dept d
        on d.deptno = e.deptno;
--(3)   
select ename, deptno,
    decode(deptno, 10, '�ѹ���'
                   , 20, '���ߺ�'
                   , 30, '������'
                ) �μ���
from emp;




