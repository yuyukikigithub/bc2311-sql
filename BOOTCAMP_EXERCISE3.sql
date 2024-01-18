CREATE DATABASE BOOTCAMP_EXERCISE3;

-- Q1a
DROP TABLE PRODUCT;
CREATE TABLE PRODUCT (
	ID SERIAL PRIMARY KEY,
	SKU VARCHAR(32) NOT NULL,
	PRODUCT_NAME VARCHAR(128) NOT NULL,
	PRODUCT_DESCRIPTION TEXT NOT NULL,
	CURRENT_PRICE DECIMAL(8,2) NOT NULL,
	QUANTITY_IN_STOCK INTEGER NOT NULL
);

CREATE TABLE CUSTOMER (
	ID SERIAL PRIMARY KEY,
	CUSTOMER_NAME VARCHAR(255) NOT NULL,
	CITY_ID INTEGER NOT NULL,
	CUSTOMER_ADDRESS VARCHAR(255) NOT NULL,
	CONTACT_PERSON VARCHAR(255),
	EMAIL VARCHAR(128) NOT NULL,
	PHONE VARCHAR(128) NOT NULL
);
DROP TABLE INVOICE;
CREATE TABLE INVOICE (
	ID SERIAL PRIMARY KEY,
	INVOICE_NUMBER VARCHAR(255) NOT NULL,
	CUSTOMER_ID INTEGER NOT NULL,
	USER_ACCOUNT_ID INTEGER NOT NULL,
	TOTAL_PRICE DECIMAL(8,2) NOT NULL,
	TIME_ISSUED VARCHAR(25) ,
	TIME_DUE VARCHAR(25),
	TIME_PAID VARCHAR(25),
	TIME_CANCELED VARCHAR(25),
	TIME_REFUNDED VARCHAR(25),
	constraint FK_INVOICE_CUSTOMER_ID foreign key (CUSTOMER_ID) references CUSTOMER(ID)
);

CREATE TABLE INVOICE_ITEM (
	ID SERIAL PRIMARY KEY,
	INVOICE_ID INTEGER,
	PRODUCT_ID INTEGER,
	QUANTITY INTEGER,
	PRICE DECIMAL(8,2),
	LINE_TOTAL_PRICE DECIMAL(8,2),
	constraint FK_INVOICE_ITEM_INVOICE_ID foreign key (INVOICE_ID) references INVOICE(ID),
	constraint FK_INVOICE_ITEM_PRODUCT_ID foreign key (PRODUCT_ID) references PRODUCT(ID)
);
-- Q1b
INSERT INTO CUSTOMER 
(CUSTOMER_NAME, CITY_ID, CUSTOMER_ADDRESS, CONTACT_PERSON, EMAIL, PHONE)
VALUES
('Drogerie Wien',1,'Deckergasse 15A','Emil Steinbach','emil@drogeriewien.com','094234234'),
('Cosmetics Store',4,'Watling Street 347','Jeremy Corbyn','jeremy@c-store.org','093923923'),
('Kosmetikstudio',3,'Rothenbaumchaussee 53','Willy Brandt','willy@kosmetikstudio.com','0941562222'),
('Neue Kosmetik',1,'Karlsplatz 2',null,'info@neuekosmetik.com','094109253'),
('Bio Kosmetik',2,'Motzstrabe 23','Clara Zetkin','clara@biokosmetik.org','093825825'),
('K-Wien',1,'Karntner Strabe 204','Maria Rauch-Kallat','maria@kwien.org','093427002'),
('Natural Cosmetics',4,'Clerkenwell Road 14b','Glenda Jackson','glena.j@natural-cosmetics.com','093555123'),
('Kosmetik Plus',2,'Unter Dne Linden 1','Angela Merkel','angela@k-plus.com','094727727'),
('New Line Cosmetics',4,'Devonshire Street 92','Oliver Cromwell','oliver@nlc.org','093202404');

