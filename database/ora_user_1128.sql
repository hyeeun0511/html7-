create table mem2 as select * from member;

select * from mem2;


select * from board;

create table board3 as select * from board;

-- 데이터:자료집합  /  정보:유용한(유익한) 자료
-- 무결성 제약조건 : 데이터 입력시 잘못된 데이터의 입력을 제약(조건을 걸어놓고 잘못된 데이터가 못들어오게 막는것)
-- primary key, foreign key, not null, unique, check
-- 테이블 생성시 primary key 등록방법
create table mem3(
 id varchar2(100) primary key,
 pw varchar2(100)
);

-- primary key 등록,수정
-- constraint 별칭
alter table mem2 add constraint pk_mem2_id primary key(id);  -- 수정 가능




-- 테이블 생성 foreign key 등록
-- 다른테이블의 primary key로 등록이 되어야 foreign key로 등록가능
create table board4(
bno number(4) primary key,
btitle varchar2(1000) not null,
bcontent clob,
id varchar2(100),
constraint fk_board4_mem2_id foreign key(id) references mem2(id)
);

drop table board4;

-- foreign key 수정
create table board3 as select * from board;

alter table mem2 add constraint pk_mem2_id primary key(id);

alter table board3 add constraint fk_board3_mem2_id foreign key(id) references mem2(id);
-- > mem2(id) : primary key로 등록이 되어있어야함

-- foreign key 삭제
alter table board3 drop constraint fk_board3_mem2_id;

drop table board3;

select * from board3;

insert into board3 values(
board_seq.nextval,'제목입니다.3','내용입니다.3','abc',board_seq.currval,0,0,0,'1.jpg',sysdate
);  -- 오류 : emeber에 abc가 없어서

-------------------------------------
-- 부모키 삭제시 foreign key 등록된 데이터 모두삭제
alter table board3 drop constraint fk_board3_mem2_id;

alter table board3 
add constraint fk_board3_mem2_id foreign key(id) references mem2(id)
on delete cascade
;  
-- 부모키 삭제시 foreign key 등록된 id null처리
alter table board3 
add constraint fk_board3_mem2_id foreign key(id) references mem2(id)
on delete set null
;  

delete mem2 where id='ccc';



select * from board3;

select * from mem2 where id='aaa';

-- id가 'aaa'인 사람 삭제
delete mem2 where id='aaa';     -- delete board3 where id='aaa'; 실행 후 클릭하면 삭제됨

select * from board3 where id='aaa'
;

delete board3 where id='aaa';

drop table mem3;
drop table mem2;
drop table board3;
drop table board2;

drop table mem;

create table mem(
id varchar2(100) primary key,
pw varchar2(100) not null,
name varchar2(100) unique,  -- 중복불가, null값 허용
phone char(13) default '010-0000-0000',  -- 입력이 안되면 임의로 ''안에 값이 자동으로 들어감
gender nvarchar2(2) check(gender in('남자','여자')),  -- 남자,여자 만 들어갈수 있게 ex) 남,여성->불가능
hobby varchar2(100) default '게임',
age number(3) check (age between 0 and 120)  -- 의미 : 나이 _ _ _ 세자리 가능, 0~120까지 가능
);

insert into mem(id,pw,gender) values ('aaa','1111','남자');

select * from mem;


--------------------------------------------------------------------

drop table stu;

create table stuscore2 as select * from stuscore;


select * from stuscore2;

-----------------------------------------
-- 논리 / 조건
select * from stuscore2;

alter table stuscore2 add leader nvarchar2(2);  -- 컬럼 하나 추가

update stuscore2 set leader='반장' where name='유관순';

-- decode : 조건 : 같은 경우만 실행
select sno,name,            
decode(sno,10,'반장',       --sno가 10번인 사람은 반장으로 넣어달라는 의미
           20,'부반장',     --sno가 20번인 사람은 부반장으로 넣어달라는 의미
           30,'총무',       --sno가 30번인 사람은 총무으로 넣어달라는 의미
           40,'총무2') as leader2 from stuscore2;   
           
-- case when 비교연산자를 사용가능
select sno,name,
case when sno<=10 then '반장'
when sno>=20 then '부반장'
when sno>=30 then '총무'
end as leader2
from stuscore2;

-- avg컬럼을 가지고, fank별칭을 사용해서 90이상 A, 80이상 B,C,D,F
select sno,name,avg,
case when sno>=90 then 'A'
when sno>=80 then 'B'
when sno>=70 then 'C'
when sno>=60 then 'D'
else 'F'
end as rank
from stuscore2;

