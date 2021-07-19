use employees;
select * from employees.titles;
select * from titles;  -- use가 사용되어 활성화된 경우에 쓰임
select first_name from employees;
select first_name, last_name, gender from employees.employees;

show databases;
show tables; -- 간단한 자료만 보기
show table status; -- 자세한 자료 보기
desc employees; -- 열의 내용을 볼 수 있음 또는 describe employeesmemberID

select * from usertbl where name = '김경호';

select userID, name from usertbl where birthyear >= 1970 and height >= 182; -- 
select userID, name from usertbl where birthyear >= 1970 or height >= 182;
select userID, name from usertbl where height >= 180 and height <= 183;
select userID, name from usertbl where height between 180 and 183; -- and의 양쪽 값의 사이값을 가져옴
select name, addr from usertbl where addr in ('경남','전남','경북');
select name, addr from usertbl where addr = '경남' or addr = '전남' or addr = '경북';
select name, height from usertbl where name like '김%'; --  like는 %를 쓴다. _도 가능한데 _는 한글자 아무거나와 매치고 %는 문자열 아무거나와 매치다.

select name, height from usertbl where name like '_종신';

select name, height from usertbl where height > 177;

select name, height from usertbl where height > (select height from usertbl where name = '김경호');

select name, height from usertbl where height > (select height from usertbl where addr = '경남'); -- 현재 안에있는 쿼리의 리턴값이 두개라서 오류.

select name, height from usertbl where height >= any (select height from usertbl where addr = '경남');
-- 이렇게 any가 둘 중 하나라도 만족하는 경우라서 170이상일 경우임
select name, height from usertbl where height >= all (select height from usertbl where addr = '경남');
-- all은 결과값 두개를 둘 다 만족해야 해서 170과 173중 173만 보면 됌
-- 결과물에는 영향x 출력 순서만 조절 default는 오름차순 순서는 앞에부터임
select name, height from usertbl order by height DESC, name ASC; -- 앞에것을 기준으로 정렬하고 동일 값은 뒤의 내용으로 정렬
-- 중복되는 것 없애는 DISTINCT

-- 출력 개수 제한 LIMIT

-- 테이블 복사 CREATE TABLE  --buytbl- SELECT
-- 7/ 16
select * From usertbl;
select addr From usertbl order by addr; -- 중복허용
select DISTINCT addr From usertbl; -- 중복없이.

use employees;
select emp_no, hire_date from employees
order by hire_date asc
limit 5; -- 해당 개수만큼만 자료 가져오기

use sqldb;
create table buytbl2 (select * from buytbl);

select * from buytbl2;
	
create table buytbl3 (select userID, prodname from buytbl);

select * from buytbl3;

select userid, amount from buytbl;
select userid, amount from buytbl order by userid; -- userid순으로 오름차순 정렬 A~Z순

select userid ,sum(amount) from buytbl group by userid; -- 출력할때 함수를 통과한 값을 출력하는 것임 group by로 같은 userid를 가진 것 끼리 묶고 그것을 SUM해서 나옴
select userid as '사용자 아이디', sum(amount) as '총 구매개수' from buytbl group by userid;
-- as를 통해서 별칭을 지정할 수 있음 alias임.
select * from buytbl
select userid as '사용자 아이디', sum(amount*price) as '총 구매액' from buytbl group by userid; -- 이렇게 곱하기도 쓸 수 있음.

select avg(amount) from buytbl;
select userid, avg(amount) from buytbl group by userid; -- 사용자별로 묶어서 평균.\

select name, max(height), min(height) from usertbl;
select * from usertbl;

select name, max(height), min(height) from usertbl group by name;

select name, height 
	from usertbl 
	where height = (select  max(height) from usertbl)
		or height = (select min(height) from usertbl)
	order by height DESC;
        
-- usertbl에서 휴대폰이 있는 사용자의 개수 출력
select count(mobile1) from usertbl where mobile1;
select count(mobile1) as '휴대폰이 있는 사용자' from usertbl; -- 출력하는것이 하나면 있을때만 출력.

select userid as '사용자 아이디', sum(amount*price) as '총 구매액' 
	from buytbl 
	where sum(amount*price) >= 1000-- 집계함수를 where에서는 쓸 수는 없다.
	group by userid;

select userid as '사용자 아이디', sum(amount*price) as '총 구매액' 
	from buytbl 
	group by userid
    having sum(price * amount) > 1000 -- having은 group by 뒤로 와야한다.
    order by sum(price * amount);
    
    -- rollup은 각각에 대해서 소합계를 내준다.
select num, groupname, sum(price*amount) as '비용'
	from buytbl
    group by groupname, num
    with rollup;
    
    
use sqldb;
create table testtbl1(id int, username char(3), age int); 
insert into testtbl1 values (1, '홍길동', 25);
select * from testtbl1;
insert into testtbl1(id, username) values (2, '설현');
insert into testtbl1(username, age, id) values ('하니', 26, 3)

