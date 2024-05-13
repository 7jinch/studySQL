/* 함수 */
# 1. 숫자 함수
select 7 / 2, 7 div 4; # /, div: 몫
select 7 mod 2, 7 % 2; # %, mod: 나머지
select ceil(5.146); # ceil: 주어진 숫자보다 큰 정수 중 최소 정수
select floor(6.146); # floor: 주어진 숫자보다 작은 정수 중 최대 정수
select round(5.146, 2); # round: 값과 반올림 위치 5.15
select round(5.146, -1); # 10
select truncate(5.146, 2); # truncate: 값, 절삭 위치

select abs(-10); # abs: 절대값
select pow(2, 10), power(3, 10); # pow, power: x의 y승
select sqrt(90); # sqrt: 제곱근
select sign(10); # sign: -1, 0, 1
select rand(); # rand(seed): 난수값

select log(4, 100); # log(x, y): 밑이 x인 로그 y
select log2(100); # log2(y): 밑이 2인 로그 y
select log10(100); # log10(y): 밑이 10인 로그 y
select log(100); # log(y): 밑이 자연상수(e)인 로그 y
select ln(100); # ln(y): 밑이 자연상수인 로그 y
select exp(1); # exp:(x): 자연상수의의 x승

# 2. 문자 함수
select version(); # version: mysql의 버전 확인
select length('데이터사이언스아카데미'); # length: 문자열의 크기(길이 x)
select char_length('데이터사이언스아카데미'); # char_length: 문자의 개수
select concat('데이터', '사이언스', '아카데이'); # concat: 문자열 합치기
select concat('데이터', null, '아카데이'); # null이랑 합치면 null이 됨
select concat_ws('=','데이터','사이언스아카데이'); # concat_ws(구분자 문자열, 문자, 문자, ...): 합칠 때 구분자를 줄 수 있음
select lower('ABCDE'), lcase('ABCDE'); # lower, lcase: 소문자로 만들기
select upper('abcde'), ucase('abcde'); # upper, ucase: 대문자로 만들기

use world;

select format(population, '1') from city limit 5; # format: 

select instr(concat(name, countrycode), 'usa') as 'instr()' from city # instr(data, 문자열): data에서 2번재 문자열의 위치갑
where countrycode = 'usa';

select locate('db', 'mairaDB & mySQL are RDB', 3); # locate(문자열, data, pos): data에서 pos로부터 문자열 위치값 찾기

select position('db' in 'mairaDB & mySQL are RDB'); # positoin: 찾으려는 문자가 문자열의 어느 위치에 있는지

select lpad(name, 10, '#') from city; # Lpad(data, n, 패딩문자): 총 길이(n)에서 data를 제외한 공간을 패징 문자로 왼쪽 채움
select rpad(name, 10, '#') from city; # Rpad(data, n, 패딩문자): 총 길이(n)에서 data를 제외한 공간을 패징 문자로 오른쪽 채움

select Ltrim('     #     '); # Ltrim: 왼쪽 공백제거
select Rtrim('     #     '); # Rtrim: 오른쪽 공백 제거

select trim('     #     '); # trim(data): 양쪽의 공백 제거
select trim(both '#' from '#####1#1#####'); # trim(both '특수문자' from data): 양족에서 특수문자 한번에 제거
select trim(leading '#' from '#####1#1#####'); # trim(leading '특수문자' from data): 왼쪽에서 특수문자 제거
select trim(trailing '#' from '#####1#1#####'); # trim(trailing '특수문자' from data): 오른쪽에서 특수문자 제거

select repeat('busan', 10); # repeat(str, n): str을 n번 반복
select replace('iphone', 'i', 'my'); # replace(str, a, b): str에서 a를 b로 변경
select reverse('기러기'); # reverse(srt): str 순서를 반대로
select strcmp('busna', 'pusan'); # strcmp(st1, str2): 같으면 0, 다르면 1(앞이 길면), -1(뒤가 길면)

-- 문제) city table에서 countrycode와 name을 붙이고 구분자는 ':'으로 표기
-- 		위 결과를 출력할 때 일본의 도시를 한국의 도시로 변경해서 출력하기
select concat(replace(countrycode, 'KOR', 'JPN'), ':', name) as '국가명 : 국가코드' from city
where countrycode like 'KOR' or countrycode like 'JPN';

# 3. 날짜 함수
select current_time(); # current_time(): 시분초
select current_timestamp(); # current_timestamp(), now(): 년월일 시분초
select year(now()), quarter(now()), month(now()), day(now()), dayname(now()), time(now()); # 년, 분기, 월, 일, 요일, 시간
select dayofyear(now()), dayofmonth(now()), dayofweek(now()); # 몇 번 째 날? / 년, 월, 주
select weekofyear(now()); # 몇 번 째 주? / 년
select last_day(now()); # 현재 월의 마지막 일