select * from stuscore2;
        
alter table stuscore2 add event date;
alter table stuscore2 add randk nvarchar2(1); 

select sdate,last_day(sdate),trunc(sdate,'month') from stuscore;

select sdate,event,last_day(sdate) from stuscore2; 

update stuscore2 set event=last_day(sdate);

update stuscore2 set event = sysdate;

select * from stuscore2;
update  stuscore2 set rank = (
case when avg >=90 then 'A'
case when sno<=10 then 'B'
when sno>=20 then 'B'
when sno>=30 then '총무'
end as leader2
from stuscore2
);


select * from stuscore2;
update  stuscore2 set rank = (
case when avg >=90 then 'A';
case when sno<=10 then 'B'
when sno>=20 then 'B'
when sno>=30 then '총무'
end
from stuscore2;


select * from stuscore2;

alter table stuscore2 modify sdate invisible;
alter table stuscore2 modify leader invisible;
alter table stuscore2 modify event invisible;


alter table stuscore2 modify sdate visible;
alter table stuscore2 modify leader visible;
alter table stuscore2 modify event visible;           
           
select * from stuscore2
order by sno;
-- 'class'컬럼을 1개 추가'
-- 1~10 까지 1반,2반,3반,...........10반,기타 컬럼에 추가하시오.
select sno,
case when sno between 1 and 10 then '1반'
when sno between 11 and 20 then '2반'
when sno between 21 and 30 then '3반'
when sno between 31 and 40 then '4반'
when sno between 41 and 50 then '5반'
when sno between 51 and 60 then '6반'
when sno between 61 and 70 then '7반'
when sno between 71 and 80 then '8반'
when sno between 81 and 90 then '9반'
when sno between 91 and 100 then '10반'
else '기타'
end as class
from stuscore2;

alter table stuscore2 add class nvarchar2(3);

select sno,class from stuscore2;

update stuscore2 set class=(
case when sno between 1 and 10 then '1반'
when sno between 11 and 20 then '2반'
when sno between 21 and 30 then '3반'
when sno between 31 and 40 then '4반'
when sno between 41 and 50 then '5반'
when sno between 51 and 60 then '6반'
when sno between 61 and 70 then '7반'
when sno between 71 and 80 then '8반'
when sno between 81 and 90 then '9반'
when sno between 91 and 100 then '10반'
else '기타'
end
);

commit;

-----
select sno,name,total from stuscore2;
select * from stuscore2;

select total,rank() over(order by total desc) from stuscore2;
-- 등수처리는 따로 빼서 모아서 함

--------

-- 그룹함수 max,min,avg,sum,count(개수)... 
-- to_char(), to_number(), to_date()
select to_char(sum(kor),'9,999'),round(avg(kor),2),max(kor),min(kor),count(kor) from stuscore2;
select avg(kor) from stuscore2;           -- 평균
select max(kor),min(kor) from stuscore2;  -- 최대값, 최소값
select count(kor) from stuscore2;         -- 개수          

select name,max(kor) from stuscore2; -- 단일함수랑 그룹함수 함께 사용 불가

-- group by 단일컬럼
-- max(kor) 이름을 기준으로 최대국어점수를 출력하시오.  - 의미없음(한개뿐인 그룹:이름) -그룹이 되는걸로 사용하는게 유용
select * from stuscore2;

-- 전체평균
select avg(avg) from stuscore2;   

-- 단일컬럼과 그룹컬럼을 함께 사용할수 없음.
select class,avg(avg) from stuscore2;  -- 불가
-- 반별평균  
select class,avg(avg) from stuscore2   -- group by를 지정하게 되면 단일컬럼 사용가능
group by class;

---

-- 반별평균  - 52.657051275 보다 낮은 반을 출력하시오.
-- 그룹컬럼의 조건절은 where에서 사용할수 없음.
-- 그룹컬럼의 조건절은 having에 입력해야함.  (having - 조건절)
select class,avg(avg) from stuscore2
group by class
having avg(avg) <= 52.6
;

-- department_id employee 테이블
select salary,department_id from employees
order by department_id;  -- 정렬

--전체 부서 월급 평균
select avg(salary) from employees;
--전체 월급 총합
select sum(salary),avg(salary) from employees
group by department_id  -- 일반 함수에 쓰려면 group by에 넣어야함
having avg(salary)>=6416
-- having avg(salary)>=(select avg(salary) from employees)  -- 이중커리  (위와같음)
-- having avg(salary)>= (전체부서월급'평균')
order by department_id  -- 정렬 : 가장 마지막에 위치
;


-- 몇 개월 이후 날짜 구하는 함수
select sysdate,add_months(sysdate,6) from dual;

select hire_date,add_months(hire_date,6) from employees;
select hire_date,hire_date+100,add_months(hire_date,6) from employees;


select distinct department_id from employees;  -- distinct : 중복제거 

select count(*) from employees;
select count(manager_id) from employees; --null값때문에 count가 안생김 -> count는 *로 표시하는게 좋음


------------------------조인
-- 조인 : 2개 테이블 사용 ex) from member,board
select count(*) from member,board;  -- 10000 : 100*100

