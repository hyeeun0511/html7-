--- 날짜함수 시간,오전오후 출력
select to_char(sdate,'yyyy-mm-dd am hh24:mi:ss') from stuscore order by sno desc;
-- desc : 내림차순


-- 날짜함수 : 사칙연산에서 +,-가능
select sysdate from dual;  -- sysdate:현재날짜  /  dual:가상
select sysdate-1,sysdate,sysdate+1 from dual;  -- 어제,오늘,내일 날짜
select sysdate+100 from dual;  -- 100일 후 날짜

-----------

select * from board;

select * from employees;

-- 날짜함수 : 사칙연산에서 +,-가능
select sysdate from dual;  -- sysdate:현재날짜  /  dual:가상
select sysdate-1,sysdate,sysdate+1 from dual;  -- 어제,오늘,내일 날짜
select sysdate+100 from dual;  -- 100일 후 날짜

select * from board;

select bdate from board
where bdate>'2025/11/01';

-- 컬럼합치기 - cincat,||
select concat(btitle,bcontent) from board;
select btitle||bcontesnt from board;

select * from member;
select id| |','||pw| |'-'| |name as tel from member;


--입사일 = 입사일 가장오래 근무한 아원수로 출려하세요  -- sysdte
select * from employees;
select sysdate-hire_date from employees
order by sysdate-hire_date desc
;

-- board 현재 게시글날짜가 얼마나 지났는지 출력하세요.
-- 소수점 2째자리에서 반올림하시오.  
select sysdate - bdate from board;
select round(sysdate - bdate, 2) from board;
select round(sysdate - bdate, 4) from board;

select * from member;
select * from board;

select * from stuscore order by sno desc;  
-- order by [정렬방향]  1)asc : 오름차순  2)desc : 내림차순
 

-- 날짜함수 시간,오전오후 출력
select to_char(sdate,'yyyy-mm-dd am hh24:mi:ss') from stuscore order by sno desc;
             -- sdate : yyyymmdd

insert into stuscore values(
stuscore_seq.nextval,'이순신',80,81,88,80+81+88,(80+81+88)/3,sysdate
);

commit;

select hire_date from employees;

-- round : 반올림  
-- month (월을 기준으로 반올림) - 15일이전은 그달 1일로 변경, 15일 이후는 다음달로 1개월 추가
select hire_date,round(hire_date,'month')from employees;
-- trunc : 버림  /  month기준 : 그달 1일로 변경
select hire_date, trunc(hire_date,'month') from employees order by hire_date;
-- board테이블에서 입력한 게시글 기준 1일을 출력하시오.
select bdate, trunc(bdate,'month') from board;  -- 그달의 1일을 찾는것

-- 가입한 회원 9월달 생일자를 검색해서 생일쿠폰을제공하세시오.
select bdate, trunc(badate,'month') from board;

-- 게시글 2024-12-01 ~ 2025-05-31 까지 게시글을 출력하시오
select bdate from board 
where bdate between '2024-12-01' and '2025-05-31'
order by bdate ;
-- 월을 기준으로 삭제
select bdate, trunc(bdate,'month'),bdate-30 from board
where bdate between '2024-12-01' and '2025-05-31'
order by bdate;

select bdate,to_char(bdate,'yyyy-mm-dd hh:mi:ss') from board;
select bdate,trunc(bdate,'month') from board;  -- 달을 기준으로  //가장많이씀
select bdate,trunc(bdate,'mm')from board;      -- 위와 같은 결과값
select bdate, trunc(bdate,'dd')from board;     -- 일을 기준으로
select sdate from stuscore;
-- hh -> 분 30분 이상 : 시간+1  /  30분 미만 : 시간 삭제
select name,to_char(sdate,'yyyy-mm-dd hh:mi:ss'),
to_char(trunc(sdate,'hh'),'yyyy-mm-dd hh:mi:ss') from stuscore;




-- day (요일기준 반올림)  /  수요일 기준 ~> 이전:이전 일요일    이후:이후 일요일
select hire_date,round(hire_date,'day')from employees;
select bdate,round(bdate,'day') from board;




-- member테이블
select sdate from stuscore;

-- months_between : 두컬럼의 개월 수를 확인 (날짜 확인X)
select sysdate,sdate,
trunc(months_between(sysdate,sdate))||' 개월' from stuscore    -- stunc : 소수점 버림
where months_between(sysdate-1,sdate) = 9
;

