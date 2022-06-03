
create database salary_report;

use salary_report;

create table salaries(sno int,EmpNo varchar(10) primary key,EName varchar(20),Basic_pay Numeric(6),DA Numeric,Gross_salary Numeric,PF Numeric,Net_salary Numeric,Annual_salary numeric,Tax Numeric);

insert into salaries(sno,EmpNo,EName,Basic_pay,DA,Gross_salary,PF,Net_salary,Annual_salary,Tax)
values(1,"E001","Sunil",10000,NULL,NULL,NULL,NULL,NULL,NULL),
(2,"E002","Ram",20000,NULL,NULL,NULL,NULL,NULL,NULL),
(3,"E003","Rahul",30000,NULL,NULL,NULL,NULL,NULL,NULL),
(4,"E004","Vishnu",40000,NULL,NULL,NULL,NULL,NULL,NULL),
(5,"E005","Shahul",50000,NULL,NULL,NULL,NULL,NULL,NULL),
(6,"E006","shahid",75000,NULL,NULL,NULL,NULL,NULL,NULL),
(7,"E007","Anuoop",65000,NULL,NULL,NULL,NULL,NULL,NULL),
(8,"E008","Anu",85000,NULL,NULL,NULL,NULL,NULL,NULL),
(9,"E009","Vedika",92000,NULL,NULL,NULL,NULL,NULL,NULL),
(10,"E0010","Vivek",40000,NULL,NULL,NULL,NULL,NULL,NULL);

select *from salaries;

+------+-------+--------+-----------+------+--------------+------+------------+---------------+------+
| sno  | EmpNo | EName  | Basic_pay | DA   | Gross_salary | PF   | Net_salary | Annual_salary | Tax  |
+------+-------+--------+-----------+------+--------------+------+------------+---------------+------+
|    1 | E001  | Sunil  |     10000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|   10 | E0010 | Vivek  |     40000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|    2 | E002  | Ram    |     20000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|    3 | E003  | Rahul  |     30000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|    4 | E004  | Vishnu |     40000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|    5 | E005  | Shahul |     50000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|    6 | E006  | shahid |     75000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|    7 | E007  | Anuoop |     65000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|    8 | E008  | Anu    |     85000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
|    9 | E009  | Vedika |     92000 | NULL |         NULL | NULL |       NULL |          NULL | NULL |
+------+-------+--------+-----------+------+--------------+------+------------+---------------+------+
#procedure to calculate tax

DELIMITER //
create procedure tax(in salary Numeric,EmpNo1 varchar(6))
begin
declare salary1,Tax1,excess1 Numeric;
declare EmpNo2 varchar(6);
set salary1=salary;
set EmpNo2=EmpNo1;
if salary<100000 then
  set Tax1=NULL;
  update salaries set Tax=Tax1 where EmpNo=EmpNo2;  
end if;
if salary>100000 and salary<=150000 then
  set excess1=(salary-100000);
  set Tax1=((excess1*10)/100);
  update salaries set Tax=Tax1 where EmpNo=EmpNo2;  
end if;
if salary>150000 and salary<=250000 then
  set excess1=(salary-150000);
  set Tax1=((excess1*20)/100);
  update salaries set Tax=Tax1 where EmpNo=EmpNo2;  
end if;
if salary>250000 then
  set excess1=(salary-250000);
  set Tax1=((excess1*30)/100);
  update salaries set Tax=Tax1 where EmpNo=EmpNo2;  
end if;
end//

# procedure to calculate another items

create procedure salary()
exit_label:begin
    declare count1,i int;
    declare EmpNo1 varchar(6);
    declare Basic_pay,DA1,PF1,Gross_salary1,Net_salary1,Annual_salary1,Tax1 Numeric(7);
    set count1=(select count(EmpNo)from salaries);
    set i=1;
    WHILE i!=count1+1 do
     set EmpNo1=(select EmpNo from salaries where sno=i);
     IF EmpNo1=EmpNo1 THEN
        set Basic_pay=(select salaries.Basic_pay from salaries where EmpNo=EmpNo1);
        set DA1=((Basic_pay*40)/100);
        set PF1=((Basic_pay*10)/100);
        set Gross_salary1=(Basic_pay+DA1);
        set Net_salary1=(Gross_salary1-PF1);
        set Annual_salary1=(12*Net_salary1);
        call tax(Annual_salary1,EmpNo1);
        update salaries set DA=DA1 where EmpNo=EmpNo1;
        update salaries set PF=PF1 where EmpNo=EmpNo1;
        update salaries set Gross_salary=Gross_salary1 where EmpNo=EmpNo1;
        update salaries set Net_salary=Net_salary1 where EmpNo=EmpNo1;
        update salaries set Annual_salary=Annual_salary1 where EmpNo=EmpNo1;
     END IF;
     set i=i+1;
    END WHILE;
    select *from salaries  order by sno asc;
LEAVE exit_label;
END//

DELIMITER ;
CALL salary;

+------+-------+--------+-----------+-------+--------------+------+------------+---------------+--------+
| sno  | EmpNo | EName  | Basic_pay | DA    | Gross_salary | PF   | Net_salary | Annual_salary | Tax    |
+------+-------+--------+-----------+-------+--------------+------+------------+---------------+--------+
|    1 | E001  | Sunil  |     10000 |  4000 |        14000 | 1000 |      13000 |        156000 |   1200 |
|    2 | E002  | Ram    |     20000 |  8000 |        28000 | 2000 |      26000 |        312000 |  18600 |
|    3 | E003  | Rahul  |     30000 | 12000 |        42000 | 3000 |      39000 |        468000 |  65400 |
|    4 | E004  | Vishnu |     40000 | 16000 |        56000 | 4000 |      52000 |        624000 | 112200 |
|    5 | E005  | Shahul |     50000 | 20000 |        70000 | 5000 |      65000 |        780000 | 159000 |
|    6 | E006  | shahid |     75000 | 30000 |       105000 | 7500 |      97500 |       1170000 | 276000 |
|    7 | E007  | Anuoop |     65000 | 26000 |        91000 | 6500 |      84500 |       1014000 | 229200 |
|    8 | E008  | Anu    |     85000 | 34000 |       119000 | 8500 |     110500 |       1326000 | 322800 |
|    9 | E009  | Vedika |     92000 | 36800 |       128800 | 9200 |     119600 |       1435200 | 355560 |
|   10 | E0010 | Vivek  |     40000 | 16000 |        56000 | 4000 |      52000 |        624000 | 112200 |
+------+-------+--------+-----------+-------+--------------+------+------------+---------------+--------+

