select * from emp where empno >= 7876;

select ename, empno, mgr, job, level, sys_connect_by_path(ename,'/') from emp
--start with empno = 7876
connect by prior empno = mgr;

select level-1 from dual connect by level <= 7 ;


SELECT  C_DATE,
        TO_CHAR(C_DATE,'DY') 
FROM 
(
  SELECT TO_DATE('01-JAN-2000','DD-MON-YYYY')+LEVEL-1 C_DATE 
  FROM   DUAL 
  CONNECT BY LEVEL <= 
       (SYSDATE - TO_DATE('01-JAN-2000','DD-MON-YYYY')+1) 
)
WHERE TO_CHAR(C_DATE,'DY') = 'FRI'; 


create table T (products varchar2(100), repeat number);
insert into T values('A,',3);
insert into T values('B,',2);
insert into T values('C,',4);
commit;

select * from T;
SELECT PRODUCTS,
       REPEAT 
       ,A.L
FROM   T, 
      ( SELECT LEVEL L FROM DUAL 
        CONNECT BY LEVEL <= (SELECT MAX(REPEAT) FROM T) 
      ) A 
WHERE T.REPEAT >= A.L 
ORDER BY T.PRODUCTS;

select level, substr('SMILE',level,1) from dual connect by level <= length('SMILE');

SELECT substr(DUMP('SMILE'), 0)
FROM DUAL;

select ascii('A') from dual;

select wm_concat(S) from (
select level S from dual connect by level <=8
);

SELECT concat(A ,',')
FROM 
(
SELECT ASCII(SUBSTR('SMILE',LEVEL,1)) A 
FROM   DUAL 
CONNECT BY LEVEL <=LENGTH('SMILE') 
);

select localtimestamp
--,localtimestamp
--,add_months(sysdate,1)
--,systimestamp
--,to_char(current_timestamp,'dd-mm-yy hh-mi-ssxff pm tzh:tzm tzr')
--,extract(timezone_minute from current_timestamp) tzm
--,LAST_DAY(SYSDATE)
--,LAST_DAY(SYSDATE) - SYSDATE "Days Left"
--,months_between(sysdate, sysdate + 120) m_b
--,next_day(sysdate, 'monday')
,round (sysdate,'year') r_y, round(systimestamp, 'mi')
,trunc(sysdate,'year') t_y, round(systimestamp, 'mi') t_m
--,sys_extract_utc(systimestamp)
--,to_date('12 jan 2017', 'dd mon yyyy') 
from dual;
