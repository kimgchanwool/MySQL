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

-- 테이블 복사 CREATE TABLE  --- SELECT