select count(*) from member;  -- 100
select count(*) from board;   -- 100


select department_id from employees;

select emp_name,employees.department_id,department_name,parent_id from employees,departments
where employees.department_id = departments.department_id
;

select * from departments;

select department_id,department_name from departments;


-- cross join (일반적인 조인) 100*100=10000
select * from employees,departments;

-- equi join : 동일한 컬럼이 존재할때 사용
select * from employees,departments
where employees.department_id = departments.department_id;

-- 작성자 id
select * from board;  
-- 작성자 board테이블 : id,  member테이블 : id,이름,전화번호    -> 출력
-- "join을 했을 경우", 공통컬럼 외 다른 컬럼의 내용을 바꾸면 변경된 내용을 가지고 옴
select member.id,name,bno,btitle from member,board    --member.id:member에 있는 id
where member.id = board.id
;

-- id,이름,전화번호
select * from member;
select * from board;

-- 이름 바꾸기(update)
update member set name='길동스' where id='aaa';  -- id가 aaa인 사람 이름을 '길동스'로 변경

select * from mem;
drop table mem;

create table mem as select * from member;
select * from member;

-- id를 aaa~kkk만 남기기
delete mem where id not in('aaa','bbb','ccc','ddd','eee','fff','ggg','hhh','iii','jjj','kkk');   --where조건에 id가 포함되어있지 않은 

select * from mem;

alter table mem add nicname varchar2(100);
select pw,rpad(substr(pw,0,2),4,'*')from mem;

select name,substr(name,0,2)||'즈' from mem;  -- 길동스 -> 길동즈

select name,concat(substr(name,0,2),'즈') from mem;

update mem set nicname = (
concat(substr(name,0,2),'즈')
);


--- 순서
alter table mem modify phone invisible;
alter table mem modify email invisible;
alter table mem modify gender invisible;
alter table mem modify hobby invisible;

alter table mem modify phone visible;
alter table mem modify email visible;
alter table mem modify gender visible;
alter table mem modify hobby visible;


-- nicname 출력    (mem) mem.id  / board.id
select bno,btitle,bcontent,id,nicname from board;


select bno,id from board;
select id,pw from mem;

-- select bno,btitle,bcontent,mem.id,nicname from mem,board  -- 하나이기때문에 속해있는 테이블이름 작성 안한거
select bno,btitle,bcontent,mem.id,nicname from mem,board   -- id라고 작성(X) -> mem.id / board.id (O)
where mem.id=board.id;                                     -- id가 두개이기 때문에

-- 사원테이블-employees - emp_name,separtment_id,salary
-- 부서테이블 departments - department_id,department_name

-- 사원이름,부서번호,부서이름,월급
select emp_name,employees.department_id,department_name,salary
from employees,departments
where employees.department_id = departments.department_id;
-- eq join : 두 테이블 조인
select emp_name,a.department_id,department_name,salary
from employees a,departments b  -- a,b : 별칭   employees : a / departments : b
where a.department_id = b.department_id;

select a.id,nicname,bno,btitle
from mem a,board b
where a.id = b.id;

select a.id,nicname,bno,btitle
from mem a,board b
where a.id = b.id and a.id='aaa';   -- id가 aaa인 사람만

-- non equi join : 같은 컬럼이 없고 두 테이블 조인하는 방법

select * from stuscore;  -- avg존재

create table scoregrade(  -- 성적그레이드 테이블 생성
grade char(1),
lowgrade number(7,4),
highgrade number(7,4)
);

insert into scoregrade values('A',90,100);   -- A 등급 90~100
insert into scoregrade values('B',80,89.9999);
insert into scoregrade values('C',70,79.9999);
insert into scoregrade values('D',60,69.9999);
insert into scoregrade values('F',0,59.9999);
commit;