create table testtbl2
	(id int auto_increment primary key, -- 자동으로 1부터 부여하고 PK로 설정.
    username char(3),
    age int );
    
insert into testtbl2 values(null, '지민', 25);
insert into testtbl2 values(null, '유나', 22);
insert into testtbl2 values(null, '유경', 21);

select * from testtbl2;

select last_insert_id();

alter table testtbl2 auto_increment=100;
insert into testtbl2 values (null, '찬미', 23);

select * from testtbl2;

create table testtbl3
	(id int auto_increment primary key,
    username char(3),
    age int );
alter table testtbl3 auto_increment=1000; #100부터 시작
set @@auto_increment_increment=3; #증가 단위가 3

insert into testtbl3 values (null, '나연', 20);
insert into testtbl3 values (null, '정연', 18);
insert into testtbl3 values (null, '모모', 19);

select * from testtbl3;

create table testtbl4 (id int, fname varchar(50), lname varchar(50));

insert into testtbl4
	select emp_no, first_name, last_name
	  from employees.employees; -- 설명좀 들어가자면 insert into 자료를 추가하는 용도로 쓰이는데
      -- 지금은 value가 하나씩 들어온 것이 아닌 열 자체가 들어가는 중이다.

alter table testtbl4 AUTO_INCREMENT=20000;
set @@auto_increment_increment=5;
select * from testtbl4;

create table testtbl5
	(select emp_no, first_name, last_name from employees.employees);
    
update testtbl4 
	set lname = '없음' 
	where fname = 'kyoichi'; -- update 명령어인듯 설정하다.


select * from testtbl4 where fname = 'kyoichi';

SET SQL_SAFE_UPDATES = 0;
update buytbl set price = price * 1.5;

select * from buytbl;

select * from testtbl4 where fname = 'Aamer'; --fir name이 aamer인 것만 나타남

delete from testtbl4 where fname = 'aamer';

select * from testtbl4 where fname = 'Aamer'; -- fname aamer를 삭제해서 하나도 안나타남


create table bigtable1 (select * from employees.employees);
create table bigtable2 (select * from employees.employees);
create table bigtable3 (select * from employees.employees);

-- 삭제 명령
delete from bigtable1; -- 내용만 지우기 바로 지우지 않고 일단 판단을 유보해둬서 속도 느림
drop table bigtable2; -- 테이블 전체를 지우기 transaction이 없어서 빠름
drop table bigtable2;  -- 딜리트랑 비슷하지만 바로지움 delete랑 결과는 같지만 transaction이 없어서 빠름

create table membertbl (select userid, name, addr from usertbl limit 3);
select userid, name, addr from usertbl;
select * from membertbl;

alter table membertbl
	add CONSTRAINT pk_membertbl PRIMARY KEY (userid);
select * from membertbl;

INSERT INTO memberTBL VALUES('BBK' , '비비코', '미국');
INSERT INTO memberTBL VALUES('SJH' , '서장훈', '서울');
INSERT INTO memberTBL VALUES('HJY' , '현주엽', '경기');

INSERT ignore INTO memberTBL VALUES('BBK' , '비비코', '미국'); -- ignore를 쓰면 실패했지만 뒤에 있는 것을 실행시킨다.
INSERT ignore INTO memberTBL VALUES('SJH' , '서장훈', '서울');
INSERT ignore INTO memberTBL VALUES('HJY' , '현주엽', '경기');
select * from membertbl;

INSERT INTO memberTBL VALUES('BBK' , '비비코', '미국')
	on DUPLICATE KEY UPDATE name = '비비코', addr = '미국'; -- 해석해보면 업데이트를 하는데 있다면 update를 하는 것이다. pk는 바꿀 수 없음.
    
select * from membertbl; 

case 10  -- c언어 처럼 케이스를 쓸 수 있다.
    when 1 then '일'
    when 5 then '오'
    when 10 then '십'
	else '모름'
  end as 'case연습';

create DATABASE movieDB;
drop table moviebl;
use movieDb;
create table movietbl(
	movie_id		int,
    movie_title		varchar(30),
    movie_director	varchar(20),
    movie_star		varchar(20),
    movie_script	longtext,
    movie_film		LONGBLOB
) Default charset=utf8mb4; -- 인코딩과 같음.

insert into movietbl values (1, '쉰들러 리스트', '스필버그', '리암 니슨',
	load_file('C:\Users\sweet\Desktop\코딩\MySQL 기초\movies\Schindler.txt'),
    load_file('C:\Users\sweet\Desktop\코딩\MySQL 기초\movies\Schindler.mp4'));

select * from movietbl;

show variables like 'max_allowed_packet';

show variables like 'secure_file_priv';

USE moviedb;
TRUNCATE movietbl; -- 기존 행 모두 제거

