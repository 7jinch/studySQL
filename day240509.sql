/* DDL */
create database if not exists youDB; # 데이터베이스 생성
drop database youDB; # 데이터베이스 삭제

use youDB; # 데이터베이스 접속
select database(), user(); # 접속한 데이터베이스와 유저 정보 보기

# 테이블 생성
create table my_dsa
(
	sno varchar(20),
    sname varchar(100),
    grade tinyint,
    class varchar(50),
    gender varchar(20),
    age smallint,
    enter date
);

# 확인
desc my_dsa;
select * from my_dsa;

# 테이블 삭제
drop table my_dsa;

/* DML */
desc my_dsa;
insert into my_dsa(sno, sname) values(1, 1); # 데이터 삽입
insert into my_dsa value(1, 2, 3, 4, 5, 6,  now());
insert into my_dsa values(2, 2, 3, 4, 5, 6, '2024-01-31');

delete from my_dsa; # 데이터 삭제
delete from my_dsa where sno = 1;

drop table my_dsa;

# 제약조건 추가하면서 테이블 생성하기
create table my_dsa
(
	sno varchar(20) not null,
    sname varchar(100) not null,
    grade tinyint,
    class varchar(50),
    gender varchar(20),
    age smallint,
    enter date
);
desc my_dsa;

insert into my_dsa(sno, sname, grade, class, gender) values(3, 4, 1, 1, 1);
insert into my_dsa(sno, sname) values(3, 4);

select * from my_dsa;

# 테이블 생성 후에 not null 제약조건 추가하기
# 기존의 데이터가 부정되면 제약조건 추가 못 함
alter table my_dsa
modify gender varchar(20) not null;

select * from my_dsa;
desc my_dsa;

drop table my_dsa;

alter table my_dsa
modify class varchar(50) not null;

select * from my_dsa;
desc my_dsa;

delete from my_dsa;

insert into my_dsa(sno, sname, class, gender) values(3, 4, 1, 1);

# 
alter table my_dsa
add primary key(sno);

select * from my_dsa;
desc my_dsa;