insert into product
(sku, product_name ,product_description ,current_price, quantity_in_stock)
values
('330120','Game Of Thrones -URBAN DECAY','Game Of Thrones Eyeshadow Palette',65,122),
('330121','Advanced Night Repair -ESTEE LAUDER','Advanced Night Repair Synchronized Recovery Complex Il',98,51),
('330122','Rose Deep Hydration -FRESH','Rose Deep Hydration Facial Toner',45,34),
('330123','Pore-Perfecting Moisturizer – TATCHA','Pore-Perfecting Moisturizer & Cleanser Duo',25,393),
('330124','Capture Youth – DIOR','Capture Youth Serum Collection',95,74),
('330125','Slice of Glow – GLOW RECIPE','Slice of Glow Set',45,40),
('330126','Healthy Skin - KIEHL S SINCE 1851','Healthy Skin Squad',68,154),
('330127','Power Pair! - IT COSMETICS','IT is Your Skincare Power Pair! BestSelling Moisturizer & Eye Cream Duo',80,0),
('330128','Dewy Skin Mist -TATCHA','Limited Edition Dewy Skin Mist Mini',20,281),
('330129','Silk Pillowcase – SLIP','Silk Pillowcase Duo + Scrunchies Kit',170,0);
select * from product;
insert into invoice
(invoice_number,customer_id,user_account_id,total_price,time_issued,time_due,time_paid,time_canceled,time_refunded)
values
('in_25181b07ba300c3d21c9671e991807d9',7,4,1436,'7/20/2019 3:05:07 PM','7/27/2019 3:05:07 PM','7/25/2019 9:24:12 AM',NULL,NULL),
('8fba0000f045602750209181e9052431',9,2,1000,'7/20/2019 3:07:11 PM','7/27/2019 3:07:11 PM','7/20/2019 3:10:32 PM',NULL,NULL),
('3b6638118246b6bcfd3dfcd9be487599',3,2,360,'7/20/2019 3:06:15 PM','7/27/2019 3:06:15 PM','7/31/2019 9:22:11 PM',NULL,NULL),
('dfe7f0a01a682196cac0120a9adbb550',5,2,1675,'7/20/2019 3:06:34 PM','7/27/2019 3:06:34 PM',NULL,NULL,NULL),
('2a24c2ad4440d698878a0a1a71170fa',6,2,9500,'7/20/2019 3:06:42 PM','7/27/2019 3:06:42 PM',NULL,'7/22/2019 11:17:02 AM',NULL),
('cbd304872ca6257716bcab8fc43204d7',4,2,150,'7/20/2019 3:08:15 PM','7/27/2019 3:08:15 PM','7/27/2019 1:42:45 PM',NULL,'7/27/2019 2:11:20 PM');

insert into invoice_item
(invoice_id, product_id, quantity,price, line_total_price)
values
(1,1,20,65,1300),
(1,7,2,68,136),
(1,5,10,100,1000),
(3,10,2,180,360),
(4,1,5,65,325),
(4,2,10,95,950),
(4,5,4,100,400),
(5,10,100,95,9500),
(6,4,6,25,150);
select * from invoice_item;

-- DELETE FROM CUSTOMER;
-- INSERT INTO CUSTOMER VALUES
-- (1, 'Drogerie Wien', 1, 'Deckergasse 15A', 'Emil Steinbach', 'abc@gmail.com', 123455678); INSERT INTO CUSTOMER VALUES
-- (2, 'John', 4, 'Deckergasse 1A', '9upper', 'abck@gmail.com', 12345567);
-- INSERT INTO CUSTOMER VALUES
-- (3, 'Mary', 8, 'Deckergasse 18A', '9upper', 'abcd@gmail.com', 1234556789);

