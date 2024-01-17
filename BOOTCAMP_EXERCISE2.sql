CREATE DATABASE ORG;

USE ORG;

CREATE TABLE WORKER (
	WORKER_ID SERIAL PRIMARY KEY,
	FIRST_NAME VARCHAR(25),
	LAST_NAME VARCHAR(25),
	SALARY DECIMAL(8,2),
	JOINING_DATE DATE,
	DEPARTMENT VARCHAR(25)
);

INSERT INTO WORKER 
(FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES
('Monika', 'Arora',100000,'2021-02-20 09:00:00','HR'),
('Niharika', 'Verma',80000,'2021-06-11 09:00:00','Admin'),
('Vishal', 'Singhal',300000,'2021-02-20 09:00:00','HR'),
('Mohan', 'Sarah',300000,'2012-03-19 09:00:00','Admin'),
('Amitabh', 'Singh',500000,'2021-02-20 09:00:00','Admin'),
('Vivek', 'Bhati',490000,'2021-06-11 09:00:00','Admin'),
('Vipul', 'Diwan',200000,'2021-06-11 09:00:00','Account'),
('Satish', 'Kumar',75000,'2021-01-20 09:00:00','Account'),
('Geetika', 'Chauhan',90000,'2021-04-11 09:00:00','Admin');
SELECT * FROM WORKER;
CREATE TABLE BONUS (
	WORKER_REF_ID INTEGER,
	BONUS_AMOUNT DECIMAL(8,2),
	BONUS_DATE DATE,
	FOREIGN KEY (WORKER_REF_ID) REFERENCES WORKER(WORKER_ID)
);
-- TASK 1
INSERT INTO BONUS
(WORKER_REF_ID,BONUS_AMOUNT,BONUS_DATE)
VALUES
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME='Vivek' ),32000,'2021-11-02'),
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME='Vivek' ),20000,'2022-11-02'),
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME='Amitabh' ),21000,'2021-11-02'),
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME='Geetika' ),30000,'2021-11-02'),
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME='Satish' ),4500,'2022-11-02')
;
SELECT * FROM BONUS;
-- TASK 2
SELECT SALARY FROM WORKER 
ORDER BY SALARY DESC
LIMIT 1 OFFSET 1;
--TASK 3
SELECT W1.FIRST_NAME,W2.SALARY, W2.DEPARTMENT FROM WORKER W1 JOIN
(SELECT MAX(SALARY) AS SALARY, DEPARTMENT FROM WORKER GROUP BY DEPARTMENT) W2
ON W1.SALARY = W2.SALARY;
-- TASK 4
SELECT W1.FIRST_NAME, W1.SALARY FROM WORKER W1
JOIN WORKER W2
ON W1.SALARY = W2.SALARY
WHERE W1.FIRST_NAME<>W2.FIRST_NAME;
-- TASK 5
SELECT W.WORKER_ID,W.FIRST_NAME, W.SALARY,B.BONUS 
FROM WORKER W 
LEFT JOIN 
(SELECT WORKER_REF_ID, TO_CHAR(BONUS_DATE,'YYYY') BONUS_YEAR, SUM(BONUS_AMOUNT) BONUS FROM BONUS
GROUP BY WORKER_REF_ID, TO_CHAR(BONUS_DATE,'YYYY'))B
ON W.WORKER_ID = B.WORKER_REF_ID
WHERE B.BONUS_YEAR='2021';
--TASK 6
-- cannot delete rows in WORKER because its WORKER_ID is foreign key of bonus
--TASK 7
-- cannot delete table WORKER because its WORKER_ID is foreign key of bonus