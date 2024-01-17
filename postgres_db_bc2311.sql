create table nationality (
	id serial primary key,
	nat_code VARCHAR(2) unique,
	nat_desc VARCHAR(50) not null
);
create table author (
	id serial primary key,
	author_name VARCHAR(50) not null,
	nat_code VARCHAR(2) not null,
	constraint fk_author_nat_code foreign key (nat_code) references nationality(nat_code)
);

create table book (
	id serial primary key,
	author_id integer,
	book_name VARCHAR(50) not null,
	constraint fk_book_author_id foreign key (author_id) references author(id)
);
create table users (
	id serial primary key,
	user_name VARCHAR(50) not null
);
create table user_contact (
	id serial primary key,
	user_id integer unique, -- unique +fk -> one to one
	user_phone varchar(100) not null,
	user_email varchar(100),
	constraint fk_user_contract_user_id foreign key (user_id) references users(id)
);
create table borrow_history(
	id serial primary key,
	user_id integer not null,
	book_id integer not null,
	borrow_date timestamp not null,
	constraint fk_borrow_history_user_id foreign key (user_id) references users(id),
	constraint fk_borrow_history_book_id foreign key (book_id) references book(id)
);
create table return_history(
	id serial primary key,
	borrow_id integer not null,
	return_date timestamp not null,
	constraint fk_return_history_borrow_id foreign key (borrow_id) references borrow_history(id)
);
insert into nationality(nat_code, nat_desc) values ('HK','Hong Kong');
insert into nationality(nat_code, nat_desc) values ('SG','Singapore');
select * from nationality;

insert into author (author_name,nat_code) values ('Peter Pan','SG');
insert into author (author_name,nat_code) values ('Selena Li','HK');
insert into author (author_name,nat_code) values ('Ben Tao','HK');
select * from author;

insert into book (author_id,book_name) values (1,'Flying Peter Pan');
insert into book (author_id,book_name) values (2,'Modern Autumn Makeup');
insert into book (author_id,book_name) values (3,'Hong Kong Future');
select * from book;

insert into users (user_name) values ('Suki Lau');
insert into users (user_name) values ('Zoe Li');
insert into users (user_name) values ('Charles Lau');
select * from users;

insert into user_contact (user_id,user_phone,user_email) values (1,'65324578', 'sukilau@hotmail.com');
insert into user_contact (user_id,user_phone,user_email) values (2,'56789654', 'zoeli@hotmail.com');
select * from user_contact;

insert into borrow_history (user_id,book_id,borrow_date) values (1,2,'2024-01-08 04:05:06');
insert into borrow_history (user_id,book_id,borrow_date) values (2,1,'2024-01-09 15:05:16');
insert into borrow_history (user_id,book_id,borrow_date) values (2,3,'2024-01-10 12:00:22');
insert into borrow_history (user_id,book_id,borrow_date) values (2,3,'2023-01-10 12:00:22');
select * from borrow_history;
insert into return_history (borrow_id,return_date) values (1,'2024-01-09 10:10:06');
insert into return_history (borrow_id,return_date) values (2,'2024-01-11 16:05:16');
insert into return_history (borrow_id,return_date) values (3,'2024-01-12 13:00:22');
insert into return_history (borrow_id,return_date) values (5,'2023-01-12 13:00:22');
select * from return_history;

select bh.borrow_date, u.user_name,
b.book_name, a.author_name, n.nat_code, n.nat_desc
from borrow_history bh,book b, users u, author a, nationality n
where bh.book_id = b.id
and bh.user_id=u.id
and b.author_id = a.id
and n.nat_code = a.nat_code;

select user_id from borrow_history group by user_id;

with a as (select bh.id as id,bh.user_id as userId, max(extract (day from (rh.return_date - bh.borrow_date))) as max from borrow_history bh, return_history rh
where bh.id = rh.borrow_id
group by bh.id,bh.user_id
		  order by max desc limit 1)
select u.user_name from a , users u
-- select * from a , users u
where u.id = a.userId
;

with borrow_days_per_user as (
	select bh.user_id, sum(EXTRACT (DAY FROM(rh.return_date - bh.borrow_date))) as borrow_days
	from borrow_history bh, return_history rh, users u
	where bh.id = rh.borrow_id
	and u.id=bh.user_id
	group by bh.user_id
)
select bd.user_id, u.user_name, bd.borrow_days
from borrow_days_per_user bd, users u
where borrow_days in (select max(borrow_days) from borrow_days_per_user)
and bd.user_id = u.id;

-- return book never borrowed
select b.id  from borrow_history bh right join book b
on bh.book_id = b.id
where bh.book_id is null;

-- return person never borrowed book
select u.user_name  from borrow_history bh right join users u
on bh.user_id = u.id
where bh.id is null;

-- all user and book no matter user or book has borrow history
select u.user_name, b.book_name from users u left join borrow_history bh on u.id = bh.user_id left join book b on b.id = bh.book_id
union
select u.user_name, b.book_name from book b left join borrow_history bh on b.id = bh.book_id left join users u on u.id = bh.user_id;