-- add_months : 특정 개월수를 더한 날짜 확인
select name,sdate,add_months(sdate,6) from stuscore;  -- sdate의 6개월 후의 날짜 확인


-- 문자열 함수
-- length : 문자 길이
select name,length(name),lengthb(name) from stuscore;

-- substr : 문자자르기 (컬럼명,시작위치,개수)
select name, substr(name,0,2) from stuscore;

-- s1423,s2798 -> 숫자의 합을 구하시오.
select substr('s1423',2,4),substr('s2798',2,4) from dual; -- substr:문자열 / dual:가상 
select to_number(substr('s1423',2,4)),to_number(substr('s2798',2,4)) from dual;
select to_number(substr('s1423',2,4))+to_number(substr('s2798',2,4)) from dual;

select (kor+eng+math)/3 from stuscore;
select id||pw from member;  -- || = 컬럼 합치기(+)


-- instr 함수 : 문자열 데이터 안에서 특정문자 위치 찾는 함수
-- like : 포함되어있는
select name from member;
-- n 포함되어 있는 이름을 출력하시오.
select name from member
where name like '%n%';

-- !=,<>,^= : not
select name, instr(name,'n') from member
where instr(name,'n') != 0
;   -- 이름에 n이 포함되어있는(n의 개수가 0인) 멤버이름을 찾아달라는 의미


-- trim 함수 : 공백제거 ltrim(왼공백제거),rtrim(오공백제거)

select '      abc      ' from dual;
select ltrim('      ab  c      ') from dual;  -- 왼공백제거
select rtrim('      ab  c      ') from dual;  -- 오공백제거
select trim('      ab  c      ') from dual;   -- 공백제거

-- replace 다른문자로 대체 - 문자 사이의 공백 제거
select replace('      ab  c      ','','') from dual; 

select replace('rove,rive,rife','r','l') from dual;  --'rove,rive,rife'의 모든r을 l로 변경 
select 'rove,rive,rife' from dual;

select name,replace(name,'r','l') from member;   -- 멤버 이름에 'r'을 'l'로 변경
-- 변경된 이름만 출력(r->l)
select name,replace(name,'r','l') from member
where name like '%r%';  -- name에서 r이 포함된 이름 찾는게 빠름

select id,pw from member;
select id,rpad(pw,10,'*') from member;   -- rpad : 오른쪽공백에 채우라는 뜻

select id,rpad(substr(pw,0,2),4,'*') as pw from member;  
-- 비번0자리부터 두째자리까지 잘라옴
-- 오른쪽공백을 *로 채워서 4자리로 만듦

select substr(pw,0,2) from member;   -- 0자리부터 두째자리까지 잘라옴

select sysdate-1,sysdate,sysdate+1,sysdate-hire_date from employees;


create table stu as select * from stuscore;

select * from stu;
desc stuscore;

drop table stu;

create table stu (
sno number(4),
name varchar2(100),
sdate date,
sdate2 date
);


insert into stu(sno,name,sdate) select sno,name,sdate from stuscore;

select * from stu;

commit;

-- sdate2에 10년 후 날짜를 입력                (120개월)
select sno,name,sdate,sdate2,add_months(sdate,120) from stu;
select add_month(sdate,120) from stu;

-- 유관순 sdate2에 오늘날짜 입력하시오.
update stu set sdate2 = sysdate
where name='유관순';

update stu a set sdate2 = (              -- 1개
select add_months(sdate,120) from stu b  -- 102개 -- sdate2에 select add_month(sdate,120) from stu를 넣으라는 의미
where a.sno = b.sno
);
 select * from stu;

rollback;


select hire_date,(last_day(hire_date)) from employees;  --그날짜가 속한 달의 마지막 날짜
-- 특정 날짜가 속한 달의 첫 날짜, 마지막 날짜
select hire_date,trunc(hire_date,'month'),last_day(hire_date) from employees;  
-- 특정 날짜 기준으로 돌아오는 요일의 날짜
select sysdate,next_day(sysdate,'월요일') from dual;   -- '월요일'대신 'monday'안됨



select * from stuscore;  -- rank가 없음
-- 등수처리
select sno,name,total,rank() over(order by total desc) from stuscore;   --desc : 역순정렬


