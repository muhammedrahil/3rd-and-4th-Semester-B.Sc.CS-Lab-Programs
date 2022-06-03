drop database Grade_status;
create database Grade_status;
use Grade_status;
create table Stud_mark(roll_no int unique,register_no int primary key,s_name varchar(20),avg_score int(3));
insert into stud_mark(roll_no,register_no,s_name,avg_score)values(1,2512 ,"saimon",64 ),(2,4594 ,"Arshad",85 ), 
(3,3223,"Anoop" , 70 ) , (4,4442 ,"Madav" ,50  ) , (5,5232,"Kiran" , 90 ) , (6,6232 ,"Maya", 95  ),(7,5598,"Vayshag",49)  ;  
select *from stud_mark;
create table status_class(Distinction int,first_Class int,Second_Class int,Third_Class int,Fail int);


DELIMITER //
create procedure Grade()
exit_label:BEGIN
DECLARE dst,fst,scd,thd,fail,sno,count,i,avg,roll  int;
     set count=(select count(register_no)from Stud_mark);
     set i=1;
     set dst=0;
     set fst=0;            
     set scd=0;            
     set thd=0;            
     set fail=0;                        
     while i!=count+1 do
           set roll=(select register_no from Stud_mark where roll_no=i);
           set avg=(select avg_score from Stud_mark where register_no=roll);
           if avg between 90 and 100 then
             set  dst=dst+1;
           end if;
           if avg between 75 and 89 then
             set  fst=fst+1;
           end if;
           if avg between 60 and 74 then
              set  scd=scd+1;
           end if;
           if avg between 50 and 59 then
              set  thd=thd+1;
           end if;
           if avg<50 then
              set  fail=fail+1;
           end if;
              set i=i+1;
            end while;
      insert into status_class values(dst,fst,scd,thd,fail);
      select *from status_class;
       LEAVE exit_label;
               end//
        DELIMITER ;
call grade;
+-------------+-------------+--------------+-------------+------+
| Distinction | first_Class | Second_Class | Third_Class | Fail |
+-------------+-------------+--------------+-------------+------+
|           2 |           1 |            2 |           1 |    1 |
+-------------+-------------+--------------+-------------+------+