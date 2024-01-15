-- show databases;
-- create database db_bc2311;
use db_bc2311;

-- CREATE USER 'yukilau'@'localhost' IDENTIFIED BY 'password';

-- ALTER USER 'yukilau'@'localhost' IDENTIFIED BY 'root';

-- GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'yukilau'@'localhost' WITH GRANT OPTION; 

-- SHOW variables LIKE 'yuki';

-- select user from mysql.user;

CREATE TABLE customer (
	id integer not null,
    cust_name varchar(50) not null,
    email_addr varchar(30) ,
    cust_phone varchar(50)
);

select * from customer;
select * from supplier;
use db_bc2311;
delete from customer;
insert into customer (id, cust_name, email_addr, cust_phone) values (1,'John Lau', 'johnlau@hotmail.com','12315676');
insert into customer (id, cust_name, email_addr, cust_phone) values (2,'Joanne Lau', 'joannelau@hotmail.com','12315676');
insert into customer (id, cust_name, email_addr, cust_phone) values (3,'Albert Law', 'albertlaw@hotmail.com','12315676');
insert into customer (id, cust_name, email_addr, cust_phone) values (4,'Kenn Ng', 'kennng@hotmail.com','12315676');
insert into customer (id, cust_name, email_addr, cust_phone) values (5,'Deb Ng', 'debng@hotmail.com','12315676');
insert into customer (id, cust_name, email_addr, cust_phone) values (6,'Kar Ng', 'karng@hotmail.com','12315676');

update customer 
set cust_phone='78456123'
where id=6;
update customer 
set email_addr=REPLACE(email_addr,'hotmail.com','gmail.com')
where id=5;
select * from customer order by id desc;
select * from customer where cust_name = 'John Lau' or email_addr like '%albert%';
select * from customer where email_addr like '%@%';
select * from customer where cust_name in ('John Lau','Joanne Lau') order by cust_name desc, cust_phone asc;
select * from customer  order by cust_name desc, cust_phone asc;
select * from customer where id<=2 order by email_addr;

select cust_phone, count(*) from customer group by cust_phone;

alter table customer add join_date date;

update customer set join_date = '2005-03-31' where id=3;
update customer set join_date = str_to_date('2000-03-31','%Y-%m-%d') where id=2;
update customer set join_date = str_to_date('98-04-30','%y-%m-%d') where id=1;

-- VARCHAR, INTEGER, DATE, DECIMAL, DATETIME
ALTER TABLE customer add score decimal(5,2);

update customer set score = 0;

update customer set score=50.0 where id = 1;
update customer set score=60.2 where id=3;
-- by default, should provide all column information in order
insert into customer values (7,'Tom Chan', 'tomchan@gmail.com','23456543','2004-04-08',98.3);

alter table customer add last_transaction_time datetime;
update customer set last_transaction_time = sysdate();


select * from customer where join_date between '1990-01-01' and '2000-01-10';
-- ifnull, treat null as another specified value
select * from customer where ifnull(score,100) >= 20;
update customer set score = 76.7 where id=5;
select * from customer where score >= 90;

CREATE TABLE supplier (
	id integer NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sup_company varchar(50) not null,
    sup_contact_person varchar(50) not null,
    email_addr varchar(30) ,
    sup_phone varchar(50)
);

insert into supplier (sup_company, sup_contact_person, sup_phone) values ('ABC Com', 'Nancy Si', '78945368');
insert into supplier (sup_company, sup_contact_person, sup_phone) values ('DEF Com', 'Bella Ng', '68946432');
update supplier set email_addr = 'nancysi@abc.com';
update supplier set create_date = sysdate();
alter table supplier add create_date date;
alter table supplier drop column create_date;

-- some existing data length> alteration info, fail to alter
alter table customer modify column email_addr varchar(50);
update customer set email_addr = 'jnfienieinvonoienobennboeifoieknfo@gmail.com' where id = 4;

-- coalesce() == ifnull()
select * from customer where coalesce(score, 50)>0 and ifnull(score,100)<1000;
select id, upper(cust_name), email_addr from customer;

select substring(sup_company,1,5) as sub_string, 
	length(sup_company) as length ,
	concat(REPLACE(sup_company,' ','_'),'_', email_addr) as description ,
    left(email_addr,4),
    right(email_addr,4),
    instr(email_addr, '@')
from supplier s;

-- cannot detect upper/ lower case
select * from customer where cust_name = 'john lau';
-- COLLATE utf8mb4_bin // to be case sensitive
select * from customer where cust_name COLLATE utf8mb4_bin = 'john lau';

-- %, _ // _ represent one chararter
select * from customer where cust_name like '_ohn%';