--- 형변환함수 to_char():문자열데이터 ,to_number():숫자데이터 ,to_date():날짜데이터
-- to)char() : 천단위표시
-- '000,000' : 0:빈공백 0으로 채움, '999,999' : 9:빈공백 공백으로 채움
select salary,salary*12*1473 from employees;    -- 연봉 원화로 바꿈
-- 12,000,000 : 쉼표는 문자열
-- $ : 달러  /  L(l) : 원화  /  . : 소수점  /  , : 천단위
select salary,length(salary*12),to_char(salary*12,'$000,999'),
to_char(salary*12*1473,'L999,999,999.00') from employees;  --(6자리가 최대)


-- to_char() : 문자열 함수변환
-- to_char(컬럼,'yyy-mm-dd hh24:mi:ss')
select sdate from stuscore;
select sdate,to_char(sdate,'yyy-mm-dd hh24:mi:ss day') from stuscore;  -- day : 요일
select sdate,to_char(sdate,'mm')from stuscore; -- 월만 출력
-- substr : 자르기
select substr(to_char(sdate),4,2),substr(to_char(sdate,'yyy-mm-dd'),6,2) from stuscore;

select * from member;
select substr(phone,0,3),substr(phone,5,3),substr(phone,9,4) from member;

-- to_date()  : 문자열을 날짜로 변경
-- 문자열을 날짜타입으로 변경하는 이유 : 날짜와 날짜사이의 간격, 날짜에 특정날짜를 더하기
select '20251127' from dual;    --문자 20251127로 나옴
select '20251127'+1 from dual;  -- 20251128
select to_date('20251127','yyyymmdd')+1 from dual;  -- 25/11/28
select sysdate-'20251027',sysdate-to_date('20251027','yyyymmdd') from dual;   -- 문자열에 '-'안됨
select sysdate-'20251027' from dual; -- 문자열에 '-'안됨
select sysdate-to_date('20251027','yyyymmdd') from dual;  -- 가능
select add_months(to_date('20251027','yyyymmdd'),1) from dual;   --25/11/27
select months_between(sysdate,to_date('20251027','yyyymmdd')) from dual;-- 간격



-- to_number(컬럼,형태) : 문자열을 숫자로 변경
select '20,000','30,000' from dual;  -- 20,000  30,000   (문자열)
select to_number('20,000','99,999'),'30,000' from dual;
select '30000',to_number('30000') from dual;
select to_number('20,000','99,999'),to_number(replace('30,000',',','')) from dual;  -- 문자(,) 없애기
-- to_char : 숫자,날짜 데이터 --변환--> 문자 데이터
select salary,to_char(salary*12,'999,999')y_salary,to_char(salary*12*1473,'999,999,999') y_ksalary from employees;


---------------------------------------------------------------------
-- 그룹함수 count,max,min,avg,sum
-- 그룹함수, 단일함수와 함께 사용할수 없음
select max(kor),max(eng) from stuscore;
select max(kor),min(eng),median(kor),variance(kor),stddev(kor) from stuscore;
-- 분산(variance) : 데이터 퍼진정도(산포도) / 표준편차(stddev): 분산의 제곱.평균값에서 얼마나 벗어나있는지
select avg(kor) from stuscore; -- 평균
select count(kor) from stuscore; -- 총 인원수

select count(*) from employees;
select sum(salary) from employees;
select avg(salary) from employees; -- 평균
select max(salary) from employees; -- 최대
select min(salary) from employees; -- 최소
select emp_name,min(salary) from employees; -- 단일함수,그룹함수 -> 함께사용불가

select department_id,salary from employees;
-- round(avg(salary),2) : 소수점 두째자리까지
select sum(salary),round(avg(salary),2),max(salary),min(salary),count(salary) from employees
where department_id=50; 

-- 최대값
select max(salary) from employees    -- emp_name,max(salary) : 불가
where department_id =50;
-- 이름 찾고싶을 경우 1)
select emp_name from employees
where department_id = 50 and salary=(
select max(salary) from employees   
where department_id =50
);
--2) 
select emp_name from employees
where department_id = 50 and salary=8200;

select max(salary) from employees
; --24000

select emp_name from employees
where salary=24000
; -- Steven King

select emp_name from employees
where salary=(select max(salary) from employees)
; -- Steven King

-- 평균월급보다 높은 사원을 출력하시오
-- 1) 평균 월급
select avg(salary) from employees;  --6461.831775700934579439252336448598130841
-- 2) 평균월급보다 높은 사원
select emp_name from employees
where salary >= (select avg(salary) from employees)
;
-- 3) 인원
select count(emp_name) from employees
where salary >= (select avg(salary) from employees)
;