drop table scoregrade;

--------------- non equi join : 같은 컬럼이 없고 두 테이블 조인하는 방법-------------
-- scoregrade,stuscore 2개테이블을 조인해서 grade 등급을 입력
-- scoregrade,stuscore -> 두 테이블 : 같은 컬럼이 존재하지 않음
select grade,lowgrade,highgrade from scoregrade;
select sno,name,kor,eng,math,total,avg,sdate from stuscore;

-- name,avg : stuscore  /  grade : scoregrade
-- stuscore에 svg컬럼을 scoregrade에 있는 lowgrade,highgrade의 범위를 조회해서 grade 추가
select name,avg,grade from stuscore a,scoregrade b
where avg between lowgrade and highgrade
;

-- (non equi join을 활용하여 컬럼 생성)
-- 월급을 가지고 직급을 추가하려고 합니다.
-- salgrade : grade, lowgrade,highgrade
-- 20000-50000:대표, 13000:부사장, 10000:부장, 8000:과장, 6000:대리, 그 외:사원
-- '대표','부사장','부장','과장','대리','사원'

select emp_name,salary from employees
order by salary desc;  -- desc : 내림차순

create table salgrade(  -- 성적그레이드 테이블 생성
grade nvarchar2(3),     --'부사장'
lowgrade number(5),     
highgrade number(5)
);

-- 20000-50000:대표, 13000:부사장, 10000:부장, 8000:과장, 6000:대리, 그 외:사원
insert into salgrade values('대표',20000,50000);                 
insert into salgrade values('부사장',13000,19999);
insert into salgrade values('부장',10000,12999);
insert into salgrade values('과장',8000,9999);
insert into salgrade values('대리',6000,7999);
insert into salgrade values('사원',0,5999);
commit;


select * from salgrade;

select emp_name,salary,grade from employees,salgrade
where salary between lowgrade and highgrade;


-- case when 
-- 20000-50000:대표, 13000:부사장, 10000:부장, 8000:과장, 6000:대리, 그 외:사원
select emp_name, salary,
case when salary between 20000 and 50000 then '대표'
when salary between 13000 and 1999 then '부사장'
when salary between 10000 and 12999 then '부장'
when salary between 8000 and 9999 then '과장'
when salary between 6000 and 7999 then '대리'
else '사원'
end as grade
from employees
;

select * from mem;
select * from stuscore2;
alter table stuscore2 drop column rank;
alter table stuscore2 drop column leader;

-- stuscore2 테이블 scoregrade테이블 조인해서 grade학점을 출력하세요  
select * from stuscore2;
select * from scoregrade;

select name,avg,grade from stuscore2,scoregrade 
where avg between lowgrade and highgrade;

-- grade 컬럼을 추가해서 조인해서 나온 결과를 입력하세요.
alter table stuscore2 add grade varchar2(1);  -- grade추가
select * from stuscore2;

-- 성적 그레이드 테이블에 관련
-- grade 컬럼 : non equi join update컬럼
update stuscore2 set grade = (
select grade from scoregrade
where avg between lowgrade and highgrade 
);

select name,avg,grade from stuscore2;


--[ 조인 ]
-- cross join : equi join - 같은컬럼 있는 경우,non equi join - 같은컬럼 없는 경우
-- self join : 같은 테이블 2개 사용할때

-- manager_id : 사원중에 자신의 상사의 id를 적용
select employee_id,emp_name,manager_id from employees;  -- ex) 171번.William Smith , 상사:148번

select a.employee_id,a.emp_name,a.manager_id,b.emp_name from employees a,employees b  --a,b 별칭줌 :상사의 이름도 출력하기위해
where a.manager_id = b.employee_id  -- manager_id(상사번호)를 바탕으로 employee_id(사원번호)를 찾아서 emp_name(사원이름)을 가져와 상사번호에 이름출력
;

select count(*) from employees;

-- outer join : 해당컬럼에 null값이 있어도 출력시켜줌
-- manager_id에 null값이 존재. 그 반대편에 (+)를 넣어줌
select a.employee_id,a.emp_name,a.manager_id,b.emp_name from employees a,employees b  --a,b 별칭줌 :상사의 이름도 출력하기위해
where a.manager_id = b.employee_id(+)  -- where ~~(+)=~~(+) : 불가능
; 

-- null 값 있는지없는지 확인 방법
select manager_id from employees
where manager_id is null;
-- select count(*) from employees
-- where manager_id is null;

