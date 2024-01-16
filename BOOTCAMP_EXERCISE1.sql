CREATE DATABASE BOOTCAMP_EXERCISE1;
USE BOOTCAMP_EXERCISE1;
CREATE TABLE job_grades (
	GRADE_LEVEL VARCHAR(2) PRIMARY KEY,
    LOWEST_SAL DECIMAL(7,2) ,
    HIGHEST_SAL DECIMAL(7,2)
);
CREATE TABLE regions (
	REGION_ID INT PRIMARY KEY,
    REGION_NAME VARCHAR(25) 
);
CREATE TABLE jobs (
	JOB_ID VARCHAR(10) PRIMARY KEY,
    JOB_TITLE VARCHAR(25),
    MIN_SALARY DECIMAL(7,2),
    MAX_SALARY DECIMAL(7,2)
);
CREATE TABLE countries (
	COUNTRY_ID CHAR(2) PRIMARY KEY,
    COUNTRY_NAME VARCHAR(40) ,
    REGION_ID INT ,
    FOREIGN KEY (REGION_ID) REFERENCES regions(REGION_ID)
);
CREATE TABLE locations (
	LOCATION_ID INT PRIMARY KEY,
    STREET_ADDRESS VARCHAR(25),
    POSTAL_CODE VARCHAR(12),
    CITY VARCHAR(30),
    STATE_PROVINCE VARCHAR(12),
    COUNTRY_ID CHAR(2) ,
    FOREIGN KEY (COUNTRY_ID) REFERENCES countries(COUNTRY_ID)
);
CREATE TABLE departments (
	DEPARTMENT_ID INT PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(30) ,
    MANAGER_ID INT ,
    LOCATION_ID INT,
    FOREIGN KEY (LOCATION_ID) REFERENCES locations(LOCATION_ID)
) ;
CREATE TABLE employees (
	EMPLOYEE_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(20),
    LAST_NAME VARCHAR(25),
    EMAIL VARCHAR(25),
    PHONE_NUMBER VARCHAR(20),
    HIRE_DATE DATE,
    JOB_ID  VARCHAR(10),
    FOREIGN KEY (JOB_ID) REFERENCES jobs(JOB_ID),
    SALARY DECIMAL(7,2),
    COMMISSION_PCT DECIMAL(5,2),
    MANAGER_ID INT,
    DEPARTMENT_ID INT ,
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES departments(DEPARTMENT_ID)
);
CREATE TABLE job_history(
	EMPLOYEE_ID INT,
    START_DATE DATE,
    PRIMARY KEY (EMPLOYEE_ID, START_DATE),
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES employees(EMPLOYEE_ID),
    END_DATE DATE,
    JOB_ID VARCHAR(10),
    FOREIGN KEY (JOB_ID) REFERENCES jobs(JOB_ID),
    DEPARTMENT_ID INT ,
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES departments(DEPARTMENT_ID) 
);

insert into regions (REGION_ID,REGION_NAME) values (1,'Europe');
insert into regions (REGION_ID,REGION_NAME) values (2,'North America');
insert into regions (REGION_ID,REGION_NAME) values (3,'Pacific Asia');
insert into regions (REGION_ID,REGION_NAME) values (4,'Africa');
insert into regions (REGION_ID,REGION_NAME) values (5,'South America');
insert into regions (REGION_ID,REGION_NAME) values (6,'Arab');

insert into countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CN','The People\'s Republic of China',3);
insert into countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('TW','Taiwan, The People\'s Republic of China',3);
insert into countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('JP','Japan',3);
insert into countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('KR','Korea',3);
insert into countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DE','Germany',1);
insert into countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IT','ITALY',1);
insert into countries (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('US','United State',2);


-- insert into locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1, );
-- HK  11xx, china 10xx, taiwan 12xx
insert into locations (LOCATION_ID,STREET_ADDRESS,CITY,STATE_PROVINCE,COUNTRY_ID) values (1101, 'No.121 Queens\'s Road', 'Hong Kong', 'SAR', 'CN' );
insert into locations (LOCATION_ID,STREET_ADDRESS,CITY,STATE_PROVINCE,COUNTRY_ID) values (1102, 'No.303 Nathan Road', 'Hong Kong', 'SAR', 'CN' );
insert into locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1201, 'No.2, Zhonghua Rd.','108459','Wanhua','Taipei','TW');
insert into locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1000, '1297 Via Cola di Rie','989','Roma',null,'IT');
insert into locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1100, '93091 Calle della te','10934','Venice',null,'IT');
insert into locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1200, '2017 Shinjuku-ku','1689','Tokyo','Tokyo JP',null);
insert into locations (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1400, '2014 Jabberwocky Rd','26192','Southlake','Texas','US');

