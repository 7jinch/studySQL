use world;
show tables;
desc city;

-- select  length('정제완') as length함수테스트;

-- select concat(Name, " : " , Population) as 도시별인구수 from city # concat 함수: 그냥 하나로 함쳐짐
-- order by Name desc; # 정렬은 기본적으로 오름차순이지만 desc를 붙이면 내림차순이 됨

-- select Name,  Population from city
-- order by 2 desc # 2번째 컬럼을 기준으로 내림차순 정렬됨
-- limit 5; # 상위 5개만 출력

# 5. 한국의 지역명에서 2번째 글자가 'y'인 경우의 도시를 찾으세요
select * from city
where CountryCode like 'KOR'
and District like '_y%';


# 6. 전세계에서 도시의 인구가 300만명을 넘는 도시는 몇 개?
select count(*) from city
where population >= 3000000;

# 7. 한국에서 인구가 70만명 ~ 100만명인 도시를 찾으세요
select * from city
where CountryCode ='KOR'
and (population >= 700000 and population <= 1000000);

# 8. 전세계 도시 이름 4번째 단어에 'j' 또는 'w'가 들어가는 도시 중에서 인구가 50만명이 넘는 도시의 도시명, 인구, 국가코드명을 조회하세요
select name as 도시명, population as 인구수, CountryCode as 국가코드명 from city
where  population >= 500000 and
(name like '___j%' or name like '___w%');
-- substr(name, 4, 1) in ('j', 'w');

# 8번 문제를 서브쿼리를 활용해서 풀어보기
select name as 도시명, population as 인구수, CountryCode as 국가코드명
from (select * from city where name like '___j%' or name like '___w%') sub # 서브쿼리 활용
where population >= 500000;

# 9. 인구수가 가장 많은 도시 5곳 출력하기
select * from city
order by Population desc limit 5;

select * from(select name, Population from city order by 2 desc) as sub
limit 5;

# 10. 세계에서 특정 언어가 해당 지역에서 5% 미만으로 사용되고 있지만 공식적인 언어로 지정된 경우는?
select count(*) from countrylanguage
where Percentage < 5 and IsOfficial like "T"
order by Percentage desc;

# 그리고 사용비율을 기준으로 내림정렬했을 때 상위 10개를 출력하기
select * from countrylanguage
where Percentage < 5 and IsOfficial like "T"
order by Percentage desc limit 10;

# 11. 우리나라 도시 정보를 아래의 요구사항에 맞게 출력하세요
# 1) 지역명을 기준으로 오름차순, 인구수를 기준으로 내림차순 출력하기(출력되는 레코드의 번호도 함께 출력하기)
select row_number() over (order by District, Population desc) as 인덱스,
name as 도시명,
District as 지역명,
population as 인구수
from city
where CountryCode like 'KOR'
order by District, Population desc;

# 2) 1)에서 출력되는 내용을 바탕으로 출력 순서 23번째부터 10개를 출력하세요(출력되는 레코드의 번호도 함께 출력하기)
select row_number() over (order by District, Population desc) as 인덱스,
name as 도시명,
District as 지역명,
population as 인구수
from city
where CountryCode like 'KOR'
order by District, Population desc
-- limit 10 offset 22; # limit, offset 키워드로 몇 번째부터 몇 개를 출력할 지 정할 수 있음
limit 22, 10;