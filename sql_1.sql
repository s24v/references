/*
https://docs.oracle.com/cd/E17781_01/admin.112/e18585/toc.htm#XEGSG111
-- ORACLE COMMON COMMANDS
1 connect username/password -- to connect database user LOCALLY (default username is system password for it is same set at installation time)
  connect username/password@[//]host[:port][/service_name] -- to connect database user REMOTELY 
  connect sys/password as sysdba -- to startup and shutdown db instance logging with sys account is mandatory
2 create user chris identified by <password-for-chris>; -- USER CREATION
3 grant CREATE SESSION, ALTER SESSION, CREATE DATABASE LINK, 
  CREATE MATERIALIZED VIEW, CREATE PROCEDURE, CREATE PUBLIC SYNONYM, 
  CREATE ROLE, CREATE SEQUENCE, CREATE SYNONYM, CREATE TABLE, 
  CREATE TRIGGER, CREATE TYPE, CREATE VIEW, UNLIMITED TABLESPACE 
  to chris;
-- Unlock user account + Stting password for it. login using system to do it. 
4 ALTER USER hr ACCOUNT UNLOCK;
5 ALTER USER hr IDENTIFIED BY <hr-password>;
-- To get date/time
6 select sysdate, CURRENT_DATE, CURRENT_TIMESTAMP, TO_CHAR(CURRENT_TIMESTAMP,'MONTH') from dual;
O/P --> 07-FEB-17	07-FEB-17	07-FEB-17 01.27.43.000000000 PM ASIA/CALCUTTA	FEBRUARY 
-- To get Object information
7 SELECT * FROM ALL_OBJECTS where object_type = 'TABLE' and owner = 'SAURABH' and object_name = 'A';
-- ORACLE connecting to database
sqlplus / as sysdba
-- Starting and shutting ORACLE INSTANCE
SQL> STARTUP
SQL> SHUTDOWN IMMEDIATE
SQL> SHUTDOWN ABORT -- incase shutdown taking time, this can be used
-- ORACLE NET LISTENER
	+ oracle can be connected locally and remotely.
	+ two types of connection request in Oracle 
		 - database, uses TCP/IP default port 1521
		 - HTTP, default port is 8080
	+ listener is required for :
		Connection Type	Local Connection	Remote Connection
		Database		Not required		Required
		HTTP			Required			Required
	+ lsnrctl status - to check status of lsnr, you have to login as sys user, and execute this command in cmd prompt
	+ lsnrctl start
	+ lsnrctl stop
--SELECT * FROM DBA_TAB_STATISTICS; to see stats
*/

/* EXAMPLE 1 - Mysql LEFT JOINing same table twice */
create table customers
(
    id int not null,
    name varchar(20),
    primary key (id)
);
create table purchases
(
    owner_id int not null,
    type varchar(20),
    quant int not null,
    key (owner_id,type)
); 
		insert into customers (id,name) values (1,'Matt'),(3,'John');
		insert into purchases (owner_id,type,quant) values
		(3,'cat',3),(3,'cat',2),(1,'cat',4),(1,'dog',1),(1,'dog',2);
		select * from customers;
		select * from purchases;
/*Query 1*/
	select c.id, c.name, 
	dog.quant as dog_quant,
	cat.quant as cat_quant
	from customers c
	left join (select owner_id, sum(quant) as quant from
			   purchases where type = 'cat' 
			   group by owner_id) cat
	ON c.id = cat.owner_id
	left join (select owner_id, sum(quant) as quant from 
			  purchases where type = 'dog'
			  group by owner_id) dog
	ON c.id = dog.owner_id;
/*Query 2*/
	select c.id, 
	sum(case when p.type = 'cat' then p.quant else NULL end) cat_quant,
	sum(case when p.type = 'dog' then p.quant else NULL end) dog_quant
	from customers c 
	inner join purchases p 
	ON c.id = p.owner_id
	group by c.id;

/* EXAMPLE 2 - Mysql LEFT JOINing same table */
 CREATE TABLE "SAURABH"."MEMBERS" 
   (	"MEMBER_ID" NUMBER, 
	"NAME" VARCHAR2(20 BYTE), 
	"ACTIVE" NUMBER
   );