-- count : null값은 카운터 하지않음  -> count(*)로 표시
select count(manager_id) from employees;

--Q.-- employees,departments 테이블을 이용해서  --inner join
------ 사원명,부서번호,부서명을 출력하세요.
select emp_name,a.department_id,department_name
from employees a, departments b
where a.department_id = b.department_id(+)
-- where a.department_id(+) = b.department_id  :인력없는 부서 null값으로 출력됨
;

select distinct department_id from employees
order by department_id;

select distinct department_id from departments
order by department_id;


------------------------------------------------------------------
-- ansi join
-- equi join
select emp_name,a.department_id,department_name
from employees a,departments b
where a.department_id = b.department_id  --a.department_id/b.department_id 두테이블의 동일한 컬럼을 갖고하는것
;

-- ansi equi join
select emp_name,department_id,department_name
from employees inner join departments          -- inner join ~ using
using (department_id)
;


-- <out join>
-- employees department_id에 null이 있는 경우, 반대편에 (+)를 입력해야 함.
-- 주로 사용(일반 쿼리문)
select emp_name,a.department_id,department_name
from employees a, departments b
where a.department_id = b.department_id(+);    -- a라는 곳의 반대편에 입력
--where a.department_id(+) = b.department_id(+)  :불가

--  <ansi outer join> 
--- : left outer join, right outer join, full outer join
select emp_name,a.department_id,department_name
from employees a left outer join departments    -- 같은편에 입력  right/left/full(둘다)
using(department_id);



---------------------------------------------------------
-- rownum 순번 출력하는 방법
select * from member;
select rownum,a.* from member a;  -- 자동으로 번호 나열

select rownum,a.* from employees a;

select * from board
order by bno;             

create table board2 as select * from board;

select * from board2;
-- board2에서 1~10까지 10개 갖고오기
order by bno;
-- 방법1)
select * from board2
where bno>=1 and bno<=10         -- bno:번호 _번호를 1~10까지 불러오면 됨
order by bno;
-- 방법2)  : 삭제된 번호 제외된 상태로 나열됨
select * from board2       
where bno between 1 and 10   
order by bno;
-- 정렬 -> 자동으로 번호 붙임
select rownum,a.* from board2 a       
where rownum between 1 and 10   
;
--rownum 특징: select한 후 rownum(1,2,3,4,...)붙임 // 조건붙일 시 특징:select후 1번부터 rownum붙임(없을시 삭제후 1번부터 다시 붙임->11번부터 출력 불가)

--------=====[이중쿼리]=======****중요****=======---- rownum 함수
select * from   -- from+(테이블명)
(select rownum rnum,a.* from (select * from board2 order by bno asc) a
)where rnum between 11 and 20      -- 이미 붙여있는 번호에서 10개씩 떼옴 -> 1번부터 시작하지않아도 순차적으로 들어옴
;

-- row_number()  ========**암기**=======
select * from      -- *:모든것에      ()안->테이블명
( select row_number() over(order by bno asc) rnum,a.* from board2 a )  -- 번호가 자동으로 붙음
-- 정렬을 해놓고 번호를 자동으로 붙이겠다는 의미
where rnum between 11 and 20
;



select rownum,a.* from stuscore a;
select rownum,a.* from member a;

select row_number() over(order by id) rnum,a.* from member a;  -- rnum,a:별칭


----============== 연습
select * from 
(
select row_number() over(order by bno asc) rnum,a.* from board2 a  -- rnum을 1번부터 순서대로 정렬
)
where rnum between 11 and 20;

select row_number() over(order by bno asc) rnum,a.* from board2 a
where rnum between 1 and 10;  -- 불가능  
--= select row_number() over(order by bno asc) rnum,a.* from board2 a 를 테이블명으로 갖고와서 전체rnum나열후 번호추출해야함 


select * from ( 테이블명 ) ;
select * from ( select row_number() over(order by bno asc) rnum,a.* from board2 a )
where rnum between 11 and 20;
;

select row_number () over(over by id) rnum,a.* from member a;  -- rnum을 1번부터 순서대로 정렬 
----==============



select rownum rnum,a.* from
(select * from board2 order by bno asc) a

;
select * from board2 order by bno asc;  -- 순번대로 정렬


delete board2 where bno =4;
delete board2 where bno =7;
delete board2 where bno =11;
delete board2 where bno =12;
delete board2 where bno =15;
delete board2 where bno =22;
delete board2 where bno =25;
delete board2 where bno =29;