-- stuscore에서 국어점수가 평균이상인 사람이 몇명인지 출력하시오
-- 1) stuscore 평균
select * from stuscore;
-- 2) 국어 평균 점수
select avg(kor) from stuscore;
-- 3) 전체 학생 수
select count(*) from stuscore;
-- 4) 결과
select count(*) from stuscore
where kor>=(select avg(kor) from stuscore)
;

-- count(*)
select count(*) from employees;   -- 107명
select count(emp_name) from employees;   --107명
select count(manager_id) from employees;   --106명  : null값이 있으면 count에 포함안됨
select manager_id from employees
where manager_id is null;  -- =null이라 작성X



-- stuscore테이블 total컬럼을 비교해서
-- 입력한 점수보다 합계점수가 높은 학생이 몇명인지 출력하시오.
select count(total) from stuscore where total>=120;


----- 527-***-1397 이렇게 출력하시오.  lpad/rpad 
select phone from member;
select phone, substr(phone,0,3)||'-****-'||substr(phone,9,4) from member
;
-- 11** rpad()
select pw from member;
select substr(pw,0,2) from member;  --11
select pw,rpad(substr(pw,0,2),4,'*') from member;  --11**
select pw,rpad(substr(pw,0,length(pw)-2),length(pw),'*') from member;  --11**
select length(name),length(name)-2 from member;

-- 홍**,Luci**,Gregoi**
select name from member;
select name,rpad(substr(name,0,length(name)-2),length(name),'*') as rpad from member;   -- as rpad(별칭_써도되고 안써도 됨) from member
-- byte숫자에 의해 -> 국문의 경우 : length(name)+1해야 '홍**'으로 나옴
select name,rpad(substr(name,0,7-2),7,'*') from member;
-- 0에서 5(7-2)개 잘라오고 
-- rpad는 *로 오른쪽에 7자리 맞춰 채우라는 의미

select name, substr(name,0,length(name)-2) from member;
-- 처음부터 나열한 후 2개 부족하게 잘라오라는 의미 


-- 제약조건 : primary key, foreign key, not null, unique, check
-- primary key : null 불가, 중복불가
-- foreign key : 다른테이블에 primary key로 등록이 되어야 FK로 등록가능
-- not null : null 불가, 중복가능
-- nunique : 중복 불가, null불가
-- check : 설정값만 입력가능
create table mem(
id varchar2(100) primary key,
pw varchar2(100) not null,
name varchar2(100) unique,
phone char(13),
gender nvarchar2(2) check(gender in ('남자','여자')),  -- 남자 or 여자
hobby varchar2(100),
mdate date
);

insert into mem values(
'aaa','1111','홍길동','010-1111-1111','남자','게임',sysdate
);

insert into mem values(
'aaa','1111',null,'010-1111-1111','남자','게임',sysdate
);  -- 에러 -> aaa가 중복되어서
-- aaa:primary키로 등록됨
-- 111: not null로 등록됨 _ 중복가능
-- 'null' : null 값이 아닌 문자로 인식

insert into mem values(
'bbb','1111',null,'010-1111-1111','남자','게임',sysdate
);

insert into mem values(
'ccc','1111',null,'010-1111-1111','여자','게임',sysdate
);   -- 홍길동 -> 중복값으로 또 넣을수 없지만, null값은 중복처리가 안됨->넣을수 있음(최대한 안넣는게 좋음)

insert into mem values(
'ddd','1111',null,'010-1111-1111','여성','게임',sysdate 
);   -- 오류 : 남자/여자 만 가능

insert into mem values(
'eee','1111',null,null,'여자',null,null
);

insert into mem (id,pw,gender) values(
'fff','1111','남자'
);

commit;

select * from board;


select * from mem;




create table board2 as select * from board;

-- foreign key 등록
alter table board2
add constraint fk_mem_board2_id foreign key(id)
references mem(id)
;
-- -> 의미 : mem에 있는 board2에 id를 fk(foreign key)로 줄거임  / fk :별칭
-- mem테이블, board2테이블 id컬럼이 연결
-- mem테이블에 없는 id board2에 id로 등록이 불가
-- mem테이블을 board2의 id가 삭제되지 않으면 mem테이블 삭제할수 없음


