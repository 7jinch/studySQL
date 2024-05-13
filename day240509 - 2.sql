create database if not exists youDB;
use youDB;
select database(), user();

create table box_office (
	seq_no int primary key,
    years smallint,
    ranks int,
    movie_name varchar(200),
    release_date datetime,
    sale_amt double,
    share_rate double,
    audience_num int,
    screen_num smallint,
    showing_count int,
    rep_country varchar(50),
    countries varchar(100),
    distributor varchar(300),
    movie_type varchar(100),
    genre varchar(100),
    director varchar(1000)
);

drop table box_office;

desc box_office;

select count(*) from box_office;
select * from box_office limit 1;

/* 문제
3. 2019년 개봉한 영화 중 관객 수가 500만명 이상이거나 매출액이 300억원 이상인 영화는?
4. 2014년에 제작됐지만 2018년, 2019년에 개봉한 영화는?
*/
desc box_office;
select * from box_office limit 1;
# 3
select years, ranks, movie_name, release_date, audience_num, concat(LEFT(round(sale_amt, -8), LENGTH(round(sale_amt, -8)) - 8), '억') as t_sales
from box_office
where year(release_date) = 2019 and
(audience_num >= 5000000 or sale_amt >= 30000000000)
order by ranks;

# 4
select * from box_office
where years = 2014 and
(year(release_date) = 2018 or year(release_date) = 2019);


/* 다행함수(그룹함수) */
use world;
select database(), user();

select countrycode, count(name)
from city
group by countrycode with rollup;

/* 문제
1. 인구가 200만명이 넘는 도시가 각 국가별로 몇 개인지 확인하기
2. 1번의 조회 내용에서 200만명이 넘는 도시를 4개 이상 보유하고 있는 국가 조회하기
3. 독립년도 정보가 있는 국가와 없는 국가의 수 조회하기
*/
# 1
select * from city limit 1;

select countrycode, count(name) as 'num of city'
from city
where population >= 2000000
group by CountryCode;

# 2
select countrycode, count(name) as 'num of city'
from city
where population >= 2000000
group by CountryCode
having count(name) >= 4
order by count(name) desc;

# 3
use world;

select * from country order by indepYear;

-- select count(*) as ' 총 국가수',
-- 	   count(case when indepYear is null then 0 end) as '독립년도가 없는 국가',
--        count(case when indepYear is not null then 0 end) as '독립년도가 있는 국가'
-- from country;

select
	count(*) as "모든 국가",
	sum(if(indepYear is null, 1, 0)) as "독립연도가 없는 국가",
    sum(if(indepYear is not null, 1, 0)) as "독립연도가 있는 국가"
from country;

/* 문제
4. 2004년 ~ 2013년 10년간 년도별 개봉한 영화 수와 각 연도별 상하반기 개봉한 영화수 또는 요일별 개봉 영화 수를 확인하세요
*/
use youDB;
select * from box_office;

select
    sum(if(month(release_date) <= 6, 1, 0)) as '상반기 개봉 영화',
    sum(if(month(release_date) >= 7, 1, 0)) as '하반기 개봉 영하'
from box_office;

-- 상하반기 개봉 영화
select
	year(release_date),
	count(release_date) as "연도별 개봉 영화 수",
    sum(if(month(release_date) <= 6, 1, 0)) as '상반기 개봉 영화',
    sum(if(month(release_date) >= 7, 1, 0)) as '하반기 개봉 영하'
from box_office
where year(release_date) between 2004 and 2013
group by year(release_date)
order by  year(release_date);

-- 요일별 개봉 영화
select
	year(release_date),
--     release_date,
--     dayname(release_date),
--     date_format(release_date, '%w'),
	count(*) as "전체 영화",
    sum(case date_format(release_date, '%w') when 0 then 1 else 0 end) as "일 - 개봉",
    sum(case date_format(release_date, '%w') when 1 then 1 else 0 end) as "월 - 개봉",
    sum(case date_format(release_date, '%w') when 2 then 1 else 0 end) as "화 - 개봉",
    sum(case date_format(release_date, '%w') when 3 then 1 else 0 end) as "수 - 개봉",
    sum(case date_format(release_date, '%w') when 4 then 1 else 0 end) as "목 - 개봉",
    sum(case date_format(release_date, '%w') when 5 then 1 else 0 end) as "금 - 개봉",
    sum(case date_format(release_date, '%w') when 6 then 1 else 0 end) as "토 - 개봉"
