select rownum, a.* from( select * from member order by id asc ) a   --()먼저 실행 -> 길어짐
where rrum>=1 and rownum<=10  -- 첫 select : rnum 사용불가-> row_nuber 사용해야함
;

-- rnum
select * from( select row_number(),r* from member order by id asc ) a  
where rnum>=11 and rownum<=20  
;

--sleect from* 테이블명
-- select * from (select 조건문)



-- 1. employees 테이블에서 이름에 a 가 들어가있는 사람을 출력하시오.
select * from employees where emp_name not like '%a%';

-- 2. 그 가운데, 월급 7000달러 이상인 사람을 출력하시오.
select * from (select * from employees where emp_name not like '%a%')
where salary>=7000;  -- ():a가 들어있는 사람중  
-- table자리에 select 들어올수 있음

select * from (select * from (select * from employees where emp_name not like '%a%')
where salary>=7000)
where hire_date>='2004/01/01';



---- 다른 풀이 방법 ----
select * from employees
where emp_name like '%a%' and salary>=7000;




select row_number() over(order by id asc),a.*from member a -- order by실행 후 roe_number 실행

;

select * from member;

select * from member
order by id asc;

select * from member
order by id asc; -- id로 정렬

select rownum,a.* from member a
order by id asc; -- 번호(rownum)로 정렬

select rownum,a.* from
(select * from member) a
;

-- 정렬이 없는 경우
select rownum,a.* from member a; --a테이블에 대한 모든것을 찍어달라는 의미
-- select rownum, * from member;  -- error

-- 정렬이 있는 경우
select row_number() over(order by id asc) ,a.* from member a;


------------------------------------------------------------------------
-- rank() over(), dense_rank() over()
select rank() over(order by total desc),name,total from stuscore;  -- 동점시:11등,12등,12등,13등,...
select rank() over(order by total desc),dense_rank() over(order by total desc)name,total from stuscore;

select rank() over(order by name asc) ranks,name,total from stuscore;  
--이름순으로 번호가 매겨짐 ->total이 있다고 해서 총점으로 등수가 매겨지지않음

---------------------------------------------------
select * from stuscore;

alter table stuscore add rank number(3) default '0'; -- default '0' :입력을 안하면 자동으로 0을 넣으라는 의미

select rank() over(order by total desc) ranks,sno,name,total,rank from stuscore; -- 등수
select rank() over(order by total desc) ranks from stuscore;

select sno from stuscore;
select sno,rank(); 

-- rank수정하는 update 명령어
update stuscore a set rank=
(
select ranks from(

select sno,rank() over(order by total desc) ranks from stuscore
)b 
where a.sno=b.sno
)
;

-- where sno=101;

select * from stuscore3;

create table stuscore3 as select * from stuscore;

update stuscore3 set rank = 0;

commit;

alter table stuscore3 add grade nchar(1) default 'D';

select * from stuscore3;

-- non equi 조인으로
-- stuscore3, scoregrade 테이블 두개 조인
-- avg를 기준으로 90.0~100 : A, 80~89.999 : B, C, D, F grade테이블에 수정해서 값을 입력하세요.
select * from scoregrade;
select * from stuscore3;  -- grade점수를 'select * from scoregrade;'로

commit;



select * from stuscore3;


select name,avg,a.grade,b.grade from stuscore3 a,scoregrade b
where avg between lowgrade and highgrade;

update stuscore3 set grade = '';






update stuscore3 set grade = (
select grade from scoregrade
where avg between lowgrade and highgrade 
);

select name,avg,grade from stuscore3,scoregrade 
where avg between lowgrade and highgrade;


update stuscore3 set grade = (
select grade from scoregrade 
where avg between lowgrade and highgrade
);

commit;

-- avg기준으로 순위를 ranks컬럼에 입력하세요. rank() over()
-- 1) 출력
select rank() over(order by total desc),name,total,avg from stuscore3;

select * from stuscore3;

update stuscore3 a set rank = (
select ranks from (
select sno,rank() over(order by total desc) ranks from stuscore3) b 
where a.sno = b.sno
);

select sno,rank,rank() over(order by total desc) ranks from stuscore3;
commit;
-------------------------------------?

-- 2) 입력
select rank() over(order by avg asc) ranks,name,avg,total from stuscore;  


select * from stuscore;
alter table stuscore add grade nchar(1);
update stuscore set grade=' ';  --' ' : 사이띄우기=빈공백
commit;

select max(sno) from stuscore;      --141

select * from stuscore
order by sno asc;
alter table stuscore3 drop column leader;
select stuscore_seq.nextval from dual;

delete stuscore where sno>100;
commit;
select * from stuscore;

select * from stuscore3;

delete stuscore3;
commit;

drop table stuscore3;

create table stuscore3 as select * from stuscore where 1=2;
select * from stuscore3;

insert into stuscore3 values (
stuscore3_seq.nextval,'홍길동',100,100,99,(100+100+99),(100+100+99)/3,sysdate,0,' '
)
;
-- '':null / ' ':공백

commit;    -- commit해야 연결됨
select * from stuscore3;

select * from stuscore where name like '%na%'
;

select * from stuscore3;
commit;

select * from stuscore;
-- 등수처리 출력
select 
sno,rank() over(order by total desc) ranks,total 
from stuscore;

-- 등수처리 수정
update stuscore a set rank = (  --rank에 없데이트
select ranks from
(select sno, rank() over(order by total desc) ranks from stuscore) b
where a.sno = b.sno
)
;

update stuscore set rank = 0;  -- rank를 모두 0으로
commit;

select sno,total,rank from stuscore;


--- b.grade를 a.grade로 가져와서 넣어줌
select sno,avg,a.grade,b.grade from stuscore a,scoregrade b
where avg between lowgrade and highgrade
;

update stuscore set grade = (   --stuscore의 grade에 update
select grade from scoregrade
where avg between lowgrade and highgrade
)
;

update stuscore set grade = ' ';

commit;