-- column and row also // 1, dummy value
-- ceiling // upper int
-- floor // lower int
-- date_add(column, interval 3 day) , date_add(column, interval 3 year)
-- datediff('2020-01-01',column) no of day between column and the date
select c.*, 1, 'dummy value' as dummy, round(c.score,1), ceil(c.score), 
	floor(c.score), abs(score), power(score,2), date_add(join_date, interval 3 month), 
    date_sub(join_date, interval 3 month),
    join_date+ interval 1 day,
    -- join_date - 1
    join_date- interval 1 day,
    datediff('2020-01-01',join_date) ,
    now() 
    from customer c ;

-- case 
select cust_name,
	case
		when score< 20 then 'fail'
        when score< 80 then 'pass'
        when score< 100 then 'excellent'
        else 'N/A'
        end as Grade
from customer;

-- primary key is one of the constraint not null unique
create table department(
	id integer primary key,
    dept_name varchar(50),
    dept_code varchar(10)
);

create table employee (
	id integer primary key, 
    staff_id varchar(50),
    staff_name varchar(50),
    hkid varchar(10) unique,
    dept_id integer,
    foreign key (dept_id) references department(id)
);
-- one to one // employee vs employee_contact_info
create table employee_contact_info (
	id integer primary key, 
    phone varchar(50),
    foreign key (id) references employee(id)
);
alter table employee add country_id integer;
alter table employee add constraint fk_country_id foreign key (country_id) references country(id);
create table country (
	id integer primary key,
    country_code varchar(2) unique,
    description varchar(50)
);

insert into department values (1,'Human Resources', 'HR');
insert into department values (2,'Information Technology', 'IT');
insert into department values (3,'Administration', 'ADMIN');


insert into employee values(1, '001', 'Terry Lam', 'A1234342',2);
insert into employee values(2, '002', 'Plastic Lung', 'B1234352',1);
-- insert into employee values(3, '003', 'Bill Lung', 'C1245687',4); error dept_id not exist
insert into employee values(3, '003', 'Bill Lung', 'C1245687',2);
insert into employee (id,staff_id,staff_name,hkid) values(4, '004', 'Chill Leung', 'D8945687');

insert into country values(1, 'HK', 'Hong Kong');
insert into country values(2, 'US', 'United State');

insert into employee_contact_info values(1, '45679831');

select * from department;
select * from employee;

select * from employee e inner join department d;
-- vs 
select * from employee e inner join department d
on e.dept_id = d.id;

select e.id, e.staff_id, e.staff_name, e.hkid, e.dept_id, d.dept_name , c.country_code, c.description
from employee e 
inner join department d 
on e.dept_id = d.id
inner join country c 
on e.country_id = c.id;
 -- vs 
select e.id, e.staff_id, e.staff_name, e.hkid, e.dept_id, d.dept_name , c.country_code, c.description
from employee e , department d ,country c 
where e.dept_id = d.id
and e.country_id = c.id;
-- vs 
select a.code from (select c.country_code code, count(*) count
from employee e 
inner join department d 
on e.dept_id = d.id
inner join country c 
on e.country_id = c.id
group by c.country_code) a
where count>1;

select e.id, e.staff_id, e.staff_name, e.hkid, e.dept_id, d.dept_name , c.country_code, c.description
from employee e 
inner join department d 
on e.dept_id = d.id
inner join country c 
on e.country_id = c.id;

select * from employee;
update employee set country_id = 1;

select * 
from department d right join employee e on e.dept_id = d.id;

update employee set country_id = 2 where id=3;

-- group by, aggregated function
select e.dept_id 
from employee e
group by e.dept_id having count(*)>1;
update employee set dept_id =1 where id=4;
alter table employee add column yaer_of_exp int;
alter table employee rename column yaer_of_exp to year_of_exp ;

select e.dept_id , min(year_of_exp)
from employee e group by e.dept_id;

select max(year_of_exp) from employee;

-- sub query
select * from employee where year_of_exp=(select max(year_of_exp) from employee);

-- CTE
with max_year_of_exp as (
	select max(year_of_exp) as max_exp from employee
)
select * from employee e, max_year_of_exp x where e.year_of_exp = x.max_exp;


select e.dept_id, count(1) as no_of_emp
from employee e, department d 
where e.dept_id = d.id
and d.dept_code in ('IT', 'MK') -- filter record before group by
group by e.dept_id
having count(1) >1 ; -- filter group after group by

-- distinct 2 fields - all fields checking if the value is duplicated
select distinct country_id, staff_name from employee;

update customer set score = 50.0 where id = 3;

-- remove dup record accrod to name only
select e.staff_name from employee e
union
select c.cust_name from customer c;
-- remove dup record accrod to id and name only
select e.id, e.staff_name from employee e
union
select c.id, c.cust_name from customer c;

-- uinion all: show all record from all result set
select e.id, e.staff_name from employee e
union all
select c.id, c.cust_name from customer c;