insert into jobs (JOB_ID, JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('IT_PROG','IT Programmer', 17000.00,21000.00);
insert into jobs (JOB_ID, JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_REP','Marketing Representative', 20000.00,26000.00);
insert into jobs (JOB_ID, JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_CLERK','Administration Clerk', 16000.00,20000.00);
insert into jobs (JOB_ID, JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('IT_MAN','IT Manager', 30000.00,40000.00);
insert into jobs (JOB_ID, JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_MAN','Administration Manager', 30000.00,40000.00);
insert into jobs (JOB_ID, JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_MAN','Marketing Manager', 35000.00,45000.00);
insert into jobs (JOB_ID, JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_CLERK','Store Clerk', 20000.00,25000.00);

insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (10,'Administration',400,1101);
insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (11,'Marketing',300,1101);
insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (12,'Information Technology',500,1101);
insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (20,'Marketing',201,1200);
insert into departments (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (30,'Purchasing',202,1400);

-- insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) 
-- values (300,'Bob','Lam','boblam@gmail.com','98765412','2018-01-10','IT_MAN',35000.00,);
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,DEPARTMENT_ID) 
values (500,'Bob','Lam','boblam@gmail.com','98765412','2018-01-10','IT_MAN',35000.00,12);
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,DEPARTMENT_ID) 
values (400,'Angel','Li','angelli@gmail.com','91234567','2016-12-11','AD_MAN',35000.00,10);
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,DEPARTMENT_ID) 
values (300,'Tom','Au','tomau@gmail.com','54961234','2015-12-11','MK_MAN',38000.00,11);
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,MANAGER_ID,DEPARTMENT_ID) 
values (501,'Terry','Bo','terrybo@gmail.com','64231578','2020-10-10','IT_PROG',20000.00,500,12);
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,MANAGER_ID,DEPARTMENT_ID) 
values (100,'Steven','King','SKING','515-1234567','1987-06-17','ST_CLERK',24000.00,109,10);
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,MANAGER_ID,DEPARTMENT_ID) 
values (101,'Neena','Kochhar','NKOCHHAR','515-1234568','1987-06-18','MK_REP',17000.00,103,20);
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,MANAGER_ID,DEPARTMENT_ID) 
values (102,'Lex','De Haan','LDEHAAN','515-1234569','1987-06-19','IT_PROG',17000.00,108,30);
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,MANAGER_ID,DEPARTMENT_ID) 
values (103,'Alexander','Hunold','AHUNOLD','590-4234567','1987-06-20','MK_REP',9000.00,105,20);

insert into job_history (EMPLOYEE_ID,START_DATE,JOB_ID,DEPARTMENT_ID) values (300,'2015-12-11','MK_MAN', 11);
insert into job_history (EMPLOYEE_ID,START_DATE,JOB_ID,DEPARTMENT_ID) values (400,'2016-12-11','AD_MAN', 10);
insert into job_history (EMPLOYEE_ID,START_DATE,JOB_ID,DEPARTMENT_ID) values (500,'2018-01-10','IT_MAN', 12);
insert into job_history (EMPLOYEE_ID,START_DATE,JOB_ID,DEPARTMENT_ID) values (501,'2020-10-10','IT_PROG', 12);
insert into job_history (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (102,'1993-01-13','1998-07-24','IT_PROG', 20);
insert into job_history (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (101,'1989-09-21','1993-10-27','MK_REP', 10);
insert into job_history (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (101,'1993-10-28','1997-03-15','MK_REP', 30);
insert into job_history (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (100,'1996-02-17','1999-12-19','ST_CLERK', 30);
insert into job_history (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (103,'1998-03-24','1999-12-31','MK_REP', 20);

select * from locations;

select FIRST_NAME,LAST_NAME,DEPARTMENT_ID from employees;

select e.FIRST_NAME,e.LAST_NAME,e.DEPARTMENT_ID from employees e
join departments d on 
e.DEPARTMENT_ID = d.DEPARTMENT_ID
join locations l on 
d.LOCATION_ID = l.LOCATION_ID
join countries c on
c.COUNTRY_ID = l.COUNTRY_ID
where c.COUNTRY_ID = 'JP';

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, MANAGER_ID from employees;

select FIRST_NAME, LAST_NAME,hire_date from employees where hire_date >(select hire_date from employees where FIRST_NAME='Lex' and LAST_NAME='De Haan');

select d.department_id, count(1) from departments d join employees e on d.DEPARTMENT_ID = e.DEPARTMENT_ID group by d.department_id;

select e.employee_id, j.job_title,DATEDIFF(jh.end_date,jh.start_date) from  employees e join job_history jh on e.employee_id = jh.employee_id 
join jobs j on e.JOB_ID = j.JOB_ID;

select d.department_name, concat(e.first_name,' ',  e.last_name),l.city,c.country_name  from departments d 
left join locations l on d.location_id = l.location_id
left join employees e on d.manager_id = e.employee_id
left join countries c on l.country_id = c.country_id;

select d.department_id, avg(e.salary) from departments d join employees e
on d.department_id = e.department_id group by d.department_id;