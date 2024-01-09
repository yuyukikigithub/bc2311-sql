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

insert into customer (id, cust_name, email_addr, cust_phone) values (1,'John Lau', 'johnlau@hotmail.com','12315676');

TRUNCATE TABLE customer;