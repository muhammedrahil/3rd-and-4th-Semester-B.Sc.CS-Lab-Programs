create database Result;
use Result;

create table Exam_result(roll_no int primary key,avg_score int(3),Grade varchar(1));

insert into Exam_result(roll_no,avg_score,grade)values(1 , 85 , NULL ) , (2 , 80 , NULL ), 
(3 , 70 , NULL ) , (4 , 85 , NULL ) ,   
(5 , 90 , NULL ) , (6 , 95 , NULL ) ,   
(7 , 99 , NULL ) , (8 , 65 , NULL ) ,   
(9 , 49 , NULL ) , (10, 55 , NULL ) ;    
       
select * from Exam_result;
+---------+-----------+-------+
| roll_no | avg_score | Grade |
+---------+-----------+-------+
|       1 |        85 | NULL  |
|       2 |        80 | NULL  |
|       3 |        70 | NULL  |
|       4 |        85 | NULL  |
|       5 |        90 | NULL  |
|       6 |        95 | NULL  |
|       7 |        99 | NULL  |
|       8 |        65 | NULL  |
|       9 |        49 | NULL  |
|      10 |        55 | NULL  |
+---------+-----------+-------+


 DELIMITER //
     create procedure Grade()
          exit_label:BEGIN
            DECLARE avg,count,roll,i int;
            set count=(select count(roll_no)from exam_result);
            set i=1;
                 while i!=count+1 do
                 set roll=(select roll_no from Exam_result where roll_no=i);
                 set avg=(select avg_score from exam_result where roll_no=roll);
                   if avg between 90 and 100 then
                      update exam_result set Grade="A" where roll_no=roll;
                   end if;
                   if avg between 75 and 89 then
                      update exam_result set Grade="B" where roll_no=roll;
                   end if;
                   if avg between 60 and 74 then
                      update exam_result set Grade="C" where roll_no=roll;
                   end if;
                   if avg between 50 and 59 then
                      update exam_result set Grade="D" where roll_no=roll;
                   end if;
                   if avg<50 then
                      update exam_result set Grade="E" where roll_no=roll;
                   end if;
                      set i=i+1;
                  end while;
             select *from exam_result;
               LEAVE exit_label;
          end//
DELIMITER ;
CALL Grade();
+---------+-----------+-------+
| roll_no | avg_score | Grade |
+---------+-----------+-------+
|       1 |        85 | B     |
|       2 |        80 | B     |
|       3 |        70 | C     |
|       4 |        85 | B     |
|       5 |        90 | A     |
|       6 |        95 | A     |
|       7 |        99 | A     |
|       8 |        65 | C     |
|       9 |        49 | E     |
|      10 |        55 | D     |
+---------+-----------+-------+