-- DELETE FROM PRODUCT;
-- INSERT INTO PRODUCT VALUES
-- (1, '330120', '9UP PRODUCT', 'COMPLETELY 9UP', 60, 122);
-- INSERT INTO PRODUCT VALUES
-- (2, '330121', '9UPPER PRODUCT', 'COMPLETELY 9UPPER', 50, 50);
-- INSERT INTO PRODUCT VALUES
-- (3, '330122', '9UPPER PRODUCTS', 'SUPER 9UPPER', 40, 600);
-- INSERT INTO PRODUCT VALUES
-- (4, '330123', '9UPPER PRODUCTSS', 'SUPER COMPLETELY 9UPPER', 30, 500);

-- DELETE FROM INVOICE;
-- INSERT INTO INVOICE VALUES
-- (1, 123456780, 2, 41, 1423, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO INVOICE VALUES
-- (2, 123456780, 3, 42, 1400, NULL, NULL, NULL, NULL, NULL); INSERT INTO INVOICE VALUES
-- (3, 123456780, 2, 43, 17000, NULL, NULL, NULL, NULL, NULL);

-- DELETE FROM INVOICE_ITEM;
-- INSERT INTO INVOICE_ITEM VALUES
-- (1, 1, 1, 40, 23, 920);
-- INSERT INTO INVOICE_ITEM VALUES
-- (2, 1, 2, 4, 20, 80);
-- INSERT INTO INVOICE_ITEM VALUES
-- (3, 1, 3, 4, 10, 40);
-- INSERT INTO INVOICE_ITEM VALUES
-- (4, 1, 2, 4, 30, 120);

-- Q1c
select 'customer', c.ID, c.CUSTOMER_NAME
from customer c
left join invoice i
on c.id = i.customer_id
where i.id is null
union
select 'product', p.id,p.PRODUCT_NAME 
from product p
where not exists (select 1 from invoice_item where product_id=p.id)
;

-- Q2
CREATE TABLE EMPLOYEE (
	ID SERIAL PRIMARY KEY, 
	EMPLOYEE_NAME VARCHAR(30) NOT NULL,
	SALARY NUMERIC (8,2),
	PHONE NUMERIC (15),
	EMAIL VARCHAR(50),
	DEPT_ID INTEGER NOT NULL
);
DROP TABLE DEPARTMENT;
CREATE TABLE DEPARTMENT (
ID SERIAL PRIMARY KEY,
DEPT_CODE VARCHAR(3) NOT NULL,
DEPT_NAME VARCHAR(200) NOT NULL
	);
	
INSERT INTO EMPLOYEE VALUES 
(1,'JOHN', 20000, 90234567, 'JOHN@GMAIL.COM', 1),
(2, 'MARY', 10000, 90234561, 'MARY@GMAIL.COM', 1),
(3, 'STEVE', 30000, 90234562, 'STEVE@GMAIL.COM', 3),
(4,'SUNNY', 40000, 90234563, 'SUNNY@GMAIL.COM', 4);

SELECT * FROM EMPLOYEE;
INSERT INTO DEPARTMENT VALUES (1, 'HR', 'HUMAN RESOURCES'); 
INSERT INTO DEPARTMENT VALUES (2, '9UP', '9UP DEPARTMENT'); 
INSERT INTO DEPARTMENT VALUES (3, 'SA', 'SALES DEPARTMENT');
INSERT INTO DEPARTMENT VALUES (4, 'IT', 'INFORMATION TECHNOLOGY DEPARTMENT');
SELECT * FROM DEPARTMENT d left join EMPLOYEE e
on d.id=e.DEPT_ID ;

-- Q2a
select d.DEPT_CODE, count(e.id) from DEPARTMENT d left join EMPLOYEE e
on d.id=e.DEPT_ID group by d.DEPT_CODE
order by count(e.id) desc;
-- Q2b
DELETE FROM DEPARTMENT WHERE ID=5;
INSERT INTO DEPARTMENT VALUES (5, 'IT', 'INFORMATION TECHNOLOGY DEPARTMENT');
-- can do it, because the primary key is still unique