# 현재 데이터베이스들 보기
show databases;
# world라는 데이터베이스 사용하기
use world;
# 현재 데이터베이스(world)의 테이블들 보기
show tables; 
# city라는 테이블 보기
desc city;

# 1. 전세계 도시 수: 4079
select count(*) from city;

# 2. 전세계 나라의 수: 239
select distinct count(*) from country;

# 3. 한국의 도시들 확인
select Name as 도시명, District as 지역명 from city where CountryCode = 'KOR';# 한국의 도시 확인
select count(*) from city where CountryCode like 'KOR'; # 한국의 도시 개수는 70개(like 연산자도 가능)

select distinct District from city where CountryCode = 'KOR'; # 한국의 지역 확인
select count(distinct District) from city where CountryCode = 'KOR'; # 한국의 지역 수는 15개

# 4. 한국에서 지역명이 "C"로 시작하는 지역의 도시 수는 몇 개이고, 어떤 도시가 있는지 확인
select name as 도시명, CountryCode as 국가코드, District as 지역명
from city
where District Like "C%" and CountryCode like binary "KOR"; # 한국에서 지역명이 "C"로 시작하는 도시 확인
select count(*) from city
where District Like "C%" and CountryCode like "KOR"; # 한국에서 지역명이 "C"로 시작하는 도시의 개수는 21개