-- Approach 1: not exists
select *
from users u
where not exists (select 1 from borrow_history bh where bh.user_id = u.id)

-- Approach 2: left join
select *
from users u left join borrow_history bh on bh.user_id = u.id
where bh.user_id is null;

-- Find the book(s), which has no borrow history
insert into book (author_id, book_name) values ('1', 'XYZ BOOK');

-- Approach 1: not exists
select *
from book b
where not exists (select 1 from borrow_history bh where bh.book_id = b.id)

-- Approach 2: left join
select *
from book b left join borrow_history bh on bh.book_id = b.id
where bh.book_id is null;

-- Find all users and books, no matter the user or book has borrow history.
select *
from borrow_history bhßß
	full outer join users u on u.id = bh.user_id
	full outer join book b on b.id = bh.book_id
;	
SELECT BH.USER_ID, TO_CHAR(BH.BORROW_DATE,'YYYYMM') AS BORROW_MONTH, COUNT(BH.BORROW_DATE) 
		FROM BORROW_HISTORY BH 
		GROUP BY BH.USER_ID, TO_CHAR(BH.BORROW_DATE,'YYYYMM');

CREATE OR REPLACE FUNCTION CREATE_USER (IN USER_NAME VARCHAR) RETURNS VOID AS $$
BEGIN
	INSERT INTO USERS VALUES (USER_NAME);
END;
$$ LANGUAGE plpgsql;
DROP TABLE  report_management_id_1;
CREATE TABLE report_management_id_1 (
	report_id SERIAL primary key,
	report_date timestamp not null,
	borrow_month VARCHAR not null,
	user_id int,
	no_of_book int not null,
	constraint fk_report_management_id_1_user_id foreign key (user_id) references users(id)
);
-- task: create procedure/function to automate mgt report data extraction

SELECT BH.USER_ID, 
		TO_CHAR(BH.BORROW_DATE,'YYYYMM') AS BORROW_MONTH, 
		COUNT(1) AS NUM_OF_BOOK
		FROM BORROW_HISTORY BH 
		WHERE TO_CHAR(BH.BORROW_DATE,'YYYY') = '2024'
		GROUP BY BH.USER_ID, TO_CHAR(BH.BORROW_DATE,'YYYYMM')

CREATE OR REPLACE FUNCTION INSERT_MANAGEMENT_REPORT (IN BORROW_YEAR VARCHAR) RETURNS VOID AS $$
-- 	DECLARE RECORD BORROW_HISTORY%ROWTYPE;
	DECLARE 
		RECORD RECORD; -- 2nd RECORD is data type 
BEGIN
	FOR RECORD IN
		SELECT BH.USER_ID, 
		TO_CHAR(BH.BORROW_DATE,'YYYYMM') AS BORROW_MONTH, 
		COUNT(1) AS NUM_OF_BOOK
		FROM BORROW_HISTORY BH 
		WHERE TO_CHAR(BH.BORROW_DATE,'YYYY') = BORROW_YEAR
		GROUP BY BH.USER_ID, TO_CHAR(BH.BORROW_DATE,'YYYYMM')
	LOOP
		IF RECORD.NUM_OF_BOOK>1 THEN
		INSERT INTO report_management_id_1
		(report_date,borrow_month,user_id,no_of_book)
		VALUES
		(CURRENT_DATE,RECORD.BORROW_MONTH, RECORD.USER_ID, RECORD.NUM_OF_BOOK);
		END IF;
	END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT INSERT_MANAGEMENT_REPORT('2023');

SELECT * FROM report_management_id_1;
truncate report_management_id_1;
alter table users
add borrow_times integer not null default 0;

-- when someone insert data into borrow_history , users.borrow_times +1 (update);

CREATE OR REPLACE FUNCTION BORROW_TIME_INCREMENT () 
RETURNS TRIGGER AS $$
BEGIN
	update users set borrow_times = borrow_times+1 where id = new.user_id;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- sometimes, for audit purpose, we can have separate table to store data update history
CREATE OR REPLACE TRIGGER my_trigger
AFTER INSERT
ON borrow_history
FOR EACH ROW
EXECUTE FUNCTION BORROW_TIME_INCREMENT();

-- trigger event (insert into borrow_history)
insert into borrow_history 
(user_id,book_id,borrow_date)
values
(2,1,'2023-01-15 12:00:00');

select * from borrow_history;
select * from users;

update users u1
set
u1.borrow_times = u2.count
from 
(select u.id as id, count(bh.user_id) as count
from users u
left join borrow_history bh
on u.id = bh.user_id
group by u.id) u2
where u1.id = u2.id;


UPDATE Users uOrig
    SET bUsrActive = false
FROM Users u
      LEFT JOIN Users u2 ON u.sUsrClientCode = u2.sUsrClientCode AND u2.bUsrAdmin = 1 AND u2.bUsrActive = 1
WHERE u.bUsrAdmin = 0 AND u.bUsrActive = 1 AND u2.nkUsr IS NULL
    and uOrig.sUsrClientCode = u.sUsrClientCode;

select u.id, count(bh.user_id) 
from users u
left join borrow_history bh
on u.id = bh.user_id
group by u.id;