from box_office
where year(release_date) between 2004 and 2013
group by year(release_date)
order by year(release_date);

/* 문제
5. 16년에 개봉한 영화 배급사 정보 조회하기
단 배급사의 총 매출액 산출시 개별 영화 매출 2억원 미만은 재회한 총 매출액이 100억 ~ 1500억에 해당하는 배급사만 조회하기
*/
select * from box_office;

select
	distributor as '배급사',
	count(distributor) as '2016년 2억원 이상 총 개봉수',
    concat(format(round(sum(sale_amt) / 100000000, 0), 0), '억원') as '2016년 매출',
    sum(case quarter(release_date) when 1 then 1 else 0 end) as q1,
	sum(case quarter(release_date) when 2 then 1 else 0 end) as q2,
	sum(case quarter(release_date) when 3 then 1 else 0 end) as q3,
	sum(case quarter(release_date) when 4 then 1 else 0 end) as q4
from box_office
where sale_amt >= 200000000 and year(release_date) = 2016
group by distributor
having sum(sale_amt) between 10000000000 and 150000000000
order by sum(sale_amt) desc;

/* 문제
6. 영화 유형별 매출을 출력하기
7. 대륙별 면적크기, 인구수, 국가수 조회하기
*/
# 6
use youDB;
select * from box_office;

select
	case grouping(movie_type) when 1 then '총계' else movie_type end as "영화 유형",
    concat(format(round(sum(sale_amt) / 100000000, 0), 0), '억원') as "매출"
from box_office
group by movie_type with rollup
order by sum(sale_amt) desc;

# 7
use world;
select * from country;

# 1)
select Continent, sum(SurfaceArea)
from country
group by Continent
order by sum(SurfaceArea) desc;

# 2)
select Continent, sum(Population)
from country
group by Continent
order by sum(Population) desc;

# 3)
select Continent, count(Name)
from country
group by Continent
order by count(Name) desc;

# 4)
select Continent, sum(Population)
from country
group by Continent
order by sum(Population) asc;

/* 문제
8. 2008년 ~ 2018년까지 상위 20위까지의영화 매출과 나머지 순위 영화 매출을 비교하기
9. 2010년 ~ 2019년까지 연도별 국가별 관객수를 비교하기
10. 연도별로 국가별(한국, 미국)로 100만명 이상의 관객이 보았던 영화는 몇 개?
*/
# 8
use youDB;
select * from box_office;

select
	year(release_date) as "연도",
	concat(format(sum(case when ranks <= 20 then sale_amt else 0 end) / 100000000, 0), "억") as "상위 20위 매출",
    concat(format(sum(case when ranks <= 20 then 0 else sale_amt end) / 100000000, 0), "억") as "나머지 매출",
    count(case when ranks <= 20 then null else 0 end) as "상위 20위 영화 개수"
from box_office
where year(release_date) between 2008 and 2018
group by year(release_date)
order by year(release_date);

# 9
select
	year(release_date) as "연도",
    concat(format(sum(audience_num), 0), "명") as "총 관객수",
    concat(format(sum(case rep_country when "한국" then audience_num else 0 end), 0), "명") as "한국 관객",
    concat(format(sum(case rep_country when "미국" then audience_num else 0 end), 0), "명") as "미국 관객",
    concat(format(sum(case rep_country when "일본" then audience_num else 0 end), 0), "명") as "일본 관객",
    concat(format(sum(case rep_country when "영국" then audience_num else 0 end), 0), "명") as "영국 관객",
    concat(format(sum(case rep_country when "프랑스" then audience_num else 0 end), 0), "명") as "프랑스 관객",
    concat(format(sum(case rep_country when "독일" then audience_num else 0 end), 0), "명") as "독일 관객"
from box_office
where year(release_date) between 2010 and 2019
group by year(release_date)
order by year(release_date) desc;

# 10
select
	year(release_date) as "연도",
    concat(count(movie_name), "회") as "100만명 이상 영화 수",
    concat(count(case rep_country when "한국" then 0 else null end), "회") as "한국 회 수",
    concat(count(case rep_country when "미국" then 0 else null end), "회") as "미국 회 수"
from box_office
where year(release_date) >= 2015 and audience_num >= 1000000
group by year(release_date)
order by year(release_date);