-- 문재) 현재 날짜 기준 3년 뒤
select date_add(now(), interval 3 year); # date_add(dt, interval expr unit): 날짜 더하기
-- 문재) 현재 날짜 기준 4개월 뒤
select date_add(now(), interval 4 month); # date_add(dt, interval expr unit): 날짜 더하기
-- 문재) 현재 날짜 기준 15일 후
select date_add(now(), interval 15 day); # date_add(dt, interval expr unit): 날짜 더하기
-- 문재) 현재 날짜 기준 10일 전
select date_sub(now(), interval 10 day); # date_sub(dt, interval expr unit): 날짜 빼기

# extract(unit, from dt): 특정 날짜에서 단위 추출
# datediff(exp1, exp2): exp1 - exp2를 일 수로 반환
# date_format(dt, format): 해당 format으로 변경

-- 문제 1번) 단일행 함수를 활용해서 여행가방(luggage) 비밀번호에 해당하는 랜덤 정수 3자리 생성하기
-- select round(rand() * 1000);
select concat(truncate(rand() * 10, 0), truncate(rand() * 10, 0), truncate(rand() * 10, 0)) as '랜덤 3자리 정수';

-- 문제 2번) 한국(KOR), 미국(USA), 일본(JPN)에서 인구가 많은 도시 top 10을 출력하기
-- select name, countrycode, population from city
-- where countrycode like 'KOR' or countrycode like 'USA' or countrycode like 'JPN'
-- order by population desc
-- limit 10;

select concat_ws(':', countrycode, district, name) as '한미일에서 인구 top10 도시',
	   concat(format(population, 0), '명') as '인구'
from city
where countrycode in ('usa', 'jpn', 'kor');

-- 문제 3번) 국가 코드와 인구수를 분리하기(아래의 테이블 생성해서 하기)
-- create table t_city
-- select concat(countrycode, ' ', name, ' ', population) as city_info
-- from city
-- order by countrycode desc, population desc
-- limit 30;
select * from t_city;
select city_info, substring_index(city_info, ' ', 1) as 국가코드, substring_index(city_info, ' ', -1) as 인구수
from t_city;

select city_info, left(city_info, 3) as 국가코드, substring_index(city_info, ' ', -1)
from t_city;

-- 문제 4번) 해당 월의 마지막 요일을 출력하기
-- select now() as '특정 날짜', dayname(last_day(now())) as '주어진 날짜 기준 월의 마지막 요일';
-- select date_format('2024-07-07 09:30:05', '%Y-%m-%d %h:%i:%s') as '특정 날짜', dayname(last_day(now())) as '주어진 날짜 기준 월의 마지막 요일';
select adddate(now(), truncate(rand() * 30, 0) + 60) as 특정날짜,
	   dayname(last_day(adddate(now(), truncate(rand() * 30, 0) + 60))) as 요일;

# 4. 변환 함수
-- cast
select cast(10.34 as char) as c1,
cast('10.34' as signed) as c2,
cast('10.34' as decimal) as c3,
cast('10.34' as decimal(6, 3)) as c4,
cast('102.34' as double) as c5,
cast('2024-03-03' as date) as c6,
cast('2024-03-03' as datetime) as c7,
cast(date_format('2024-03-03', '%Y-%m-%d') as char) as c8;

-- convert
select convert(10.34, char) as c1,
convert('10.34', signed) as c2,
convert('10.34', decimal) as c3,
convert('10.34', decimal(6, 3)) as c4,
convert('102.34', double) as c5,
convert('2024-03-03', date) as c6,
convert('2024-03-03', datetime) as c7,
convert(date_format('2024-03-03', '%Y-%m-%d'), char) as c8;

# 5. 일반 함수
select database(), user(), schema();

-- 제어문
select case 1 when 0 then '오예상'
			  when 1 then '손해배상'
              end as '취업완료',
       case 9 when 0 then '허상'
			  when 1 then '근상'
              else '아무도 없음' end as 'sql 복습한 사람',
		case when 33 between 10 and 19 then '10대'
			 when 33 between 20 and 29 then '20대'
             when 33 between 10 and 19 then '30대'
             else '30대 이상' end as '연령대';
         
         
/* 문제
1. 인구가 4000만명 ~ 6000만명에 해당하는 국가 정보를 조회하기
2. 국가별 독립연도 정보를 확인해서 가장 일찍 개국한 나라 top10을 조회하기
*/
# 1
select * from country;
select code, concat(name, "(", Continent, ")") as country_name, region, population
from country
where population <= 60000000 and population >= 40000000;

# 2
select * from country;
select row_number() over(order by indepyear) as No, name, indepyear as 독립년도
from country
where indepyear is not null
order by IndepYear
limit 10;