Insert into SAURABH.MEMBERS (MEMBER_ID,NAME,ACTIVE) values (105,'Andri  ',1);
Insert into SAURABH.MEMBERS (MEMBER_ID,NAME,ACTIVE) values (106,'Steve',1);
Insert into SAURABH.MEMBERS (MEMBER_ID,NAME,ACTIVE) values (110,'Soraya',1);
Insert into SAURABH.MEMBERS (MEMBER_ID,NAME,ACTIVE) values (111,'Eva',1);
Insert into SAURABH.MEMBERS (MEMBER_ID,NAME,ACTIVE) values (112,'Sonia',1);
 CREATE TABLE "SAURABH"."SAVINGS" 
   (	"SAVINGS_ID" NUMBER, 
	"MEMBER_ID" NUMBER, 
	"MONTH" NUMBER, 
	"YEAR" NUMBER, 
	"AMOUNT" NUMBER, 
	"TYPE" NUMBER, 
	"PAID" NUMBER
   );
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (1,105,7,2014,4000,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (2,105,7,2014,5000,2,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (3,105,7,2014,3000,3,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (4,105,7,2014,3000,4,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (5,106,7,2014,2000,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (6,106,7,2014,1000,2,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (7,106,7,2014,3000,3,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (8,106,7,2014,2000,4,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (9,110,7,2014,1500,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (10,110,7,2014,2500,2,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (11,111,7,2014,3500,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (12,112,7,2014,4500,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (13,112,7,2014,2000,2,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (14,105,7,null,1000,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (15,106,7,null,1000,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (16,110,7,null,1000,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (17,111,7,null,1000,1,1);
Insert into SAURABH.SAVINGS (SAVINGS_ID,MEMBER_ID,MONTH,YEAR,AMOUNT,TYPE,PAID) values (18,112,7,null,1000,1,1);
/*Query 1*/ 
SELECT m.member_id,
SUM(s1.amount) as savings1,
SUM(s2.amount) as savings2,
SUM(s3.amount) as savings3,
SUM(s4.amount) as savings4,
SUM(s5.amount) as savings5
FROM members m
LEFT JOIN savings s1 ON s1.member_id = m.member_id AND s1.type = 1 AND s1.paid = 1
LEFT JOIN savings s2 ON s2.member_id = m.member_id AND s2.type = 2 AND s2.paid = 1
LEFT JOIN savings s3 ON s3.member_id = m.member_id AND s3.type = 3 AND s3.paid = 1
LEFT JOIN savings s4 ON s4.member_id = m.member_id AND s4.type = 4 AND s4.paid = 1
LEFT JOIN savings s5 ON s5.member_id = m.member_id AND s5.type = 5 AND s5.paid = 1
WHERE 
active = 1
GROUP BY m.member_id
ORDER BY m.member_id;
/*Query 2*/ 
	SELECT 
	m.member_id,
	SUM(case when s.type= 1 then s.amount end) as savings1,
	SUM(case when s.type= 2 then s.amount end) as savings2,
	SUM(case when s.type= 3 then s.amount end) as savings3,
	SUM(case when s.type= 4 then s.amount end) as savings4,
	SUM(case when s.type= 5 then s.amount end) as savings5
	FROM savings s
	LEFT JOIN members m on m.member_id = s.member_id
	WHERE 
	m.active = 1
	GROUP BY m.member_id;

/*Example 3 - ROLLBACK in ORACLE
	--	if statement is not commited then it will be deleted when doing ROLLBACK
*/
drop table A;
create table A(id INT);
insert into A values(1);
insert into A values(2);
insert into A values(3);
insert into A values(4);
select count(*) from A; --4
insert into A values(5);
rollback;
select count(*) from A;--0
insert into A values(6);
insert into A values(7);
insert into A values(8);
create table B AS select * from A;
rollback;
select count(*) from A;--3

-- USING COMMITdrop table A;
create table A(id INT);
insert into A values(1);
insert into A values(2);
insert into A values(3);
insert into A values(4);
commit;
select count(*) from A; --4
insert into A values(5);
commit;
rollback;
select count(*) from A; --5
insert into A values(6);
insert into A values(7);
insert into A values(8);
create table B AS select * from A;
rollback;
select count(*) from A;--3