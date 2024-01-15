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
select * from borrow_history;
insert into return_history (borrow_id,return_date) values (1,'2024-01-09 10:10:06');
insert into return_history (borrow_id,return_date) values (2,'2024-01-11 16:05:16');
insert into return_history (borrow_id,return_date) values (3,'2024-01-12 13:00:22');
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