INSERT INTO movietbl VALUES ( 1, '쉰들러 리스트', '스필버그', '리암 니슨',  
	LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movies/Schindler.txt'), 
	LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movies/Schindler.mp4') );
INSERT INTO movietbl VALUES ( 2, '쇼생
크 탈출', '프랭크 다라본트', '팀 로빈스',  
	LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movies/Shawshank.txt'), 
	LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movies/Shawshank.mp4') );    
INSERT INTO movietbl VALUES ( 3, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스',
	LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movies/Mohican.txt'), 
	LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movies/Mohican.mp4') );

SELECT movie_script FROM movietbl WHERE movie_id=1  -- 동영상을 이렇게 만들 수도 있고 into outfile을 이용해서 파일을 저장할 수 도 있다.
	INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Schindler_out.txt'  
	LINES TERMINATED BY '\\n'; -- 이렇게 개행도 추가할 수 있다.
    
SELECT movie_film FROM movietbl WHERE movie_id=3
	INTO DUMPFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Mohican_out.mp4';

use sqldb;
create table pivottest
	( uName CHAR(3), -- 이름
	  season char(2), -- 계절
      amount int ); -- 양



INSERT  INTO  pivotTest VALUES
	('김범수' , '겨울',  10) , ('윤종신' , '여름',  15) , ('김범수' , '가을',  25) , ('김범수' , '봄',    3) ,
	('김범수' , '봄',    37) , ('윤종신' , '겨울',  40) , ('김범수' , '여름',  14) ,('김범수' , '겨울',  22) ,
	('윤종신' , '여름',  64) ;
    
select * from pivottest;
    
select uName,    -- 설명하자면 4가지를 이름, 계절 4개, 합계 를 나타내는데 sum 할때 특정 계절인 것만 가져가는 것임. 두명이서 할 것이므로 group by uName 이다.
   sum(if(season = '봄', amount, 0)) as '봄',
   sum(if(season = '여름', amount, 0)) as '여름',
   sum(if(season = '가을', amount, 0)) as '가을',
   sum(if(season = '겨울', amount, 0)) as '겨울',
   sum(amount) as '합계' from pivottest group by uName;

select * from pivottest;

use sqldb;
select json_object('name', name, 'height', height) as 'json 값' -- json_object는 json형으로 만들어 준다. 키, 값, 키, 값... 이런 식으로 묶어야함.
	from usertbl -- usertbl에서 가져온 name과 height로 json object를 만든다.
    where height >= 180; -- 근데 거기서 조건이 붙는데 height가 180 이상이어야 한다.
-- json형태로 key : value의 형태로 바뀌었다. -- json이란 키-값이 쌍을 이루는 것으로 우리는 간단히 딕셔너리라고 생각하면 된다

select name, height from usertbl where height >= 180 order by height desc;

set @json = '{"usertbl" : 
[
	{"name": "임재범", "height": 182},
	{"name": "이승기", "height": 182},
	{"name": "성시경", "height": 186}
]
}'; -- @변수명 은 변수다. 한번에 쫘르륵 넣고 싶을때는 이렇게 쓰자. 리스트 처럼 인덱스를 쓸 수 있다.

select json_valid(@json) as json_valid;
select json_search(@json, 'one', '임재범') as json_search; -- 'one' 는 하나만 리턴하라는 뜻 위치를 리턴한 듯
select json_extract(@json, '$.usertbl[0].name') as json_extract; -- 위치의 name을 꺼낸듯. 인덱스라서 0부터 시작임.
select json_insert(@json, '$.usertbl[0].mDate', '2009-09-09') as json_insert;
select json_replace(@json, '$.usertbl[0].name', '홍길동') as json_replace;
select json_remove(@json, '$.usertbl[0]', '홍길동') as json_remove;

USE sqldb;
SELECT num, buytbl.userID, prodname, price, amount, usertbl.userid, usertbl.name -- 이렇게 지정하면 역으로 나오는데 default는 from먼저
   FROM buytbl -- 위에 보면 usertbl.~~가 있는데 이 이유는 from이 합쳐졌기에 같은 컬럼이 있을때 바로 ~~~을 입력하면 오류가 나온다.
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
   WHERE buytbl.userID = 'JYP';

USE sqldb;
SELECT * 
   FROM buytbl
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
   WHERE buytbl.userID = 'JYP'; -- 합치는데 jyp만 합친다 where는 맨 마지막에.

use sqldb;
SELECT * 
	FROM buytbl -- buytbl이 기준이다.
     INNER JOIN usertbl -- usertbl과 합쳐지는데 on은 조건임 userid가 같아야함.
        ON buytbl.userID = usertbl.userID; -- 아이디가 같은것끼리 join시킨다.

SELECT buytbl.userid, name, prodname, addr, mobile1 + mobile2 as '연락처' -- 같은 열이 있을때는 정확히 지칭하는 것이 필요하다. 바비킴이 10이 나온 이유는 int형끼리 더해서 000 + 10은 10이나온것임.
	FROM buytbl
     INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
	 order by num;
     
     -- 3일차.
     
use employees;
desc employees;
select * from employees ;


